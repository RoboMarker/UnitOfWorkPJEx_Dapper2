USE [dbTest]
GO
/****** Object:  Table [dbo].[City]    Script Date: 2023/10/31 下午 04:16:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityId] [varchar](4) NOT NULL,
	[CityName] [varchar](10) NULL,
	[CountryId] [int] NULL,
	[Status] [bit] NULL,
	[orderby] [int] NULL,
 CONSTRAINT [PK_CityId] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 2023/10/31 下午 04:16:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](10) NULL,
	[Status] [bit] NULL,
	[orderby] [int] NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2023/10/31 下午 04:16:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](10) NULL,
	[Age] [int] NULL,
	[Sex] [tinyint] NULL,
	[CountryId] [int] NULL,
	[CityId] [varchar](4) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'1001', N'大安', 1, 1, 1)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'1002', N'萬華', 1, 1, 2)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'1003', N'中山', 1, 1, 3)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'2001', N'板橋', 2, 1, 1)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'2002', N'新莊', 2, 1, 2)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'2003', N'永和', 2, 1, 3)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'3001', N'中區', 3, 1, 1)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'3002', N'東需', 3, 1, 2)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'3003', N'南區', 3, 1, 3)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'4001', N'岡山', 4, 1, 1)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'4002', N'楠梓', 4, 1, 2)
INSERT [dbo].[City] ([CityId], [CityName], [CountryId], [Status], [orderby]) VALUES (N'4003', N'左營', 4, 1, 3)
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryId], [CountryName], [Status], [orderby]) VALUES (1, N'台北', 1, 1)
INSERT [dbo].[Country] ([CountryId], [CountryName], [Status], [orderby]) VALUES (2, N'新北', 1, 2)
INSERT [dbo].[Country] ([CountryId], [CountryName], [Status], [orderby]) VALUES (3, N'台中', 1, 3)
INSERT [dbo].[Country] ([CountryId], [CountryName], [Status], [orderby]) VALUES (4, N'高雄', 1, 4)
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (1, N'sam', 25, 1, 1, N'1001')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (2, N'ladygaga', 55, 2, 2, N'2002')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (6, N'danny', 66, 1, 3, N'1003')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (7, N'jokson', 88, 1, 3, N'3003')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (11, N'amy', 36, 2, 2, N'2003')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (14, N'dora', 35, 2, 2, N'2001')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (18, N'show_dd', 44, 1, 2, N'2002')
INSERT [dbo].[User] ([UserId], [UserName], [Age], [Sex], [CountryId], [CityId]) VALUES (19, N'onejom', 44, 1, 2, N'2002')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
