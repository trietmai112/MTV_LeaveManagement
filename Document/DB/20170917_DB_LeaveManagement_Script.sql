/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.900)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [LeaveManagement]
GO
/****** Object:  Table [dbo].[AddLeave]    Script Date: 9/17/2017 12:51:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddLeave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[LeaveTypeId] [int] NOT NULL,
	[LeaveAdd] [tinyint] NULL,
	[DateAdd] [date] NULL,
	[Reason] [nvarchar](200) NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_AddLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataBeginYear]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataBeginYear](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[AnnualLeave] [tinyint] NOT NULL,
	[DateBegin] [date] NOT NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_DataBeginYear] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataInOutRaw]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataInOutRaw](
	[Uid] [int] NOT NULL,
	[Time] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InOut]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InOut](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[Intime] [datetime] NOT NULL,
	[OutTime] [datetime] NULL,
	[Date] [date] NOT NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_InOut] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveMonthly]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveMonthly](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[Month] [date] NOT NULL,
	[LeaveAvailable] [tinyint] NULL,
	[LeaveUsed] [tinyint] NULL,
	[LeaveRemain] [tinyint] NULL,
	[LeaveNonPaid] [tinyint] NULL,
	[IsMaterityLeave] [bit] NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_LeaveMonthly] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterLeaveDayCompany]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterLeaveDayCompany](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_MasterLeaveDayCompany] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterLeaveType]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterLeaveType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[IsPaidLeave] [bit] NULL,
	[IsBussinessLeave] [bit] NULL,
	[LeaveCode] [nvarchar](20) NULL,
	[Description] [nvarchar](200) NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_MasterLeaveType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisterLeave]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterLeave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[LeaveTypeId] [int] NOT NULL,
	[DateStart] [datetime] NOT NULL,
	[DateEnd] [datetime] NOT NULL,
	[Reason] [nvarchar](200) NULL,
	[DateRegister] [datetime] NOT NULL,
	[Status] [tinyint] NULL,
	[UserApprove] [int] NULL,
	[DateApprove] [datetime] NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_RegisterLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Uid] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[UserPermission] [tinyint] NOT NULL,
	[DateBeginWork] [date] NULL,
	[DateBeginProbation] [date] NULL,
	[DateResign] [date] NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSeniority]    Script Date: 9/17/2017 12:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSeniority](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uid] [int] NOT NULL,
	[AvailableLeave] [tinyint] NULL,
	[MonthYear] [date] NULL,
	[UserCreated] [int] NOT NULL,
	[UserUpdated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_UserSeniority] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AddLeave]  WITH CHECK ADD  CONSTRAINT [FK_AddLeave_MasterLeaveType] FOREIGN KEY([LeaveTypeId])
REFERENCES [dbo].[MasterLeaveType] ([Id])
GO
ALTER TABLE [dbo].[AddLeave] CHECK CONSTRAINT [FK_AddLeave_MasterLeaveType]
GO
ALTER TABLE [dbo].[AddLeave]  WITH CHECK ADD  CONSTRAINT [FK_AddLeave_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[AddLeave] CHECK CONSTRAINT [FK_AddLeave_User]
GO
ALTER TABLE [dbo].[DataBeginYear]  WITH CHECK ADD  CONSTRAINT [FK_DataBeginYear_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[DataBeginYear] CHECK CONSTRAINT [FK_DataBeginYear_User]
GO
ALTER TABLE [dbo].[InOut]  WITH CHECK ADD  CONSTRAINT [FK_InOut_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[InOut] CHECK CONSTRAINT [FK_InOut_User]
GO
ALTER TABLE [dbo].[LeaveMonthly]  WITH CHECK ADD  CONSTRAINT [FK_LeaveMonthly_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[LeaveMonthly] CHECK CONSTRAINT [FK_LeaveMonthly_User]
GO
ALTER TABLE [dbo].[RegisterLeave]  WITH CHECK ADD  CONSTRAINT [FK_RegisterLeave_MasterLeaveType] FOREIGN KEY([LeaveTypeId])
REFERENCES [dbo].[MasterLeaveType] ([Id])
GO
ALTER TABLE [dbo].[RegisterLeave] CHECK CONSTRAINT [FK_RegisterLeave_MasterLeaveType]
GO
ALTER TABLE [dbo].[RegisterLeave]  WITH CHECK ADD  CONSTRAINT [FK_RegisterLeave_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[RegisterLeave] CHECK CONSTRAINT [FK_RegisterLeave_User]
GO
ALTER TABLE [dbo].[UserSeniority]  WITH CHECK ADD  CONSTRAINT [FK_UserSeniority_User] FOREIGN KEY([Uid])
REFERENCES [dbo].[User] ([Uid])
GO
ALTER TABLE [dbo].[UserSeniority] CHECK CONSTRAINT [FK_UserSeniority_User]
GO
