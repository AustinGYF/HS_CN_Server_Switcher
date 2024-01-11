@echo off

:: Change the session to UTF-8
chcp 65001

:: Set the Honkai Star Rail Game dir and switcher working dir.
set GAME_PATH=
set SELECTOR_PATH=

:: User selecting server.
echo Select Server
echo 1. Mihoyo Server
echo 2. Bilibili Server
set /p option= Mihoyo Server(1) or Bilibili Server(2): 

::  The server is changed by:
::  1. The original config.ini file is deleted
::  2. The the config.ini file for the corresponding server is copied into the game_dir
::  3. The dependence of BiliBili Server is sorted.

IF /i %option%==1 goto guanFu
IF /i %option%==2 goto bFu

echo NOT FOUND.
goto commonexit

:guanFu
IF EXIST "%GAME_PATH%\sdk_pkg_version" (
    del "%GAME_PATH%\sdk_pkg_version"
)
IF EXIST "%GAME_PATH%\StarRail_Data\Plugins\failedlog.db" (
    del "%GAME_PATH%\StarRail_Data\Plugins\failedlog.db"
)
IF EXIST "%GAME_PATH%\StarRail_Data\Plugins\license.txt" (
    del "%GAME_PATH%\StarRail_Data\Plugins\license.txt"
)
IF EXIST "%GAME_PATH%\StarRail_Data\Plugins\PCGameSDK.dll" (
    del "%GAME_PATH%\StarRail_Data\Plugins\PCGameSDK.dll"
)
del "%GAME_PATH%\config.ini"
copy "%SELECTOR_PATH%\Gconfig.ini" "%GAME_PATH%\config.ini"
echo Now in Mihoyo Server
goto commonexit

:bFu
IF NOT EXIST "%GAME_PATH%\sdk_pkg_version" (
    copy "%SELECTOR_PATH%\B.dep\sdk_pkg_version" "%GAME_PATH%\sdk_pkg_version"
)
IF NOT EXIST "%GAME_PATH%\StarRail_Data\Plugins\failedlog.db" (
    copy "%SELECTOR_PATH%\B.dep\failedlog.db" "%GAME_PATH%\StarRail_Data\Plugins\failedlog.db"
)
IF NOT EXIST "%GAME_PATH%\StarRail_Data\Plugins\license.txt" (
    copy "%SELECTOR_PATH%\B.dep\license.txt" "%GAME_PATH%\StarRail_Data\Plugins\license.txt"
)
IF NOT EXIST "%GAME_PATH%\StarRail_Data\Plugins\PCGameSDK.dll" (
    copy "%SELECTOR_PATH%\B.dep\PCGameSDK.dll" "%GAME_PATH%\StarRail_Data\Plugins\PCGameSDK.dll"
)
del "%GAME_PATH%\config.ini"
copy "%SELECTOR_PATH%\Bconfig.ini" "%GAME_PATH%\config.ini"
echo Now in Bilibili Server
goto commonexit

:commonexit
pause

start /d "%GAME_PATH%" StarRail.exe