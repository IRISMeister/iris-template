Class MyApps.Installer
{

ClassMethod setup(ByRef tVars) As %Status
{
  New $NAMESPACE
  Set oldns=$NAMESPACE
  Set tSC='$$$OK
  Try {

    Set $NAMESPACE="USER"
    Set tSC=..appsetup(.tVars)
    Set tSC=$$$OK
  } Catch(e) {
	  Set tSC=e.AsStatus()
    zw tSC
  }
  Set $NAMESPACE=oldns
  Return tSC
}

ClassMethod appsetup(ByRef tVars) As %Status
{
  Set tSC='$$$OK
  Try {
    Set tSC=$SYSTEM.OBJ.ImportDir("/home/irisowner/irisdev/src","*","ck",.errorlog,1)

		Set rs=##class(%ResultSet).%New("%File:FileSet") d rs.Execute("/home/irisowner/irisdev/sql","*.sql")
		While(rs.Next()) { Do $SYSTEM.SQL.Schema.ImportDDL(rs.Name,"/home/irisowner/irisdev/import_Errors.log") }

  } Catch(e) {
	  Set tSC=e.AsStatus()
    zw tSC
  }
  Return tSC
}

}
