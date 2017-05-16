--============================================
--Author: Dawei Zhang
--Date: 5/15/17
--BACK UP DATA
--============================================

USE S17guest05
GO
BACKUP DATABASE S17guest05
 TO DISK = 'C:\SQLServerBackups\sqlSaturday.bak'  
   WITH FORMAT;  
GO