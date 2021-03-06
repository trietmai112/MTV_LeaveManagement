/*
   Sunday, September 17, 20175:56:36 PM
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
CREATE TABLE dbo.Tmp_DataInOutRaw
	(
	id bigint NOT NULL IDENTITY (1, 1),
	Uid int NOT NULL,
	Time datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DataInOutRaw SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DataInOutRaw OFF
GO
IF EXISTS(SELECT * FROM dbo.DataInOutRaw)
	 EXEC('INSERT INTO dbo.Tmp_DataInOutRaw (Uid, Time)
		SELECT Uid, Time FROM dbo.DataInOutRaw WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.DataInOutRaw
GO
EXECUTE sp_rename N'dbo.Tmp_DataInOutRaw', N'DataInOutRaw', 'OBJECT' 
GO
ALTER TABLE dbo.DataInOutRaw ADD CONSTRAINT
	PK_DataInOutRaw PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
