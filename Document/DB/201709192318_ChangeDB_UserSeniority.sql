/*
   Tuesday, September 19, 201711:38:21 PM
   User: 
   Server: .
   Database: LeaveManagement
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.UserSeniority
	DROP CONSTRAINT FK_UserSeniority_User
GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_UserSeniority
	(
	Id int NOT NULL IDENTITY (1, 1),
	Uid int NOT NULL,
	Year int NULL,
	Month1 tinyint NULL,
	Month2 tinyint NULL,
	Month3 tinyint NULL,
	Month4 tinyint NULL,
	Month5 tinyint NULL,
	Month6 tinyint NULL,
	Month7 tinyint NULL,
	Month8 tinyint NULL,
	Month9 tinyint NULL,
	Month10 tinyint NULL,
	Month11 tinyint NULL,
	Month12 tinyint NULL,
	UserCreated int NOT NULL,
	UserUpdated int NOT NULL,
	DateCreated datetime NOT NULL,
	DateUpdated datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_UserSeniority SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_UserSeniority ON
GO
IF EXISTS(SELECT * FROM dbo.UserSeniority)
	 EXEC('INSERT INTO dbo.Tmp_UserSeniority (Id, Uid, UserCreated, UserUpdated, DateCreated, DateUpdated)
		SELECT Id, Uid, UserCreated, UserUpdated, DateCreated, DateUpdated FROM dbo.UserSeniority WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_UserSeniority OFF
GO
DROP TABLE dbo.UserSeniority
GO
EXECUTE sp_rename N'dbo.Tmp_UserSeniority', N'UserSeniority', 'OBJECT' 
GO
ALTER TABLE dbo.UserSeniority ADD CONSTRAINT
	PK_UserSeniority PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.UserSeniority ADD CONSTRAINT
	FK_UserSeniority_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
