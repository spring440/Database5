--============================================
--Author: Dawei Zhang
--Date: 5/15/17
--BACK UP DATA
--============================================

USE S17guest05
GO
BACKUP DATABASE S17guest05
 TO DISK = 'C:\Users\dz\Documents\SQL Server Management Studio\Backup_sqlSaturday.bak'  
   WITH FORMAT,
      MEDIANAME = 'SQLSaturday',  
      NAME = 'Full Backup of sqlSaturday';  
GO  