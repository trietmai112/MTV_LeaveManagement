/*
   Tuesday, September 19, 201711:15:51 PM
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
ALTER TABLE dbo.RegisterLeave
	DROP CONSTRAINT FK_RegisterLeave_User
GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RegisterLeave
	DROP CONSTRAINT FK_RegisterLeave_MasterLeaveType
GO
ALTER TABLE dbo.MasterLeaveType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_RegisterLeave
	(
	Id int NOT NULL IDENTITY (1, 1),
	Uid int NOT NULL,
	LeaveTypeId int NOT NULL,
	DateStart datetime NOT NULL,
	DateEnd datetime NOT NULL,
	RegisterHour float(53) NULL,
	Reason nvarchar(200) NULL,
	DateRegister datetime NOT NULL,
	Status tinyint NULL,
	UserApprove int NULL,
	DateApprove datetime NULL,
	UserCreated int NOT NULL,
	UserUpdated int NOT NULL,
	DateCreated datetime NOT NULL,
	DateUpdated datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_RegisterLeave SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_RegisterLeave ON
GO
IF EXISTS(SELECT * FROM dbo.RegisterLeave)
	 EXEC('INSERT INTO dbo.Tmp_RegisterLeave (Id, Uid, LeaveTypeId, DateStart, DateEnd, Reason, DateRegister, Status, UserApprove, DateApprove, UserCreated, UserUpdated, DateCreated, DateUpdated)
		SELECT Id, Uid, LeaveTypeId, DateStart, DateEnd, Reason, DateRegister, Status, UserApprove, DateApprove, UserCreated, UserUpdated, DateCreated, DateUpdated FROM dbo.RegisterLeave WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_RegisterLeave OFF
GO
DROP TABLE dbo.RegisterLeave
GO
EXECUTE sp_rename N'dbo.Tmp_RegisterLeave', N'RegisterLeave', 'OBJECT' 
GO
ALTER TABLE dbo.RegisterLeave ADD CONSTRAINT
	PK_RegisterLeave PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RegisterLeave ADD CONSTRAINT
	FK_RegisterLeave_MasterLeaveType FOREIGN KEY
	(
	LeaveTypeId
	) REFERENCES dbo.MasterLeaveType
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RegisterLeave ADD CONSTRAINT
	FK_RegisterLeave_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
