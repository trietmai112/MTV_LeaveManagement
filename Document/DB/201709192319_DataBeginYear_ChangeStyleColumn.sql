/*
   Tuesday, September 19, 201711:53:11 PM
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
ALTER TABLE dbo.DataBeginYear
	DROP CONSTRAINT FK_DataBeginYear_User
GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_DataBeginYear
	(
	Id int NOT NULL IDENTITY (1, 1),
	Uid int NOT NULL,
	AnnualLeave float(53) NOT NULL,
	DateBegin date NOT NULL,
	UserCreated int NOT NULL,
	UserUpdated int NOT NULL,
	DateCreated datetime NOT NULL,
	DateUpdated datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DataBeginYear SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DataBeginYear ON
GO
IF EXISTS(SELECT * FROM dbo.DataBeginYear)
	 EXEC('INSERT INTO dbo.Tmp_DataBeginYear (Id, Uid, AnnualLeave, DateBegin, UserCreated, UserUpdated, DateCreated, DateUpdated)
		SELECT Id, Uid, CONVERT(float(53), AnnualLeave), DateBegin, UserCreated, UserUpdated, DateCreated, DateUpdated FROM dbo.DataBeginYear WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DataBeginYear OFF
GO
DROP TABLE dbo.DataBeginYear
GO
EXECUTE sp_rename N'dbo.Tmp_DataBeginYear', N'DataBeginYear', 'OBJECT' 
GO
ALTER TABLE dbo.DataBeginYear ADD CONSTRAINT
	PK_DataBeginYear PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.DataBeginYear ADD CONSTRAINT
	FK_DataBeginYear_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
