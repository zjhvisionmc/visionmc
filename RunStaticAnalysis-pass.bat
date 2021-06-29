@echo off
setlocal enableextensions enabledelayedexpansion

rem +---------------------------------------------------------+
rem | Author : M.W.Richardson                                 |
rem | Date   : 20/06/2016                                     |
rem |                                                         |
rem | Searches for all nested source and header files         |
rem | It then creates a .tcf file                             |
rem |                                                         |
rem | Copyright : (c) 2016 Liverpool Data Research Associates |
rem +---------------------------------------------------------+

rem Create tcf file
rem ===============
echo.

rem Configure variables that are likely to change
rem =============================================
set PRJ_NAME=NewSet
set TBED="C:\LDRA_Toolsuite"
set WORKAREA_BASEDIR=C:\LDRA_Workarea
set TOOL=contestbed

set SET_NAME=NewSet
set SET_CURR_PATH=%CD%
set SET_TCF="%SET_CURR_PATH%\%SET_NAME%.tcf"
set NTP=C:\Program Files\Notepad++\


echo # Begin Testbed Set> %SET_TCF%
echo. >> %SET_TCF%
echo    SET_TYPE = SYSTEM>> %SET_TCF%
echo    SET_NAME = %SET_NAME%>> %SET_TCF%
echo    GENERATED_BY = SCRIPT>> %SET_TCF%
echo. >> %SET_TCF%
echo    # Begin Source Files>> %SET_TCF%
echo. >> %SET_TCF%

rem For each c file, except inszt ones
rem ==================================
cd /d %SET_CURR_PATH%
for /r %%f in (*.c) do (
  set file_name=%%~nf
  rem If the file starts with inszt_ then ignore it
  set "value=!file_name:inszt_=!"
  if "!value!" == "!file_name!" (
    echo       File = %%f >> %SET_TCF%
  )
)
echo. >> %SET_TCF%
echo    # End Source Files>> %SET_TCF%
echo. >> %SET_TCF%
echo    # Begin Sysearch Include File Entries>> %SET_TCF%
echo. >> %SET_TCF%
rem For each folder containing a .h file
rem ====================================
if exist %cd%\*.h echo       SearchPath = %cd% >> %SET_TCF%
for /D /r %%d in (*) do (
  if exist %%d\*.h echo       SearchPath = %%d >> %SET_TCF%
)
echo. >> %SET_TCF%
echo    # End Sysearch Include File Entries>> %SET_TCF%
echo. >> %SET_TCF%
echo    # Begin Sysppvar Preprocessor Macros>> %SET_TCF%
echo. >> %SET_TCF%
echo       MacroEntry = TUTORIAL 1 >> %SET_TCF%
echo. >> %SET_TCF%
echo    # End Sysppvar Preprocessor Macros>> %SET_TCF%
echo. >> %SET_TCF%
echo # End Testbed Set>> %SET_TCF%
echo. >> %SET_TCF%
echo # Begin Options>> %SET_TCF%
echo. >> %SET_TCF%
echo. $ Options for static analysis>> %SET_TCF%
echo    include = True>> %SET_TCF%
echo    open_all_includes = False>> %SET_TCF%
echo    shorten = True>> %SET_TCF%
echo    cstandards_model = MISRA-C:2012/AMD1>> %SET_TCF%
echo    cexternal_standard = MISRA-C:2012/AMD1>> %SET_TCF%
echo. >> %SET_TCF%
echo. $ Options for dynamic analysis>> %SET_TCF%
echo    nb_substitute_source = True>> %SET_TCF%
echo    nb_start_in_dir = %CD%\Src\>> %SET_TCF%

rem echo. $ Options for custom coverage reporting>> %SET_TCF%
rem echo    dyn_scan_option = 10>> %SET_TCF%
rem echo    dyn_scan_custom_data = 8 1 1 1 0 1 1 1 1>> %SET_TCF%
rem echo    dyn_scan_custom_coverage = 5 60 100 100 60 100>> %SET_TCF%
rem echo    dyn_scan_current_coverage = 5 100 100 100 100 100>> %SET_TCF%
echo. >> %SET_TCF%
echo # End Options>> %SET_TCF%
echo.


rem after create TCF deal witl Static Analysis



rem Configure relative paths 
rem ========================

set WORKDIR=%WORKAREA_BASEDIR%\%PRJ_NAME%_tbwrkfls

rem Delete the existing set and work directory
rem ==========================================
start "ldra" /wait /min %TBED%\%TOOL% /delete_set=%PRJ_NAME%
if exist %WORKDIR% rmdir /s /q %WORKDIR%


start "ldra" /wait /min %TBED%\%TOOL% -generate_code_review=HTML %SET_TCF% /112a34q

if exist %SET_CURR_PATH%\HTML rmdir /s /q %SET_CURR_PATH%\HTML

md %SET_CURR_PATH%\HTML


copy %WORKDIR%\*.htm %SET_CURR_PATH%\HTML
copy %WORKDIR%\imagejs.js %SET_CURR_PATH%\HTML