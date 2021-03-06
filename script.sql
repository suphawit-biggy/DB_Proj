USE [master]
GO
/****** Object:  Database [DB_Project]    Script Date: 16/12/2558 4:03:18 ******/
CREATE DATABASE [DB_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\DB_Project.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\DB_Project_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_Project] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_Project] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DB_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_Project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_Project] SET  MULTI_USER 
GO
ALTER DATABASE [DB_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_Project] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DB_Project]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 16/12/2558 4:03:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [nchar](4) NOT NULL,
	[LicenseID] [varchar](50) NULL,
	[OwnerName] [varchar](50) NULL,
	[Fee] [nchar](10) NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Car]    Script Date: 16/12/2558 4:03:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Car](
	[LicenseID] [varchar](50) NOT NULL,
	[Type] [nchar](5) NULL,
	[Brand] [varchar](50) NULL,
	[Color] [varchar](50) NULL,
 CONSTRAINT [PK_Car] PRIMARY KEY CLUSTERED 
(
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 16/12/2558 4:03:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Type] [nchar](5) NOT NULL,
	[Fee] [smallmoney] NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Report]    Script Date: 16/12/2558 4:03:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Report]
AS
SELECT        dbo.Bill.BillID, dbo.Bill.LicenseID, dbo.Car.Type, dbo.Car.Brand, dbo.Car.Color, dbo.Bill.OwnerName, dbo.Bill.Fee
FROM            dbo.Bill INNER JOIN
                         dbo.Car ON dbo.Bill.LicenseID = dbo.Car.LicenseID

GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Car] FOREIGN KEY([LicenseID])
REFERENCES [dbo].[Car] ([LicenseID])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Car]
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD  CONSTRAINT [FK_Car_Payment] FOREIGN KEY([Type])
REFERENCES [dbo].[Payment] ([Type])
GO
ALTER TABLE [dbo].[Car] CHECK CONSTRAINT [FK_Car_Payment]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Bill"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Car"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Report'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Report'
GO
USE [master]
GO
ALTER DATABASE [DB_Project] SET  READ_WRITE 
GO
