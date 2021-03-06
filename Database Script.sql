/****** Object:  Database [SpeakingLogs]    Script Date: 06/10/2020 11:11:51 ******/
CREATE DATABASE [SpeakingLogs]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 10 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [SpeakingLogs] SET COMPATIBILITY_LEVEL = 140
GO
ALTER DATABASE [SpeakingLogs] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SpeakingLogs] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SpeakingLogs] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SpeakingLogs] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SpeakingLogs] SET ARITHABORT OFF 
GO
ALTER DATABASE [SpeakingLogs] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SpeakingLogs] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SpeakingLogs] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SpeakingLogs] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SpeakingLogs] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SpeakingLogs] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SpeakingLogs] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SpeakingLogs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SpeakingLogs] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [SpeakingLogs] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SpeakingLogs] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [SpeakingLogs] SET  MULTI_USER 
GO
ALTER DATABASE [SpeakingLogs] SET ENCRYPTION ON
GO
ALTER DATABASE [SpeakingLogs] SET QUERY_STORE = ON
GO
ALTER DATABASE [SpeakingLogs] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/****** Object:  Table [dbo].[SpeakingLog]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpeakingLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[TalkDate] [date] NOT NULL,
	[EventName] [varchar](255) NOT NULL,
	[City] [varchar](255) NULL,
	[Country] [varchar](255) NULL,
	[Postcode] [varchar](20) NULL,
	[Attendance] [int] NULL,
	[Tags] [nvarchar](1024) NULL,
	[TalkType] [varchar](100) NULL,
	[TalkLevel] [int] NULL,
 CONSTRAINT [PK_SpeakingLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RecordCountByTags]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RecordCountByTags]
AS

SELECT 
	LTRIM(RTRIM(VALUE)) AS Tag,
	COUNT(*) AS RecordCount
FROM 
	[dbo].[SpeakingLog]
	CROSS APPLY STRING_SPLIT([Tags],',')
GROUP BY
	VALUE

GO
/****** Object:  View [dbo].[TagsSplit]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TagsSplit]
AS

SELECT 
	LogId,
	LTRIM(RTRIM(VALUE)) AS Tag,
	COUNT(*) AS RecordCount
FROM 
	[dbo].[SpeakingLog]
	CROSS APPLY STRING_SPLIT([Tags],',')
GROUP BY
	LogId,
	VALUE

GO
/****** Object:  Table [dbo].[EventLogos]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLogos](
	[EventName] [varchar](255) NOT NULL,
	[ImageURL] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpeakingLogYouTube]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpeakingLogYouTube](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[TalkDate] [date] NOT NULL,
	[EventName] [varchar](255) NOT NULL,
	[City] [varchar](255) NULL,
	[Country] [varchar](255) NULL,
	[Postcode] [varchar](20) NULL,
	[Attendance] [int] NULL,
	[Tags] [nvarchar](1024) NULL,
	[TalkType] [varchar](100) NULL,
	[TalkLevel] [int] NULL,
	[YouTubeURL] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideoDetails]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoDetails](
	[VideoId] [varchar](50) NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[ChannelName] [varchar](255) NULL,
 CONSTRAINT [PK_VideoDetails] PRIMARY KEY CLUSTERED 
(
	[VideoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VideoLog]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[VideoId] [varchar](50) NOT NULL,
	[ViewsSnapShotDate] [date] NOT NULL,
	[Views] [int] NULL,
 CONSTRAINT [PK_VideoLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [noncIdx_VideoId]    Script Date: 06/10/2020 11:11:51 ******/
CREATE NONCLUSTERED INDEX [noncIdx_VideoId] ON [dbo].[VideoLog]
(
	[VideoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SetFirstVideoLogEntry]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetFirstVideoLogEntry]
AS
BEGIN

	IF EXISTS
		(
		SELECT 
			*
		FROM 
			[dbo].[VideoDetails] vd
			LEFT OUTER JOIN [dbo].[VideoLog] vl
				ON vd.[VideoId] = vl.[VideoId]
		WHERE
			vl.[VideoId] IS NULL
		)
		BEGIN
	
			INSERT INTO [dbo].[VideoLog]
				(
				[VideoId],
				[ViewsSnapShotDate],
				[Views]
				)
			SELECT 
				vd.[VideoId],
				vd.[CreatedDate],
				0
			FROM 
				[dbo].[VideoDetails] vd
				LEFT OUTER JOIN [dbo].[VideoLog] vl
					ON vd.[VideoId] = vl.[VideoId]
			WHERE
				vl.[VideoId] IS NULL;

		END;

END;
GO
/****** Object:  StoredProcedure [dbo].[SetViewsLogEntry]    Script Date: 06/10/2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SetViewsLogEntry]
	(
	@VideoId VARCHAR(50),
	@Views INT
	)
AS
BEGIN
	
	DELETE FROM
		[dbo].[VideoLog]
	WHERE
		[ViewsSnapShotDate] = CAST(GETDATE() AS DATE)
		AND [VideoId] = @VideoId;

	INSERT INTO [dbo].[VideoLog]
		(
		[VideoId],
		[ViewsSnapShotDate],
		[Views]
		)
	VALUES
		(
		@VideoId,
		GETDATE(),
		@Views
		);

END
GO
ALTER DATABASE [SpeakingLogs] SET  READ_WRITE 
GO
