@echo off

set SCRIPTPATH=%~dp0

echo.
echo.
echo Run backup to F
echo.
echo.

call %SCRIPTPATH%\do-backup.cmd D:\ F:\BackupD\ backup-to-f

echo.
echo.
echo Run backup to NAS
echo.
echo.

call %SCRIPTPATH%\do-backup.cmd D:\ \\NAS\BACKUP\BackupD\ backup-to-nas

echo.
echo.
echo Backup finished
echo.
echo.
