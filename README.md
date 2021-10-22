# backup-script

This is a script for a backup of my D drive where all my data resides.

## do-backup.cmd

The actual backup script, can be used with parameters.
It is a wrapper to robocopy with some parameters that mirrors the source content to a destination folder.

It also creates a log file (robocopy output) and an info file, especially useful when running as a scheduled task to view the last run.

Usage:
```
do-backup.cmd SOURCE DESTINATION NAME [FILTER] [PARAMS]
```

* SOURCE: The source directory that shall be used to backup.
* DESTINATION: The destination directory where the SOURCE content will be mirrored to.
* NAME: Name of the backup job, used for log files and info files.
* FILTER: Optional: file filter to use. If omitted, *.* is used.
* PARAMS: Optional: pass through additional parameters to robocopy.

## start-backup.cmd

Entry point for a scheduled-task to backup my D drive to an F drive as well as a NAS share.

Usage:
```
start-backup.cmd
```

Just calling the script directly.
This script is probably just useful on my own machine :-)
