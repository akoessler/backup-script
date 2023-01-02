@echo off

set SCRIPTPATH=%~dp0

echo.
echo.
echo Run backup to I
echo.
echo.

call %SCRIPTPATH%\do-backup.cmd D:\ I:\BackupD\ backup-to-i

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
