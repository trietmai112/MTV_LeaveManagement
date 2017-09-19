/*
   Tuesday, September 19, 201711:17:04 PM
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
	DROP CONSTRAINT FK_RegisterLeave_MasterLeaveType
GO
ALTER TABLE dbo.MasterLeaveType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_User
	(
	Uid int NOT NULL,
	FullName nvarchar(100) NULL,
	DateOfBirth date NULL,
	UserPermission tinyint NOT NULL,
	DateBeginWork date NULL,
	DateBeginProbation date NULL,
	DateResign date NULL,
	Username nvarchar(100) NOT NULL,
	Password nvarchar(100) NOT NULL,
	UserCreated int NOT NULL,
	UserUpdated int NOT NULL,
	DateCreated datetime NOT NULL,
	DateUpdated datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_User SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.[User])
	 EXEC('INSERT INTO dbo.Tmp_User (Uid, FullName, DateOfBirth, UserPermission, DateBeginWork, DateBeginProbation, DateResign, Username, Password, UserCreated, UserUpdated, DateCreated, DateUpdated)
		SELECT Uid, FullName, DateOfBirth, UserPermission, DateBeginWork, DateBeginProbation, DateResign, Username, Password, UserCreated, UserUpdated, DateCreated, DateUpdated FROM dbo.[User] WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.RegisterLeave
	DROP CONSTRAINT FK_RegisterLeave_User
GO
ALTER TABLE dbo.LeaveMonthly
	DROP CONSTRAINT FK_LeaveMonthly_User
GO
ALTER TABLE dbo.InOut
	DROP CONSTRAINT FK_InOut_User
GO
ALTER TABLE dbo.DataBeginYear
	DROP CONSTRAINT FK_DataBeginYear_User
GO
ALTER TABLE dbo.AddLeave
	DROP CONSTRAINT FK_AddLeave_User
GO
ALTER TABLE dbo.UserSeniority
	DROP CONSTRAINT FK_UserSeniority_User
GO
DROP TABLE dbo.[User]
GO
EXECUTE sp_rename N'dbo.Tmp_User', N'User', 'OBJECT' 
GO
ALTER TABLE dbo.[User] ADD CONSTRAINT
	PK_User PRIMARY KEY CLUSTERED 
	(
	Uid
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.UserSeniority SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.AddLeave SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.DataBeginYear SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.InOut ADD CONSTRAINT
	FK_InOut_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.InOut SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.LeaveMonthly ADD CONSTRAINT
	FK_LeaveMonthly_User FOREIGN KEY
	(
	Uid
	) REFERENCES dbo.[User]
	(
	Uid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.LeaveMonthly SET (LOCK_ESCALATION = TABLE)
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
