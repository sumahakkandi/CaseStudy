USE [master]
GO
/****** Object:  Database [dbDoctorAppointment]    Script Date: 27-04-2017 17:21:21 ******/
CREATE DATABASE [dbDoctorAppointment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbDoctorAppointment', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbDoctorAppointment.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbDoctorAppointment_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbDoctorAppointment_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbDoctorAppointment] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbDoctorAppointment].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbDoctorAppointment] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbDoctorAppointment] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [dbDoctorAppointment] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbDoctorAppointment] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbDoctorAppointment] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbDoctorAppointment] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbDoctorAppointment] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbDoctorAppointment] SET  MULTI_USER 
GO
ALTER DATABASE [dbDoctorAppointment] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbDoctorAppointment] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbDoctorAppointment] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbDoctorAppointment] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [dbDoctorAppointment]
GO
/****** Object:  StoredProcedure [dbo].[sp_DoctorLeave]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_DoctorLeave]
@DoctorName varchar(35),
@LeaveDate date
AS
Begin
update tblDepartmentDoctor set cLeaveStatus = 'On Leave',dLeaveDate = @LeaveDate where cDoctorName = @DoctorName
End
GO
/****** Object:  StoredProcedure [dbo].[sp_DoctorLeaveCancel]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_DoctorLeaveCancel]
@DoctorName varchar(35),
@LeaveDate date
AS
Begin
update tblDepartmentDoctor set cLeaveStatus = 'available' where cDoctorName = @DoctorName
End

GO
/****** Object:  StoredProcedure [dbo].[sp_Dues]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Dues]
@PatientId int,
@Dues varchar(15)
as 
begin 
update tblPatientOfficial set cDues = @Dues where iPatientId = @PatientId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientDetailsRegister]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PatientDetailsRegister]
@FirstName varchar(35),
@LastName varchar(35),
@EmailId varchar(50),
@Password varchar(50),
@SecurityQuestion varchar(30),
@SecurityAnswer varchar(30),
@Age varchar(5),
@Address varchar(50),
@MobileNumber varchar(50)
AS
BEGIN
INSERT INTO tblPatientDetails(cFirstName,cLastName,cEmailId,cPassword,cSecurityQuestion,cSecurityAnswer,cAge,cAddress,cMobileNumber)
VALUES(@FirstName,@LastName,@EmailId,@Password,@SecurityQuestion,@SecurityAnswer,@Age,@Address,@MobileNumber)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientOfficial]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PatientOfficial]
@PatientId int,
@Department varchar(35),
@DoctorName varchar(35),
@AppointmentDate date,
@AppointmentTime varchar(35)
AS
BEGIN
update tblPatientOfficial set cDepartment=@Department,cDoctorName=@DoctorName,dAppointmentDate=@AppointmentDate,cAppointmentTime=@AppointmentTime where iPatientId=@PatientId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ReceptionistPatient]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ReceptionistPatient]
@FirstName varchar(35),
@LastName varchar(35),
@Department varchar(35),
@DoctorName varchar(35),
@Age varchar(5),
@Address varchar(50),
@MobileNumber varchar(50),
@AppointmentDate date,
@AppointmentTime varchar(15),
@PatientType varchar(15)
AS
BEGIN
INSERT INTO tblReceptionistPatient(cFirstName,cLastName,cDepartment,cDoctorName,cAge,cAddress,cMobileNumber,dAppointmentDate,cAppointmentTime,cPatientType)
VALUES(@FirstName,@LastName,@Department,@DoctorName,@Age,@Address,@MobileNumber,@AppointmentDate,@AppointmentTime,@PatientType)
END

go
CREATE PROCEDURE [dbo].[sp_ReceptionistPatient1]
@FirstName varchar(35),
@LastName varchar(35),
@Department varchar(35),
@DoctorName varchar(35),
@Age varchar(5),
@Address varchar(50),
@MobileNumber varchar(50),
@AppointmentDate date,
@AppointmentTime varchar(15),
@PatientType varchar(15)
AS
BEGIN
INSERT INTO tblPatientOfficial(cFirstName,cLastName,cDepartment,cDoctorName,cAge,cAddress,cMobileNumber,dAppointmentDate,cAppointmentTime,cPatientType)
VALUES(@FirstName,@LastName,@Department,@DoctorName,@Age,@Address,@MobileNumber,@AppointmentDate,@AppointmentTime,@PatientType)
END


GO
/****** Object:  Table [dbo].[tblAdminLogin]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAdminLogin](
	[cUserName] [varchar](20) NOT NULL,
	[cPassword] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[cUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDepartmentDoctor]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDepartmentDoctor](
	[iDeptId] [int] IDENTITY(1,1) NOT NULL,
	[cDoctorName] [varchar](35) NULL,
	[cDepartment] [varchar](35) NULL,
	[cLeaveStatus] [varchar](15) NULL,
	[dLeaveDate] [date] NULL,
	[cUserName] [varchar](35) NULL,
	[cPassword] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[iDeptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDoctorAppointment]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDoctorAppointment](
	[iPatientId] [int] NOT NULL,
	[cFirstName] [varchar](35) NULL,
	[cLastName] [varchar](35) NULL,
	[cDepartment] [varchar](35) NULL,
	[cDoctorName] [varchar](35) NULL,
	[dAppointmentDate] [date] NULL,
	[cAppointmentTime] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[iPatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLoginCredentials]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLoginCredentials](
	[iPatientId] [int] NULL,
	[cUserName] [varchar](255) NOT NULL,
	[cPassword] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[cUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLoginHospital]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLoginHospital](
	[iReceptionistId] [int] IDENTITY(100,1) NOT NULL,
	[cRecptionistName] [varchar](35) NULL,
	[cUserName] [varchar](20) NOT NULL,
	[cPassword] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[cUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPatientDetails]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPatientDetails](
	[iPatientId] [int] IDENTITY(1000,1) NOT NULL,
	[cFirstName] [varchar](35) NULL,
	[cLastName] [varchar](35) NULL,
	[cEmailId] [varchar](255) NULL,
	[cPassword] [varchar](20) NULL,
	[cSEcurityQuestion] [varchar](30) NULL,
	[cSecurityAnswer] [varchar](30) NULL,
	[cAge] [varchar](5) NULL,
	[cAddress] [varchar](25) NULL,
	[cMobileNumber] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[iPatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPatientOfficial]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPatientOfficial](
	[iPatientId] [int] NOT NULL,
	[cFirstName] [varchar](35) NULL,
	[cLastName] [varchar](35) NULL,
	[cDepartment] [varchar](35) NULL,
	[cDoctorName] [varchar](35) NULL,
	[cAge] [varchar](5) NULL,
	[cAddress] [varchar](25) NULL,
	[cMobileNumber] [varchar](15) NULL,
	[dAppointmentDate] [date] NULL,
	[cAppointmentTime] [varchar](15) NULL,
	[cDues] [varchar](15) NULL,
	[cPatientType] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[iPatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblReceptionistPatient]    Script Date: 27-04-2017 17:21:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblReceptionistPatient](
	[iPatientId] [int] IDENTITY(2000,2) NOT NULL,
	[cFirstName] [varchar](35) NULL,
	[cLastName] [varchar](35) NULL,
	[cDepartment] [varchar](35) NULL,
	[cDoctorName] [varchar](35) NULL,
	[cAge] [varchar](5) NULL,
	[cAddress] [varchar](25) NULL,
	[cMobileNumber] [varchar](15) NULL,
	[dAppointmentDate] [date] NULL,
	[cAppointmentTime] [varchar](15) NULL,
	[cDues] [varchar](15) NULL,
	[cPatientType] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[iPatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblDepartmentDoctor] ADD  DEFAULT ('available') FOR [cLeaveStatus]
GO
ALTER TABLE [dbo].[tblDepartmentDoctor] ADD  DEFAULT (NULL) FOR [dLeaveDate]
GO
ALTER TABLE [dbo].[tblPatientOfficial] ADD  DEFAULT ('No Dues') FOR [cDues]
GO
ALTER TABLE [dbo].[tblPatientOfficial] ADD  DEFAULT ('outpatient') FOR [cPatientType]
GO
ALTER TABLE [dbo].[tblReceptionistPatient] ADD  DEFAULT ('No Dues') FOR [cDues]
GO
ALTER TABLE [dbo].[tblLoginCredentials]  WITH CHECK ADD FOREIGN KEY([iPatientId])
REFERENCES [dbo].[tblPatientDetails] ([iPatientId])
GO
USE [master]
GO
ALTER DATABASE [dbDoctorAppointment] SET  READ_WRITE 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ReceptionistPatient1]
@iPatientId int ,
@bookid int,
@FirstName varchar(35),
@LastName varchar(35),
@Department varchar(35),
@DoctorName varchar(35),
@Age varchar(5),
@Address varchar(50),
@MobileNumber varchar(50),
@AppointmentDate date,
@AppointmentTime varchar(15),
@PatientType varchar(15)
AS
BEGIN
INSERT INTO tblPatientOfficial1(iPatientId,bookid,cFirstName,cLastName,cDepartment,cDoctorName,cAge,cAddress,cMobileNumber,dAppointmentDate,cAppointmentTime,cPatientType)
VALUES(@iPatientId,@bookid,@FirstName,@LastName,@Department,@DoctorName,@Age,@Address,@MobileNumber,@AppointmentDate,@AppointmentTime,@PatientType)
END
GO
_______________________________________
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPatientOfficial1](
    [iPatientId] [int] references tblPatientDetails(iPatientId),
	[bookid] [int] identity primary key,
    [cFirstName] [varchar](35) NULL,
    [cLastName] [varchar](35) NULL,
    [cDepartment] [varchar](35) NULL,
    [cDoctorName] [varchar](35) NULL,
    [cAge] [varchar](5) NULL,
    [cAddress] [varchar](25) NULL,
    [cMobileNumber] [varchar](15) NULL,
    [dAppointmentDate] [date] NULL,
    [cAppointmentTime] [varchar](15) NULL,
    [cDues] [varchar](15) NULL,
    [cPatientType] [varchar](15) NULL)
PRIMARY KEY CLUSTERED
(
    [bookid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


select * from tblPatientDetails