@echo off
:: Get the current date in YYYYMMDD format
for /f "skip=1 tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i

:: Extract the year, month, and day
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%

:: Convert the numeric month to the abbreviated month name
setlocal enabledelayedexpansion
set "Month[01]=Jan"
set "Month[02]=Feb"
set "Month[03]=Mar"
set "Month[04]=Apr"
set "Month[05]=May"
set "Month[06]=Jun"
set "Month[07]=Jul"
set "Month[08]=Aug"
set "Month[09]=Sep"
set "Month[10]=Oct"
set "Month[11]=Nov"
set "Month[12]=Dec"
set Mon=!Month[%month%]!

:: Format the date as DD-Mon-YYYY
set DATE=%day%-%Mon%-%year%

:: Create the main directory
md %DATE%

:: Create the 'backup' and 'working' subdirectories within the main directory
md %DATE%\backup
md %DATE%\working



