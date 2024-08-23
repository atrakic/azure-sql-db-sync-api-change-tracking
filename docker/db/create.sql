DROP DATABASE IF EXISTS demo;
GO

CREATE DATABASE demo;
PRINT 'Creating demo database ...';
GO

ALTER DATABASE demo
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON)


ALTER DATABASE demo
SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE demo
SET ALLOW_SNAPSHOT_ISOLATION ON
GO

USE [demo]
GO

if not exists(select * from sys.sequences where [name] = 'Ids')
begin
    create sequence dbo.Ids
    as int
    start with 1;
end
go

drop table if exists dbo.TrainingSessions;
create table dbo.TrainingSessions
(
    [Id] int primary key not null default(next value for dbo.Ids),
    [RecordedOn] datetimeoffset not null,
    [Type] varchar(50) not null,
    [Steps] int not null,
    [Distance] int not null, --Meters
    [Duration] int not null, --Seconds
    [Calories] int not null,
    [PostProcessedOn] datetimeoffset null,
    [AdjustedSteps] int null,
    [AdjustedDistance] decimal(9,6) null
);
go

if not exists(select * from sys.change_tracking_databases where database_id = db_id())
begin
    alter database ct_sample
    set change_tracking = on
    (change_retention = 30 days, auto_cleanup = on)
end
go

if not exists(select * from sys.change_tracking_tables where [object_id]=object_id('dbo.TrainingSessions'))
begin
    alter table dbo.TrainingSessions
    enable change_tracking
end
go
