FROM containers.intersystems.com/intersystems/iris-community:2022.3.0.589.0

ARG COMMIT_ID="unknown"

#USER root
#ENV DEBIAN_FRONTEND noninteractive
#RUN apt-get update && apt-get install -y tzdata
### IRIS itself doesn't require ja language pack
#RUN apt-get update && apt-get install -y language-pack-ja && update-locale LANG=ja_JP.UTF-8
#USER irisowner

WORKDIR /home/irisowner/irisdev

ENV INITDIR=init
ENV SRCDIR=src
ENV SQLDIR=sql

COPY --chown=$ISC_PACKAGE_IRISUSER:$ISC_PACKAGE_IRISGROUP init/ $INITDIR/
COPY --chown=$ISC_PACKAGE_IRISUSER:$ISC_PACKAGE_IRISGROUP src/ $SRCDIR/
COPY --chown=$ISC_PACKAGE_IRISUSER:$ISC_PACKAGE_IRISGROUP sql/ $SQLDIR/

RUN iris start $ISC_PACKAGE_INSTANCENAME \ 
 && printf 'Do ##class(Config.NLS.Locales).Install("jpuw") h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS \
 && printf 'Set tSC=$system.OBJ.Load("'$HOME/irisdev/$INITDIR'/MyApps/Installer.cls","ck") Do:+tSC=0 $SYSTEM.Process.Terminate($JOB,1) h\n' | iris session $ISC_PACKAGE_INSTANCENAME \
 && printf 'Set tSC=##class(MyApps.Installer).setup() Do:+tSC=0 $SYSTEM.Process.Terminate($JOB,1) h\n' | iris session $ISC_PACKAGE_INSTANCENAME \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly

RUN iris start $ISC_PACKAGE_INSTANCENAME nostu quietly \
 && printf "kill ^%%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") h\n" | iris session $ISC_PACKAGE_INSTANCENAME -B | cat \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly bypass \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log \
 && touch $ISC_PACKAGE_INSTALLDIR/mgr/messages.log \
 && echo $COMMIT_ID > $HOME/commit.txt

