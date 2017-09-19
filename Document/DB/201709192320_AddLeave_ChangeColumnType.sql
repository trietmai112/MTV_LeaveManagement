/*
   Wednesday, September 20, 201712:15:17 AM
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
ALTER TABLE dbo.AddLeave
	DROP CONSTRAINT FK_AddLeave_User
GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.AddLeave
	DROP CONSTRAINT FK_AddLeave_MasterLeaveType
GO
ALTER TABLE dbo.MasterLeaveType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_AddLeave
	(
	Id int NOT NULL IDENTITY (1, 1),
	Uid int NOT NULL,
	LeaveTypeId int NOT NULL,
	AddLeaveHour float(53) NULL,
	DateAdd date NULL,
	Reason nvarchar(200) NULL,
	UserCreated int NOT NULL,
	UserUpdated int NOT NULL,
	DateCreated datetime NOT NULL,
	DateUpdated datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_AddLeave SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_AddLeave ON
GO
IF EXISTS(SELECT * FROM dbo.AddLeave)
	 EXEC('INSERT INTO dbo.Tmp_AddLeave (Id, Uid, LeaveTypeId, AddLeaveHour, DateAdd, Reason, UserCreated, UserUpdated, DateCreated, DateUpdated)
		SELECT Id, Uid, LeaveTypeId, CONVERT(float(53), LeaveAdd), DateAdd, Reason, UserCreated, UserUpdated, DateCreated, DateUpdated FROM dbo.AddLeave WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_AddLeave OFF
GO
DROP TABLE dbo.AddLeave
GO
EXECUTE sp_rename N'dbo.Tmp_AddLeave', N'AddLeave', 'OBJECT' 
GO
ALTER TABLE dbo.AddLeave ADD CONSTRAINT
	PK_AddLeave PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.AddLeave ADD CONSTRAINT
	FK_AddLeave_MasterLeaveType FOREIGN KEY
	(
	LeaveTypeId
	) REFERENCES dbo.MasterLeaveType
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.AddLeave ADD CONSTRAINT
	FK_AddLeave_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
