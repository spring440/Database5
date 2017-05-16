--USE s17guest05
--GO
--============================================
--Author: Dawei Zhang
--Date: 5/14/17
--Create TABLE
--============================================

-- delete TABLE if that is exists
-- Note: I did this part manually. I don't know how to put on FROM where is find the right 
--       repository of the tables.
--       Origanly tried this way:
--
--   IF EXISTS(SELECT * 
--   FROM odb.[s17guest05].Tables
--   WHERE table_name ='ATTENDEE_Address'
--   )DROP TABLE ATTENDEE_Address;
--


USE s17guest05
GO
/*==============================================================*/
/* Table: ATTENDEE                                              */
/*==============================================================*/
create table ATTENDEE 
(
   ATTENDEE_ID          integer                        not null IDENTITY,
   ROLE_ID              integer                        null,
   EMAIL_ADD            varchar(50)                    not null,
   constraint PK_ATTENDEE primary key (ATTENDEE_ID)
);

/*==============================================================*/
/* Index: ROLE_STUDENT2_FK                                      */
/*==============================================================*/
create nonclustered index ROLE_STUDENT2_FK on ATTENDEE (ROLE_ID ASC);


/*==============================================================*/
/* Table: ATTENDEE_ADDRESS                                      */
/*==============================================================*/
create table ATTENDEE_ADDRESS 
(
   ADDRESS_ID           integer                        not null IDENTITY,
   ATTENDEE_ID          integer                        null,
   STREET               varchar(50)                    not null,
   CITY                 varchar(50)                    not null,
   ZIPCODE              varchar(12)                    not null,
   STATES               varchar(50)                    not null,
   constraint PK_ATTENDEE_ADDRESS primary key (ADDRESS_ID)
);

/*==============================================================*/
/* Index: ADDRESS_PK                                            */
/*==============================================================*/
create nonclustered index ADDRESS_PK on ATTENDEE_ADDRESS (ADDRESS_ID ASC);

/*==============================================================*/
/* Index: ATTENDEE_ADDRESS2_FK                                  */
/*==============================================================*/
create nonclustered index ATTENDEE_ADDRESS2_FK on ATTENDEE_ADDRESS (ATTENDEE_ID ASC);

/*==============================================================*/
/* Table: COFERENCE_ORGANIZER                                   */
/*==============================================================*/
create table COFERENCE_ORGANIZER 
(
   ORGANIZER_ID         Integer                        not null,
   CONFERENCE_ID        Integer                        not null,
   constraint PK_COFERENCE_ORGANIZER primary key clustered (ORGANIZER_ID, CONFERENCE_ID)
);

/*==============================================================*/
/* Index: COFERENCE_VOLUNTEER_PK                                */
/*==============================================================*/
create unique nonclustered index COFERENCE_ORGANIZER_PK on COFERENCE_ORGANIZER (
ORGANIZER_ID ASC,
CONFERENCE_ID ASC
);

/*==============================================================*/
/* Index: ORGANIZER_ID_FK                                      */
/*==============================================================*/
create nonclustered index  COFERENCE_VOLUNTEER_FK on COFERENCE_ORGANIZER (
ORGANIZER_ID ASC
);

/*==============================================================*/
/* Index:  CONFERENCE_ID                                */
/*==============================================================*/
create nonclustered index COFERENCE_VOLUNTEER2_FK on COFERENCE_ORGANIZER (
 CONFERENCE_ID ASC
);

/*==============================================================*/
/* Table: COFERENCE_VOLUNTEER                                   */
/*==============================================================*/
create table COFERENCE_VOLUNTEER 
(
   CONFERENCE_ID        integer                        not null,
   VOLUNTEER_ID         integer                        not null,
   constraint PK_COFERENCE_VOLUNTEER primary key clustered (CONFERENCE_ID, VOLUNTEER_ID)
);

/*==============================================================*/
/* Index: CONFERENCE_ID_FK                                      */
/*==============================================================*/
create nonclustered index COFERENCE_VOLUNTEER_FK on COFERENCE_VOLUNTEER (
CONFERENCE_ID ASC
);

/*==============================================================*/
/* Index: VOLUNTEER_ID_FK                                       */
/*==============================================================*/
create nonclustered index COFERENCE_VOLUNTEER2_FK on COFERENCE_VOLUNTEER (
VOLUNTEER_ID ASC
);

/*==============================================================*/
/* Table: CONFERENCE                                            */
/*==============================================================*/
create table CONFERENCE 
(
   CONFERENCE_ID        integer                        not null,
   CONFERENCE_NAME      varchar(50)                    not null,
   CONFERENCE_DESCRIPTION varchar(255)                   not null,
   CONFERENCE_DATE      date                           not null,
   constraint PK_CONFERENCE primary key (CONFERENCE_ID)
);

/*==============================================================*/
/* Index: CONFERENCE_PK                                         */
/*==============================================================*/
create unique index CONFERENCE_PK on CONFERENCE (
CONFERENCE_ID ASC
);



/*==============================================================*/
/* Table: CONFERENCE_ATTENDEE                                   */
/*==============================================================*/
create table CONFERENCE_ATTENDEE 
(
   CONFERENCE_ID        integer                        not null,
   ATTENDEE_ID          integer                        not null,
   constraint PK_CONFERENCE_ATTENDEE primary key clustered (CONFERENCE_ID, ATTENDEE_ID)
);



/*==============================================================*/
/* Index: CONFERENCE_ATTENDEE_CONFERENCE_ID_FK                                */
/*==============================================================*/
create nonclustered index CONFERENCE_ATTENDEE_FK on CONFERENCE_ATTENDEE (
CONFERENCE_ID ASC
);

/*==============================================================*/
/* Index: CONFERENCE_ATTENDEE2_FK                               */
/*==============================================================*/
create nonclustered index CONFERENCE_ATTENDEE2_FK on CONFERENCE_ATTENDEE (
ATTENDEE_ID ASC
);

/*==============================================================*/
/* Table: CONFERENCE_SPONSOR_RELATION                           */
/*==============================================================*/
create table CONFERENCE_SPONSOR_RELATION 
(
   CONFERENCE_ID        integer                        not null,
   SPONSOR_ID           integer                        not null,
   constraint PK_CONFERENCE_SPONSOR_RELATION primary key clustered (CONFERENCE_ID, SPONSOR_ID)
);

/*==============================================================*/
/* Index: CONFERENCE_SPONSOR_RELATION_PK                        */
/*==============================================================*/


/*==============================================================*/
/* Index: CONFERENCE_SPONSOR_RELATION_FK                        */
/*==============================================================*/
create nonclustered index CONFERENCE_SPONSOR_RELATION_FK on CONFERENCE_SPONSOR_RELATION (
CONFERENCE_ID ASC
);

/*==============================================================*/
/* Index: CONFERENCE_SPONSOR_RELATION2_FK                       */
/*==============================================================*/
create nonclustered index CONFERENCE_SPONSOR_RELATION2_FK on CONFERENCE_SPONSOR_RELATION (
SPONSOR_ID ASC
);

/*==============================================================*/
/* Table: CONFERENCE_VENUES                                     */
/*==============================================================*/
create table CONFERENCE_VENUES 
(
   VENUES_ID            integer                        not null,
   CONFERENCE_ID        integer                        not null,
   constraint PK_CONFERENCE_VENUES primary key clustered (VENUES_ID, CONFERENCE_ID)
);

/*==============================================================*/
/* Index: CONFERENCE_VENUES_FK                                  */
/*==============================================================*/
create nonclustered index CONFERENCE_VENUES_FK on CONFERENCE_VENUES (
CONFERENCE_ID ASC
);

/*==============================================================*/
/* Index: CONFERENCE_VENUES2_FK                                 */
/*==============================================================*/
create nonclustered index CONFERENCE_VENUES2_FK on CONFERENCE_VENUES (
VENUES_ID ASC
);

/*==============================================================*/
/* Table: ORGANIZER                                             */
/*==============================================================*/
create table ORGANIZER 
(
   ORGANIZER_ID         Integer                        not null IDENTITY,
   PERSON_ID            integer                        null,
   constraint PK_ORGANIZER primary key clustered (ORGANIZER_ID)
);

/*==============================================================*/
/* Table: PERSON                                                */
/*==============================================================*/
create table PERSON 
(
   PERSON_ID            integer                        not null IDENTITY,
   ORGANIZER_ID         integer                        null,
   ROLE_NAME            varchar(10)                    not null,
   FIRST_NAME           varchar(30)                    not null,
   LAST_NAME            varchar(30)                    not null,
   constraint PK_PERSON primary key (PERSON_ID)
);

/*==============================================================*/
/* Index: ROLE_PK                                               */
/*==============================================================*/
create unique index ROLE_PK on PERSON (
PERSON_ID ASC
);


/*==============================================================*/
/* Table: PRESENTER                                             */
/*==============================================================*/
create table PRESENTER 
(
   PRESENTER_ID         integer                        not null IDENTITY,
   ROLE_ID              integer                        null,
   constraint PK_PRESENTER primary key (PRESENTER_ID)
);

/*==============================================================*/
/* Index: PRESENTER_PK                                          */
/*==============================================================*/
create unique index PRESENTER_PK on PRESENTER (
PRESENTER_ID ASC
);

/*==============================================================*/
/* Index: ROLE_PRESENTER_ROLE_ID_FK                                    */
/*==============================================================*/
create nonclustered index ROLE_PRESENTER2_FK on PRESENTER (
ROLE_ID ASC
);

/*==============================================================*/
/* Table: PRESETATION                                           */
/*==============================================================*/
create table PRESETATION 
(
   PRESENTATION_ID      integer                        not null IDENTITY,
   CONFERENCE_ID        integer                        null,
   TITLE                varchar(150)                    not null,
   DESCRIPTION          varchar(255)                   not null,
   DIFFICULTY_LEVEL     varchar(12)                     not null,
   DURATION             varchar(10)                    not null,
   AVERAGE_GRADE        integer                        not null,
   constraint PK_PRESETATION primary key (PRESENTATION_ID)
);

/*==============================================================*/
/* Index: PRESETATION_PK                                        */
/*==============================================================*/
create unique index PRESETATION_PK on PRESETATION (
PRESENTATION_ID ASC
);

/*==============================================================*/
/* Index: SCHEDULE_PRESETATION_FK                               */
/*==============================================================*/
create nonclustered index SCHEDULE_PRESETATION_FK on PRESETATION (
CONFERENCE_ID ASC
);



/*==============================================================*/
/* Table: PRESETATION_PRESENTER                                 */
/*==============================================================*/
create table PRESETATION_PRESENTER 
(
   PRESENTER_ID         integer                        not null,
   PRESENTATION_ID      integer                        not null,
   constraint PK_PRESETATION_PRESENTER primary key clustered (PRESENTER_ID, PRESENTATION_ID)
);

/*==============================================================*/
/* Index: PRESETATION_PRESENTER_FK                              */
/*==============================================================*/
create nonclustered index PRESETATION_PRESENTER_FK on PRESETATION_PRESENTER (
PRESENTER_ID ASC
);

/*==============================================================*/
/* Index: PRESETATION_PRESENTER2_FK                             */
/*==============================================================*/
create index PRESETATION_PRESENTER2_FK on PRESETATION_PRESENTER (
PRESENTATION_ID ASC
);

/*==============================================================*/
/* Table: PRESETATION_TRACK                                     */
/*==============================================================*/
create table PRESETATION_TRACK 
(
   PRESENTATION_ID      integer                        not null,
   TRACK_ID             integer                        not null,
   constraint PK_PRESETATION_TRACK primary key clustered (PRESENTATION_ID, TRACK_ID)
);


/*==============================================================*/
/* Index: PRESETATION_TRACK_FK                                  */
/*==============================================================*/
create nonclustered index PRESETATION_TRACK_FK on PRESETATION_TRACK (
PRESENTATION_ID ASC
);

/*==============================================================*/
/* Index: PRESETATION_TRACK2_FK                                 */
/*==============================================================*/
create index PRESETATION_TRACK2_FK on PRESETATION_TRACK (
TRACK_ID ASC
);

/*==============================================================*/
/* Table: PRICE                                                 */
/*==============================================================*/
create table PRICE 
(
   PRICE_ID             integer                        not null IDENTITY,
   RULFFEL_ID           integer                        null,
   PRICE_NAME           varchar(10)                    not null,
   constraint PK_PRICE primary key (PRICE_ID)
);

/*==============================================================*/
/* Index: PRICE_PK                                              */
/*==============================================================*/
create unique index PRICE_PK on PRICE (
PRICE_ID ASC
);

/*==============================================================*/
/* Index: RUFFEL_PRICE2_FK                                      */
/*==============================================================*/
create nonclustered index RUFFEL_PRICE2_FK on PRICE (
RULFFEL_ID ASC
);

/*==============================================================*/
/* Table: ROOM                                                  */
/*==============================================================*/
create table ROOM 
(
   ROOM_ID              Integer                        not null IDENTITY,
   VENUES_ID            integer                        null,
   ROOM_NAME            varchar(10)                    not null,
   ROOM_CAPACITY        Integer                        not null,
   constraint PK_ROOM primary key clustered (ROOM_ID)
);

/*==============================================================*/
/* Table: RUFFEL                                                */
/*==============================================================*/
create table RUFFEL 
(
   RULFFEL_ID           integer                        not null IDENTITY,
   CONFERENCE_ID        integer                        null,
   constraint PK_RUFFEL primary key (RULFFEL_ID)
);

/*==============================================================*/
/* Index: RUFFEL_PK                                             */
/*==============================================================*/
create unique index RUFFEL_PK on RUFFEL (
RULFFEL_ID ASC
);

/*==============================================================*/
/* Index: CONFERENCE_RUFFEL_FK                                 */
/*==============================================================*/
create nonclustered index CONFERENCE_RUFFEL_FK on RUFFEL (
CONFERENCE_ID ASC
);


/*==============================================================*/
/* Table: SCHEDULE                                              */
/*==============================================================*/
create table SCHEDULE 
(
   SCHEDULE_ID          integer                        not null IDENTITY,
   PRESENTATION_ID      integer                        null,
   ROOM_ID              Integer                        null,
   START_TIME           time                           not null,
   END_TIME             time                           not null,
   constraint PK_SCHEDULE primary key (SCHEDULE_ID)
);

/*==============================================================*/
/* Index: SCHEDULE_PK                                           */
/*==============================================================*/
create unique index SCHEDULE_PK on SCHEDULE (
SCHEDULE_ID ASC
);

/*==============================================================*/
/* Index: SCHEDULE_PRESETATION_FK                               */
/*==============================================================*/
create nonclustered index SCHEDULE_PRESETATION_FK on SCHEDULE (
PRESENTATION_ID ASC
);

/*==============================================================*/
/* Table: SPONSOR                                               */
/*==============================================================*/
create table SPONSOR 
(
   SPONSOR_ID           integer                        not null IDENTITY,
   SPONSOR_NAME         varchar(50)                    not null,
   SPONSOR_LEVEL        varchar(25)                    not null,
   SPONSOR_TABLE        int  CONSTRAINT consSPONSOR_TABLE 
							 CHECK(SPONSOR_TABLE>= 1 and SPONSOR_TABLE <= 10) 
                             not null,
   constraint PK_SPONSOR primary key (SPONSOR_ID)
);

/*==============================================================*/
/* Index: SPONSOR_PK                                            */
/*==============================================================*/
create unique index SPONSOR_PK on SPONSOR (
SPONSOR_ID ASC
);

/*==============================================================*/
/* Table: TRACK                                                 */
/*==============================================================*/
create table TRACK 
(
   TRACK_ID             integer                        not null IDENTITY,
   TOPIC                varchar(50)                    not null,
   constraint PK_TRACK primary key (TRACK_ID)
);

/*==============================================================*/
/* Index: TRACK_PK                                              */
/*==============================================================*/
create unique index TRACK_PK on TRACK (
TRACK_ID ASC
);

/*==============================================================*/
/* Table: VENUES                                                */
/*==============================================================*/
create table VENUES 
(
   VENUES_ID            integer                        not null IDENTITY,
   CITY_NAME            varchar(60)                    not null,
   REGION               varchar(25)                    not null,
   constraint PK_VENUES primary key (VENUES_ID)
);

/*==============================================================*/
/* Index: VENUES_PK                                             */
/*==============================================================*/
create unique index VENUES_PK on VENUES (
VENUES_ID ASC
);

/*==============================================================*/
/* Table: VOLUNTEER                                             */
/*==============================================================*/
create table VOLUNTEER 
(
   VOLUNTEER_ID         integer                        not null IDENTITY,
   ROLE_ID              integer                        null,
   constraint PK_VOLUNTEER primary key (VOLUNTEER_ID)
);

/*==============================================================*/
/* Index: VOLUNTEER_PK                                          */
/*==============================================================*/
create unique index VOLUNTEER_PK on VOLUNTEER (
VOLUNTEER_ID ASC
);

/*==============================================================*/
/* Index: ROLE_VOLUNTEER_FK                                     */
/*==============================================================*/
create nonclustered index ROLE_VOLUNTEER_FK on VOLUNTEER (
ROLE_ID ASC
);

alter table ATTENDEE
   add constraint FK_ATTENDEE_ROLE_ID foreign key (ROLE_ID)
      references PERSON (PERSON_ID);

alter table ATTENDEE_ADDRESS
   add constraint FK_ATTENDEE_ADDRESS_ATTENDEE_ID foreign key (ATTENDEE_ID)
      references ATTENDEE (ATTENDEE_ID);

alter table COFERENCE_ORGANIZER
   add constraint FK_COFERENC_ORGANIZE_ORGANIZER_ID foreign key (ORGANIZER_ID)
      references ORGANIZER (ORGANIZER_ID);

alter table COFERENCE_ORGANIZER
   add constraint FK_COFERENCE_ORGANIZER_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table COFERENCE_VOLUNTEER
   add constraint FK_COFERENCE_VOLUNTEER_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table COFERENCE_VOLUNTEER
   add constraint FK_COFERENCE_VOLUNTEER_VOLUNTEER_ID foreign key (VOLUNTEER_ID)
      references VOLUNTEER (VOLUNTEER_ID);

alter table CONFERENCE_ATTENDEE
   add constraint FK_CONFERENCE_ATTENDEE_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table CONFERENCE_ATTENDEE
   add constraint FK_CONFERENCE_ATTENDEE_ATTENDEE_ID foreign key (ATTENDEE_ID)
      references ATTENDEE (ATTENDEE_ID);


alter table CONFERENCE_SPONSOR_RELATION
   add constraint FK_CONFERENCE_SPONSOR_RELATION_SPONSOR_ID foreign key (SPONSOR_ID)
      references SPONSOR (SPONSOR_ID);

alter table CONFERENCE_VENUES
   add constraint FK_CONFERENCE_VENUES_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table CONFERENCE_VENUES
   add constraint FK_CONFERENCE_VENUES_VENUES_ID foreign key (VENUES_ID)
      references VENUES (VENUES_ID);

alter table ORGANIZER
   add constraint FK_ORGANIZER_PERSON_ID foreign key (PERSON_ID)
      references PERSON (PERSON_ID);

alter table PRESENTER
   add constraint FK_PRESENTER_ROLE_ID foreign key (ROLE_ID)
      references PERSON (PERSON_ID);

alter table PRESETATION
   add constraint FK_PRESETATION_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table PRESETATION_PRESENTER
   add constraint FK_PRESETATION_PRESENTER_PRESENTER_ID foreign key (PRESENTER_ID)
      references PRESENTER (PRESENTER_ID);

alter table PRESETATION_PRESENTER
   add constraint FK_PRESETATION_PRESENTER_PRESENTATION_ID foreign key (PRESENTATION_ID)
      references PRESETATION (PRESENTATION_ID);

alter table PRESETATION_TRACK
   add constraint FK_PRESETATION_TRACK_PRESENTATION_ID foreign key (PRESENTATION_ID)
      references PRESETATION (PRESENTATION_ID);

alter table PRESETATION_TRACK
   add constraint FK_PRESETATION_TRACK_TRACK_ID foreign key (TRACK_ID)
      references TRACK (TRACK_ID);

alter table PRICE
   add constraint FK_PRICE_RULFFEL_ID foreign key (RULFFEL_ID)
      references RUFFEL (RULFFEL_ID);

alter table ROOM
   add constraint FK_ROOM_VENUES_ID foreign key (VENUES_ID)
      references VENUES (VENUES_ID);

alter table RUFFEL
   add constraint FK_RUFFEL_CONFERENCE_ID foreign key (CONFERENCE_ID)
      references CONFERENCE (CONFERENCE_ID);

alter table SCHEDULE
   add constraint FK_SCHEDULE_ROOM_ID foreign key (ROOM_ID)
      references ROOM (ROOM_ID);

alter table SCHEDULE
   add constraint FK_SCHEDULE_PRESENTATION_ID foreign key (PRESENTATION_ID)
      references PRESETATION (PRESENTATION_ID);

alter table VOLUNTEER
   add constraint FK_VOLUNTEER_ROLE_ID foreign key (ROLE_ID)
      references PERSON (PERSON_ID);

--===============================================================
-- For the maintain purpose:
-- 1.DROP The constraint of the table
-- Use ATTENDEE as a example
/*
SELECT * 
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('CONFERENCE');

SELECT 
    'ALTER TABLE [' +  OBJECT_SCHEMA_NAME(parent_object_id) +
    '].[' + OBJECT_NAME(parent_object_id) + 
    '] DROP CONSTRAINT [' + name + ']'
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('ATTENDEE')

ALTER TABLE [dbo].[ATTENDEE] DROP CONSTRAINT [FK_ATTENDEE_ATTENDEE__ADDRESS]
*/