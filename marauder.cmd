@echo off
title Marauder 
chcp 65001 > nul


echo type "-h" for more information

:main

set /p typer="[1;90mMarauder[0m[31m> [0m"

if "%typer%" EQU "whunt" ( goto whunt )
if "%typer%" EQU "-h" ( goto options )
if "%typer%" EQU "wphunt" ( goto wphunt )
if "%typer%" EQU "ls" ( goto ls )
if "%typer%" EQU "clear" ( goto clear )
if "%typer%" EQU "whunt -hck" ( goto whunt2 )
if "%typer%" EQU "viewip" ( goto viewip )
if "%typer%" EQU "stalker" ( goto stalker ) 

:whunt
echo  SSID:
for /f "tokens=2 delims=:" %%b in ( 'netsh wlan show all ^| find "Security key" ' ) do ( set keystate=%%b )
for /f "tokens=2 delims=:" %%a in ( 'netsh wlan show profiles' ) do (

if "%keystate%" EQU " Present" ( %keystate%=yes )

echo [1;90m%%a[0m keystate:[31m%keystate%[0m

)
goto main


:wphunt
echo  SSID:
for /f "tokens=2 delims=:" %%a in ( 'netsh wlan show profiles' ) do (

for /f "tokens=4" %%b in ( 'netsh wlan show profile %%a key^=clear ^| find "Key Content" ' ) do (

echo [1;90m%%a's password[0m:[31m%%b[0m

)
)
goto main


:options
echo [1;90mwhunt[0m: show all saved in this computer
echo [1;90mwphunt[0m: show all wifi password saved in this computer
echo [1;90m-h[0m: for getting more information 
echo [1;90mls[0m: show all repositories
echo [1;90mclear[0m: clear the Marauder terminal
echo [1;90mviewip[0m show our ip address and more
echo [1;90mstalker:[0m scan the LAN network

goto main


:clear
cls 
goto main


:viewip

for /f "tokens=2 delims=:" %%a in ( 'ipconfig ^| find "IPv4" ' ) do ( set ip=%%a )

for /f %%c in (' curl https:/ipinfo.io/ip ' ) do ( set pubip=%%c )

for /f "tokens=2 delims=:" %%e in ( 'ipconfig ^| find "Gateway" ' ) do ( set router=%%e )

for /f "tokens=9 delims=: " %%f in ( 'ping %router% ^| find "Average" ') do ( set rping=%%f )

for /f "tokens=9 delims=: " %%b in ( 'ping %ip% ^| find "Average" ') do (

echo local ip:%ip% ping:%%b
echo public ip:%pubip% 
echo router:%router% ping:%rping%

)

goto main


:stalker
for /f "tokens=2 delims=:" %%c in ( 'ipconfig ^| find "IPv4" ' ) do ( set myip=%%c )
for /f "tokens=2" %%v in ( 'ping -a -n 1 %myip%^| find "[" ' ) do ( set pingu=%%v )

echo LAN:     YOU:%myip%[[31m%pingu%[0m]
for /f "skip=3" %%a in ( 'arp -A' ) do (

for /f "tokens=2" %%b in ( 'ping -a -n 1 %%a ^| find "[" ' ) do (

echo [1;90m%%a[0m DNS:[31m%%b[0m

)
)
goto main


:ls
for /f "tokens=4 skip=7" %%a in ( 'dir' ) do (
  
    echo 0^]^> [31m%%a[0m
)
goto main 

:whunt2

set /a num=0

cls
for /f "tokens=2 delims=:" %%a in ( 'netsh wlan show profiles' ) do (

for /f "tokens=4" %%b in ( 'netsh wlan show profile %%a key^=clear ^| find "Key Content" ' ) do (

set ssid=%%a
set wp=%%b
call :checker

)
)

:checker
cls
set /a num=%num%+1
echo creation hecker.hck:#===%num%===#
echo %ssid%'s password:%wp% >> hecker.hck 
