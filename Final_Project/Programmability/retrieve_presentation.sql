USE [s17guest05]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'retrieve_presentation')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE [dbo].[retrieve_presentation]
GO
create procedure [dbo].[retrieve_presentation]
as
begin try

select a.* from presentation as a join conference as b on a.conference_id = b.conference_id
join conference_venues as c on b.conference_id = c.conference_id join venues as d on c.venues_id = d.venues_id 
where d. city_name = 'Budapest'

End try 

begin catch
declare @ErrorMessage nvarchar(4000)
declare @ErrorSeverty INT
declare @ErrorState INT
select @ErrorMessage = ERROR_MESSAGE(),
       @ErrorSeverty = ERROR_SEVERITY(),
	   @ErrorState = ERROR_STATE()

	   Raiserror (@ErrorMessage,@ErrorSeverty,@ErrorState);
end catch

GO

exec retrieve_presentation