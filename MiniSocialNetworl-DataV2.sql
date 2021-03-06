USE [master]
GO
/****** Object:  Database [MiniSocialNetwork]    Script Date: 29-Sep-20 5:00:32 PM ******/
CREATE DATABASE [MiniSocialNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MiniSocialNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MiniSocialNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MiniSocialNetwork] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MiniSocialNetwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MiniSocialNetwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MiniSocialNetwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECOVERY FULL 
GO
ALTER DATABASE [MiniSocialNetwork] SET  MULTI_USER 
GO
ALTER DATABASE [MiniSocialNetwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MiniSocialNetwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MiniSocialNetwork] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MiniSocialNetwork] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MiniSocialNetwork', N'ON'
GO
USE [MiniSocialNetwork]
GO
/****** Object:  Table [dbo].[tblArticle]    Script Date: 29-Sep-20 5:00:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblArticle](
	[article_id] [int] IDENTITY(1,1) NOT NULL,
	[user_email] [varchar](255) NOT NULL,
	[article_title] [nvarchar](200) NOT NULL,
	[article_content] [nvarchar](500) NOT NULL,
	[img] [nvarchar](255) NULL,
	[created_date] [datetime] NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[article_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 29-Sep-20 5:00:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblComment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[user_email] [varchar](255) NOT NULL,
	[comment_content] [nvarchar](500) NOT NULL,
	[status] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEmotion]    Script Date: 29-Sep-20 5:00:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEmotion](
	[article_id] [int] NOT NULL,
	[user_email] [varchar](255) NOT NULL,
	[emotion] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[article_id] ASC,
	[user_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNotification]    Script Date: 29-Sep-20 5:00:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNotification](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](500) NULL,
	[user_email] [varchar](255) NOT NULL,
	[interactor_email] [varchar](255) NOT NULL,
	[article_id] [int] NULL,
	[created_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 29-Sep-20 5:00:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[email] [varchar](255) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[role] [varchar](10) NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblArticle] ON 

INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (2, N'ngotanduc410@gmail.com', N'My First Post', N'Hihi đồ ngốc', N'939966_1600601764072.png', CAST(N'2020-09-20 18:36:04.077' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (3, N'ngotanduc410@gmail.com', N'Azur Lane!', N'Azur Lane!', N'Azur.Lane.full.2981078.jpg', CAST(N'2020-09-20 20:48:45.083' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (4, N'ngotanduc410@gmail.com', N'Tây Du Ký', N'Đi thỉnh kinh mệt lắm', NULL, CAST(N'2020-09-20 21:03:39.310' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (5, N'ngotanduc410@gmail.com', N'Hihi', N'Cục cứt bé xinh', NULL, CAST(N'2020-09-21 09:13:57.980' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (6, N'user1@gmail.com', N'Update V02', N'_ Làm được quá trời thứ tốt hơn, ui tốt hơn rùi, hihi', N'4de92813b950fec8ccf92b8e1ec86d4e_1600705401847.png', CAST(N'2020-09-21 23:23:21.893' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (7, N'user1@gmail.com', N'Update lại chức năng up hình', N'Test', N'e05744161d7500a183d5ec3a38a6e626_1600705465728.jpg', CAST(N'2020-09-21 23:24:25.743' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (8, N'user1@gmail.com', N'Update lại chức năng up hình', N'Test', N'e05744161d7500a183d5ec3a38a6e626_1600705757568.jpg', CAST(N'2020-09-21 23:29:17.787' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (9, N'user1@gmail.com', N'Test chữ bth', N'Hihi', NULL, CAST(N'2020-09-21 23:30:03.600' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (12, N'ngotanduc410@gmail.com', N'Mới thêm chức năng pagination', N'Yay, mình mất mấy tiếng chỉ để đọc js về cách xài cái này :) Thiệt là tuyệt vời', NULL, CAST(N'2020-09-24 00:19:29.750' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (16, N'ngotanduc410@gmail.com', N'Hello', N'Hihi', N'971280_1600882930445.png', CAST(N'2020-09-24 00:42:10.490' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (18, N'ngotanduc410@gmail.com', N'Hello Trung', N'Hihi', NULL, CAST(N'2020-09-24 10:45:34.150' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (19, N'admin@gmail.com', N'Test chức năng xóa của admin', N'Hihi', NULL, CAST(N'2020-09-24 10:48:21.353' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (20, N'ngotanduc410@gmail.com', N'Test chức năng xóa cmt', N'Thử nghiệm v1', NULL, CAST(N'2020-09-24 20:48:48.793' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (21, N'ngotanduc410@gmail.com', N'Một ngày cô đơn', N'Chỉ đơn giản là cô đơn thế thôi', N'anton-darius-ebHCU8n7G38-unsplash_1601086931425.jpg', CAST(N'2020-09-26 09:22:11.463' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (22, N'ngotanduc410@gmail.com', N'Test notification', N'Hihi', NULL, CAST(N'2020-09-26 17:01:34.283' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (23, N'ngotanduc410@gmail.com', N'Hinh dep', N'Dep lam a', N'yosemite-2560x1440-el-capitan-hd-4k-wallpaper-winter-forest-osx-apple-3942_1601121443935.jpg', CAST(N'2020-09-26 18:57:23.977' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (24, N'ngotanduc410@gmail.com', N'Hinh dep', N'Dep lam a', N'yosemite-2560x1440-el-capitan-hd-4k-wallpaper-winter-forest-osx-apple-3942_1601121587774.jpg', CAST(N'2020-09-26 18:59:47.967' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (25, N'ngotanduc410@gmail.com', N'Post thử', N'Testing', N'Windows-10-official-wallpaper-9-windows-10-39400452-3840-2160_1601121915360.jpg', CAST(N'2020-09-26 19:05:15.367' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (26, N'ngotanduc410@gmail.com', N'Final Test maybe', N'Mới xong filter', N'pexels-jorge-fakhouri-filho-1854129_1601211141132.jpg', CAST(N'2020-09-27 19:52:21.147' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (27, N'ngotanduc410@gmail.com', N'Test post bài', N'Lala', NULL, CAST(N'2020-09-27 19:52:49.227' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (28, N'hannqSE140027@fpt.edu.vn', N'Test App', N'Chau Len Bar', NULL, CAST(N'2020-09-27 20:43:42.180' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (29, N'hannqSE140027@fpt.edu.vn', N'Test them bai', N'Test them bai', NULL, CAST(N'2020-09-27 20:45:44.553' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (30, N'hannqSE140027@fpt.edu.vn', N'Test them bai', N'Test them bai', NULL, CAST(N'2020-09-27 20:45:46.393' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (31, N'hannqSE140027@fpt.edu.vn', N'Test them bai', N'Test them bai', NULL, CAST(N'2020-09-27 20:45:48.367' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (32, N'hannqSE140027@fpt.edu.vn', N'Test them bai', N'Test them bai', NULL, CAST(N'2020-09-27 20:45:49.123' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (33, N'ngotanduc410@gmail.com', N'Post thử', N'Meow meow
', NULL, CAST(N'2020-09-28 20:31:11.027' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (34, N'ngotanduc410@gmail.com', N'Hihi', N'hihi', NULL, CAST(N'2020-09-29 06:59:26.817' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (35, N'ngotanduc410@gmail.com', N'Hihi', N'hihi', NULL, CAST(N'2020-09-29 06:59:29.963' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (36, N'ngotanduc410@gmail.com', N'Hihi', N'hihi', NULL, CAST(N'2020-09-29 06:59:32.930' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (37, N'ngotanduc410@gmail.com', N'Ahihi', N'Cười', NULL, CAST(N'2020-09-29 06:59:50.197' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (38, N'ngotanduc410@gmail.com', N'Ahihi', N'Cười', NULL, CAST(N'2020-09-29 06:59:52.540' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (39, N'ngotanduc410@gmail.com', N'Ahihi', N'Cười', NULL, CAST(N'2020-09-29 06:59:57.907' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (40, N'ngotanduc410@gmail.com', N'Ahihi', N'Cười', NULL, CAST(N'2020-09-29 07:00:03.937' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (41, N'ngotanduc410@gmail.com', N'Tiếng việt', N'Tiếng Việt', N'2018-cyberpunk-2077-4k-n6_1601351342596.jpg', CAST(N'2020-09-29 10:49:02.607' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (42, N'beiuonepiece999@gmail.com', N'Music For Today', N'Hôm nay trời mưa nên cũng khá mát. Làm gì để tận hưởng không khí này đây? Ăn miếng bánh trung thu, uống 1 tách trà nóng và thưởng thức 1 vài bài nhạc để "deep" cùng mưa nè. Nếu bạn là 1 fan của nhạc Hoa, đừng bỏ qua list nhạc này nhé ! ^ ^<br/>
<a href="https://www.youtube.com/watch?v=zXkNjhJU4mo" target="_blank">Nhớ em -Ngải Thần </a><br/>
<a href="https://www.youtube.com/watch?v=6XouWKPvdag" target="_blank">Người tôi yêu - Lâm Thu Văn</a><br/>

', N'Belfast.(Azur.Lane).full.2533725_1601353676663.jpg', CAST(N'2020-09-29 11:27:56.730' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (43, N'beiuonepiece999@gmail.com', N'Music For Today', N'Hôm nay trời mưa nên cũng khá mát. Làm gì để tận hưởng không khí này đây? Ăn miếng bánh trung thu, uống 1 tách trà nóng và thưởng thức 1 vài bài nhạc để "deep" cùng mưa nè. Nếu bạn là 1 fan của nhạc Hoa, đừng bỏ qua list nhạc này nhé ! ^ ^<br/>
<a href="https://www.youtube.com/watch?v=zXkNjhJU4mo" target="_blank">Nhớ em -Ngải Thần </a><br/>
<a href="https://www.youtube.com/watch?v=6XouWKPvdag" target="_blank">Người tôi yêu - Lâm Thu Văn</a><br/>
', N'Belfast.(Azur.Lane).full.2533725_1601353769521.jpg', CAST(N'2020-09-29 11:29:31.110' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (44, N'ngotanduc410@gmail.com', N'Hello world', N'Aloha ', N'939966_1601355889070.png', CAST(N'2020-09-29 12:04:49.093' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (45, N'ngotanduc410@gmail.com', N'Hello world', N'Aloha ', N'939966_1601355933337.png', CAST(N'2020-09-29 12:05:33.350' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (46, N'ngotanduc410@gmail.com', N'Hello world', N'Aloha ', N'939966_1601355939133.png', CAST(N'2020-09-29 12:05:39.143' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (47, N'ngotanduc410@gmail.com', N'Hello world', N'Aloha ', N'939966_1601355995869.png', CAST(N'2020-09-29 12:06:35.880' AS DateTime), N'Delete')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (48, N'stever123410@gmail.com', N'Bài cuối cùng', N'Cám ơn mng đã giúp đỡ mình :3', N'IMG_0855_1601373301136.jpg', CAST(N'2020-09-29 16:55:01.503' AS DateTime), N'Active')
INSERT [dbo].[tblArticle] ([article_id], [user_email], [article_title], [article_content], [img], [created_date], [status]) VALUES (49, N'ngotanduc410@gmail.com', N'Post để xóa', N'Hình trái nho', N'25 - t7f9N9W_1601373424427.jpg', CAST(N'2020-09-29 16:57:04.430' AS DateTime), N'Delete')
SET IDENTITY_INSERT [dbo].[tblArticle] OFF
SET IDENTITY_INSERT [dbo].[tblComment] ON 

INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (2, 2, N'ngotanduc410@gmail.com', N'Test comment', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (3, 2, N'user1@gmail.com', N'Test comment of another user', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (4, 2, N'user1@gmail.com', N'Test comment of another user', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (5, 9, N'user1@gmail.com', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (6, 7, N'ngotanduc410@gmail.com', N'fgfgfg', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (7, 8, N'ngotanduc410@gmail.com', N'Con chó', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (8, 8, N'ngotanduc410@gmail.com', N'Con chó', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (9, 8, N'ngotanduc410@gmail.com', N'hihi', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (10, 8, N'ngotanduc410@gmail.com', N'hihi', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (11, 8, N'ngotanduc410@gmail.com', N'soft', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (12, 8, N'ngotanduc410@gmail.com', N'soft', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (15, 8, N'user1@gmail.com', N'hihi đồ ngốc', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (16, 8, N'user1@gmail.com', N'hihi đồ ngốc', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (17, 16, N'ngotanduc410@gmail.com', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (18, 16, N'ngotanduc410@gmail.com', N'Test chức năng xóa cmt', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (19, 16, N'ngotanduc410@gmail.com', N'Test chức năng xóa cmt', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (20, 5, N'ngotanduc410@gmail.com', N'Hello Cu', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (21, 5, N'ngotanduc410@gmail.com', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (22, 5, N'ngotanduc410@gmail.com', N'Haha đồ ngốc', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (23, 5, N'ngotanduc410@gmail.com', N'Haha đồ ngốc', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (24, 20, N'ngotanduc410@gmail.com', N'Thử nghiệm xóa', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (25, 21, N'ngotanduc410@gmail.com', N'kệ bạn', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (26, 21, N'ngotanduc410@gmail.com', N'kệ bạn', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (27, 9, N'ngotanduc410@gmail.com', N'Hello user1, test notifcation nè', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (28, 22, N'ngotanduc410@gmail.com', N'Con chó', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (29, 22, N'ngotanduc410@gmail.com', N'Test comment noti', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (30, 22, N'user1@gmail.com', N'hihi cmt user 1 nè', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (31, 25, N'user1@gmail.com', N'Hello chàng trai, check noti nha', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (32, 24, N'stever123410@gmail.com', N'Clone has comment hihi', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (33, 26, N'stever123410@gmail.com', N'Hihi đẹp quá :>', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (34, 27, N'hannqSE140027@fpt.edu.vn', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (35, 23, N'hannqSE140027@fpt.edu.vn', N'Test comment of another user', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (38, 43, N'beiuonepiece999@gmail.com', N'Alo', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (39, 43, N'beiuonepiece999@gmail.com', N'123', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (40, 41, N'beiuonepiece999@gmail.com', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (41, 43, N'admin@gmail.com', N'Hello Tèo', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (42, 43, N'admin@gmail.com', N'Admin ko like & dislike va comment dc nhe', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (43, 46, N'ngotanduc410@gmail.com', N'Hello Tèo', N'Delete')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (44, 46, N'ngotanduc410@gmail.com', N'hihi', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (45, 48, N'stever123410@gmail.com', N'Hihi hình đẹp lắm nha ;3', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (46, 48, N'ngotanduc410@gmail.com', N'Hình đẹp được chụp bởi @dnhnhh_ voi @tan_duc410', N'Active')
INSERT [dbo].[tblComment] ([comment_id], [article_id], [user_email], [comment_content], [status]) VALUES (47, 48, N'ngotanduc410@gmail.com', N'Xóa comment này đi', N'Delete')
SET IDENTITY_INSERT [dbo].[tblComment] OFF
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (2, N'hannqSE140027@fpt.edu.vn', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (2, N'ngotanduc410@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (2, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (7, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (7, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (8, N'ngotanduc410@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (8, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (9, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (12, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (16, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (20, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (20, N'user1@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (21, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (21, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (22, N'user1@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (24, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (24, N'stever123410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (25, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (25, N'user1@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (26, N'beiuonepiece999@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (26, N'stever123410@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (27, N'hannqSE140027@fpt.edu.vn', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (28, N'hannqSE140027@fpt.edu.vn', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (30, N'hannqSE140027@fpt.edu.vn', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (43, N'admin@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (44, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (46, N'ngotanduc410@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (48, N'ngotanduc410@gmail.com', N'Like')
INSERT [dbo].[tblEmotion] ([article_id], [user_email], [emotion]) VALUES (48, N'stever123410@gmail.com', N'Like')
SET IDENTITY_INSERT [dbo].[tblNotification] ON 

INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (1, N'ngotanduc410@gmail.com has commented on your post', N'ngotanduc410@gmail.com', N'ngotanduc410@gmail.com', 22, CAST(N'2020-09-26 17:02:56.053' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (2, N'user1@gmail.com has commented on your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:03:22.940' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (3, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:24:54.170' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (4, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:25:03.943' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (5, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:25:19.327' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (6, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:25:20.487' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (7, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:25:20.947' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (8, N'user1@gmail.com has reacted your post', N'user1@gmail.com', N'user1@gmail.com', 7, CAST(N'2020-09-26 17:25:26.950' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (9, N'user1@gmail.com has reacted your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 21, CAST(N'2020-09-26 17:25:32.667' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (10, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:28:04.677' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (11, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 22, CAST(N'2020-09-26 17:28:06.510' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (12, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:29:41.363' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (13, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:29:43.697' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (14, N'user1@gmail.com has Liked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:29:44.677' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (15, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:29:45.650' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (16, N'user1@gmail.com has Liked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:30:14.390' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (17, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:30:15.870' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (18, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:37:22.030' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (19, N'user1@gmail.com has Liked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:37:23.720' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (20, N'user1@gmail.com has Disliked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 20, CAST(N'2020-09-26 17:37:24.710' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (21, N'user1@gmail.com has liked your post', N'user1@gmail.com', N'user1@gmail.com', 8, CAST(N'2020-09-26 17:38:05.310' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (22, N'user1@gmail.com has deleted his/her comment on your post', N'user1@gmail.com', N'user1@gmail.com', 8, CAST(N'2020-09-26 17:49:40.593' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (23, N'ngotanduc410@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'ngotanduc410@gmail.com', 25, CAST(N'2020-09-26 19:05:43.197' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (24, N'user1@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'user1@gmail.com', 25, CAST(N'2020-09-26 22:21:20.233' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (25, N'user1@gmail.com has commented on your post: Hello chàng trai, check noti nha', N'ngotanduc410@gmail.com', N'user1@gmail.com', 25, CAST(N'2020-09-26 22:21:30.437' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (26, N'stever123410@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'stever123410@gmail.com', 24, CAST(N'2020-09-27 13:04:11.530' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (27, N'stever123410@gmail.com has commented on your post: Clone has comment hihi', N'ngotanduc410@gmail.com', N'stever123410@gmail.com', 24, CAST(N'2020-09-27 13:04:26.173' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (28, N'ngotanduc410@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'ngotanduc410@gmail.com', 24, CAST(N'2020-09-27 13:05:06.100' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (29, N'stever123410@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'stever123410@gmail.com', 26, CAST(N'2020-09-27 19:54:17.950' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (30, N'stever123410@gmail.com has disliked your post', N'ngotanduc410@gmail.com', N'stever123410@gmail.com', 26, CAST(N'2020-09-27 19:54:19.360' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (31, N'stever123410@gmail.com has commented on your post: Hihi đẹp quá :>', N'ngotanduc410@gmail.com', N'stever123410@gmail.com', 26, CAST(N'2020-09-27 19:54:32.207' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (32, N'hannqSE140027@fpt.edu.vn has liked your post', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 27, CAST(N'2020-09-27 20:41:31.443' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (33, N'hannqSE140027@fpt.edu.vn has disliked your post', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 27, CAST(N'2020-09-27 20:41:32.697' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (34, N'hannqSE140027@fpt.edu.vn has commented on your post: Hello Tèo', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 27, CAST(N'2020-09-27 20:41:41.790' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (35, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 28, CAST(N'2020-09-27 20:43:48.000' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (36, N'hannqSE140027@fpt.edu.vn has disliked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 28, CAST(N'2020-09-27 20:43:56.173' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (37, N'hannqSE140027@fpt.edu.vn has liked your post', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 2, CAST(N'2020-09-27 20:46:18.587' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (38, N'hannqSE140027@fpt.edu.vn has commented on your post: Test comment of another user', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 23, CAST(N'2020-09-27 20:49:12.477' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (39, N'hannqSE140027@fpt.edu.vn has deleted his/her comment on your post', N'ngotanduc410@gmail.com', N'hannqSE140027@fpt.edu.vn', 23, CAST(N'2020-09-27 20:49:16.113' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (40, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 30, CAST(N'2020-09-27 20:50:24.597' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (41, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 30, CAST(N'2020-09-27 20:50:25.290' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (42, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 30, CAST(N'2020-09-27 20:50:26.437' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (43, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 30, CAST(N'2020-09-27 20:50:27.430' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (44, N'hannqSE140027@fpt.edu.vn has liked your post', N'hannqSE140027@fpt.edu.vn', N'hannqSE140027@fpt.edu.vn', 30, CAST(N'2020-09-27 20:50:28.487' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (45, N'admin@gmail.com has deleted your post', N'hannqSE140027@fpt.edu.vn', N'admin@gmail.com', 30, CAST(N'2020-09-27 21:48:38.810' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (51, N'beiuonepiece999@gmail.com has liked your post', N'ngotanduc410@gmail.com', N'beiuonepiece999@gmail.com', 26, CAST(N'2020-09-29 11:24:24.247' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (52, N'beiuonepiece999@gmail.com has commented on your post: Hello Tèo', N'ngotanduc410@gmail.com', N'beiuonepiece999@gmail.com', 41, CAST(N'2020-09-29 11:34:25.213' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (53, N'admin@gmail.com has commented on your post: Hello Tèo', N'beiuonepiece999@gmail.com', N'admin@gmail.com', 43, CAST(N'2020-09-29 11:44:31.273' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (54, N'admin@gmail.com has liked your post', N'beiuonepiece999@gmail.com', N'admin@gmail.com', 43, CAST(N'2020-09-29 11:45:18.490' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (55, N'admin@gmail.com has commented on your post: Admin ko like & dislike va comment dc nhe', N'beiuonepiece999@gmail.com', N'admin@gmail.com', 43, CAST(N'2020-09-29 11:45:32.870' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (56, N'admin@gmail.com has deleted his/her comment on your post', N'beiuonepiece999@gmail.com', N'admin@gmail.com', 43, CAST(N'2020-09-29 11:45:41.630' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (57, N'admin@gmail.com has deleted your post', N'ngotanduc410@gmail.com', N'admin@gmail.com', 40, CAST(N'2020-09-29 11:45:54.053' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (58, N'admin@gmail.com has deleted your post', N'beiuonepiece999@gmail.com', N'admin@gmail.com', 43, CAST(N'2020-09-29 15:57:41.497' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (59, N'admin@gmail.com has deleted your post', N'ngotanduc410@gmail.com', N'admin@gmail.com', 46, CAST(N'2020-09-29 15:57:54.630' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (60, N'admin@gmail.com has deleted your post', N'ngotanduc410@gmail.com', N'admin@gmail.com', 45, CAST(N'2020-09-29 15:58:00.887' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (61, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:30.670' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (62, N'ngotanduc410@gmail.com has disliked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:31.483' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (63, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:32.230' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (64, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:32.693' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (65, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:32.830' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (66, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:32.970' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (67, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:33.240' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (68, N'ngotanduc410@gmail.com has liked your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:55:33.893' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (69, N'ngotanduc410@gmail.com has commented on your post: Hình đẹp được chụp bởi @dnhnhh_ voi @tan_duc410', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:56:17.680' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (70, N'ngotanduc410@gmail.com has commented on your post: Xóa comment này đi', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:56:27.387' AS DateTime))
INSERT [dbo].[tblNotification] ([notification_id], [description], [user_email], [interactor_email], [article_id], [created_date]) VALUES (71, N'ngotanduc410@gmail.com has deleted his/her comment on your post', N'stever123410@gmail.com', N'ngotanduc410@gmail.com', 48, CAST(N'2020-09-29 16:56:31.803' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblNotification] OFF
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'admin@gmail.com', N'admin', N'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'admin', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'beiuonepiece999@gmail.com', N'Hua Vinh Khang', N'15E2B0D3C33891EBB0F1EF609EC419420C20E320CE94C65FBC8C3312448EB225', N'member', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'ducntSE140639@fpt.edu.vn', N'Ngô Tấn Đức FPT', N'976619B115FEBC0F5286B424DDA42245FB2471D2D426E3F5543852DFE59ECCC7', N'member', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'hannqSE140027@fpt.edu.vn', N'Quang Han', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', N'member', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'ngotanduc410@gmail.com', N'Ngô Tấn Đức', N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3', N'member', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'stever123410@gmail.com', N'Clone', N'B5D61DC89A35D2C924B28C9760765DA94039E94184C50F87DDE54532F126B4AC', N'member', N'Active')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'teo@gmail.com', N'teo', N'8D69EAC583367B7ECF431A857FC8E7903FF1ED988E8939FD0E92086DCFC1F98A', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'teo123@gmail.com', N'teo123', N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'teo345@gmail.com', N'teo345', N'8D69EAC583367B7ECF431A857FC8E7903FF1ED988E8939FD0E92086DCFC1F98A', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'test1@gmail.com', N'test', N'9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'thinhbo@gmail', N'Bo', N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'thinhbo1@gmail', N'thinh bo ', N'A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3', N'member', N'New')
INSERT [dbo].[tblUser] ([email], [name], [password], [role], [status]) VALUES (N'user1@gmail.com', N'User 1', N'04F8996DA763B7A969B1028EE3007569EAF3A635486DDAB211D512C85B9DF8FB', N'member', N'New')
ALTER TABLE [dbo].[tblArticle]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD FOREIGN KEY([article_id])
REFERENCES [dbo].[tblArticle] ([article_id])
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblEmotion]  WITH CHECK ADD FOREIGN KEY([article_id])
REFERENCES [dbo].[tblArticle] ([article_id])
GO
ALTER TABLE [dbo].[tblEmotion]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD FOREIGN KEY([article_id])
REFERENCES [dbo].[tblArticle] ([article_id])
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD FOREIGN KEY([interactor_email])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[tblUser] ([email])
GO
USE [master]
GO
ALTER DATABASE [MiniSocialNetwork] SET  READ_WRITE 
GO
