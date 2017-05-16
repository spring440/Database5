USE [s17guest05]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'insert_presenter')
                    AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE [dbo].[insert_presenter]
GO
create procedure [dbo].[insert_presenter]
(@presenter varchar(60),@title varchar(150))
as
begin try

insert into [dbo].[person]
([full_name])
values (@presenter)

insert into [dbo].[presentation]
([title])
values(@title)

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
exec insert_presenter 'Speaker1','Presentation1'