CREATE TABLE Person (PID INTEGER PRIMARY KEY, name VARCHAR(50), born INTEGER)
GO
CREATE INDEX idxName ON Person(name)
GO
INSERT INTO Person VALUES (1,'キアヌ・リーブス',1964)
GO
INSERT INTO Person VALUES (2,'キャリー＝アン・モス',1967)
GO
INSERT INTO Person VALUES (3,'ローレンス・フィッシュバーン', 1961)
GO
INSERT INTO Person VALUES (4,'ヒューゴ・ウィーヴィング', 1960)
GO
INSERT INTO Person VALUES (5,'リリー・ウォシャウスキー', 1967)
GO
INSERT INTO Person VALUES (6,'ラナ・ウォシャウスキー', 1965)
GO
INSERT INTO Person VALUES (7,'ジョエル・シルバー', 1952)
GO
