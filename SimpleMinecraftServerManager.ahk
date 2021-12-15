#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir%
SplitPath, A_ScriptName, , , , GameScripts
#MaxThreadsPerHotkey, 4 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag
#Persistent
;____________________________________________________________
;____________________________________________________________
;//////////////[Folders]///////////////
AppName= SimpleMinecraftServerManager
AppFolderName = AHKGameScriptsByVeskeli
AppFolder = %A_AppData%\%AppFolderName%\OtherScripts\%AppName%
AppSettingsFolder = %AppFolder%\Settings
ServerFolder = %AppFolder%\Servers
;//////////////[Inis]///////////////
AppSettingsIni = %AppSettingsFolder%\Settings.ini
;//////////////[Update]///////////////
AppUpdateFile = %AppFolder%\temp\OldFile.ahk
version = 0.1
;____________________________________________________________
;//////////////[variables]///////////////
global NewProfileName
global ServerFolder
global DropDownList1
global ServerJarFile
;____________________________________________________________
;//////////////[old File]///////////////
IfExist %AppUpdateFile%
{
    FileDelete, %AppUpdateFile% ;delete old file after update
    FileRemoveDir, %AppFolder%\temp ;Delete temp directory
}
;____________________________________________________________
;____________________________________________________________
;//////////////[Gui]///////////////
Gui -MaximizeBox
Gui Font, s9, Segoe UI
Gui Add, Tab3, x0 y0 w864 h525, Home|Settings
;//////////////[Home]///////////////
Gui Tab, 1
Gui Add, Text, x8 y32 w44 h23 +0x200, Server:
Gui Add, DropDownList, x56 y32 w287 vDropDownList1 gUpdateBasedOnProfile, 
Gui Add, Button, x344 y32 w80 h23 gCreateNewProfile, Create new
Gui Add, Button, x432 y32 w87 h23 gDeleteProfile, Delete Current
Gui Add, GroupBox, x8 y63 w536 h91, Server jar
Gui Add, Text, x16 y88 w60 h23 +0x200, Server Jar:
Gui Add, Edit, x80 y88 w362 h21 +Disabled vServerJarFile
Gui Add, Button, x448 y87 w80 h23 +Disabled vSelectNewServerJar gSelectNewServerJarButton, Select new
Gui Add, Text, x16 y112 w519 h33, This script cannot download minecraft server files yet. `nYou need to download it from launcher or website and then press "select new" and select that file
Gui Add, GroupBox, x8 y160 w224 h203, Server settings
Gui Add, Text, x16 y184 w54 h23 +0x200, Difficulty:
Gui Add, DropDownList, x96 y184 w120 +Disabled vDifficultyBox, Easy||Normal|Hard|Peaceful
Gui Add, Text, x16 y208 w73 h23 +0x200, Gamemode:
Gui Add, DropDownList, x96 y208 w120 +Disabled vGameModeBox, Survival||Creative|Adventure
Gui Add, Text, x16 y232 w87 h23 +0x200, View Distance:
Gui Add, Edit, x104 y232 w113 h21 +Number +Disabled vViewDistanceBox, 10
Gui Add, GroupBox, x231 y160 w313 h203, Advanced settings
Gui Add, Text, x240 y184 w30 h23 +0x200, Port:
Gui Add, Edit, x272 y184 w120 h21 +Disabled vPortEdit, 25565
Gui Add, Text, x16 y256 w107 h23 +0x200, MOTD(Server text):
Gui Add, Edit, x16 y280 w207 h21 +Disabled vMOTDEdit, Cool Mincraft Server
Gui Add, CheckBox, x240 y216 w151 h23 +Disabled vAllowCommandBlocksCheck, Allow Command Blocks
Gui Add, Text, x16 y304 w60 h23 +0x200, Max Users
Gui Add, Edit, x80 y304 w120 h21 +Number +Disabled vMaxUsersEdit, 6
Gui Add, Text, x240 y240 w200 h23 +0x200, World Seed: (Empty = random seed)
Gui Add, Edit, x240 y264 w297 h21 +Disabled vWorldSeedEdit
Gui Add, Text, x240 y288 w120 h23 +0x200, Memory Limit [MB]
Gui Add, Edit, x368 y288 w120 h21 +Disabled vMemortLimitEdit, 2048
Gui Add, Text, x240 y312 w101 h23 +0x200, Set Memory limit:
Gui Add, DropDownList, x344 y312 w120 +Disabled vSetMemortLimitToBox, 2Gb||1gb|3Gb|4Gb|5Gb|6Gb
Gui Add, Button, x464 y312 w66 h23 +Disabled vSetMemortLimitTo, Set
Gui Add, Button, x56 y336 w122 h23 +Disabled vSaveSettings gSaveSettings, Save Settings
Gui Add, Button, x328 y336 w102 h23 +Disabled vSaveAdvancedSettings gSaveAdvancedSettings, Save Settings
Gui Font
Gui Font, s15
Gui Add, Button, x240 y384 w220 h40  vStartServerFirstTime gStartServerFirstTime, First Time Start Server
Gui Font, s15
Gui Add, Button, x460 y384 w160 h40  vStartServer gStartServer, Start Server
Gui Font, s12
Gui Add, Button, x632 y368 w145 h38 +Disabled vAcceptEULA gAcceptEULAButton, Accept EULA
Gui Font
Gui Font, s9, Segoe UI
Gui Add, CheckBox, x16 y392 w177 h23 +Disabled, Start Ngrok When server starts
Gui Add, GroupBox, x8 y370 w226 h57, Server Start Settings
Gui Add, GroupBox, x552 y32 w307 h331, Guide
Gui Font
Gui Font, s8
Gui Add, Text, x560 y56 w290 h23 +0x200, Note: This is small minecraft manager with limited settings.
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Text, x560 y80 w292 h34, 1. Download Server jar from launcher or minecraft website. Then press "select new"
Gui Add, Text, x560 y120 w232 h30 , 2. Press "First Time Start Server". Server starts and then closes.
Gui Add, Text, x560 y155 w120 h23 , 3. Press "Accept EULA"
Gui Add, Text, x560 y176 w287 h45, 4. Change Server Settings And Advanced settings based what you need (Script is not reading values only writes)
Gui Add, Text, x560 y224 w293 h36, 5. Check Start Ngrok when server starts if you want to use it or Port foward the port that you are using.
Gui Add, Text, x560 y264 w290 h30, 6. Press start server. To close server write "stop" to console
Gui Font
Gui Font, s11
Gui Add, Text, x560 y304 w292 h36, Basic understanding of how console works is needed!
Gui Font
Gui Font, s9, Segoe UI
Gui Font
Gui Font, s9, Segoe UI
;//////////////[Settings]///////////////
Gui Tab, 2
Gui Add, GroupBox, x688 y380 w169 h52, Check Updates on start
Gui Add, CheckBox, x704 y400 w145 h23 +Disabled +Checked, Check updates on start
Gui Font
Gui Font, s15
Gui Add, Text, x688 y352 w166 h23 +0x200, Version: 0.1
Gui Font
Gui Font, s9, Segoe UI
Gui Add, GroupBox, x8 y280 w593 h118, Ngrok Settings
Gui Add, Link, x224 y296 w120 h23 +Disabled, <a href="https://autohotkey.com">Download Ngrok</a>
Gui Add, Text, x16 y296 w120 h23 +0x200, Ngrok.exe Location:
Gui Add, Edit, x16 y320 w489 h21 +Disabled
Gui Add, Button, x511 y319 w80 h23 +Disabled, Pick Location
Gui Add, Button, x16 y344 w80 h23 +Disabled, Save Location
Gui Add, CheckBox, x16 y368 w198 h23 +Checked +Disabled, Use Same Port As Minecraft server
Gui Add, Text, x224 y368 w48 h23 +0x200, Region:
Gui Add, Edit, x280 y368 w55 h21 +Disabled, eu
Gui Add, Edit, x424 y368 w76 h21 +Disabled, tcp
Gui Add, Text, x352 y368 w58 h24 +0x200, Protocol
Gui Tab

Gui Show, w863 h432, Minecraft Simple Server Manager [Early Access]
UpdateProfilesDropbox()
UpdateHomeScreen()
Gosub, checkForupdates
Return

GuiEscape:
GuiClose:
    ExitApp
2GuiEscape:
2GuiClose:
    Gui,2:Destroy
return
;____________________________________________________________
;//////////////[Create New Profile]///////////////
CreateNewProfile:
Gui 2:-MinimizeBox -MaximizeBox
Gui 2:Add, Text, x8 y8 w265 h23 +0x200, Server name (Only in manager):
Gui 2:Add, Edit, x8 y32 w268 h21 vNewProfileName
Gui 2:Add, Button, x112 y56 w80 h23 gSaveNewProfileName, Save
Gui 2:Add, Button, x200 y56 w80 h23 gCancelNewName, Cancel

Gui 2:Show, w284 h84, ProfileName
Return
CancelNewName:
    Gui,2:Destroy
Return
;____________________________________________________________
;//////////////[Save new profile]///////////////
SaveNewProfileName:
Gui,Submit,NoHide
;First Make Folder
FileCreateDir,%ServerFolder%
;Then make folder for profile
if(NewProfileName == "")
{
    MsgBox,,Profile name empty,Fill name or cancel new profile
    Return
}
FileCreateDir,% ServerFolder . "\" . NewProfileName
;Update dropdown
GuiControl,1:,DropDownList1,%NewProfileName%||
Gui,2:Destroy
Gui,1:Submit,NoHide
UpdateHomeScreen()
Return
UpdateProfilesDropbox()
{
    Gui,Submit,NoHide
    DropList = 
    loop, Files, % ServerFolder . "\*.*", D
    {
        SplitPath, A_LoopFileName,,,, FileName
        DropList .= FileName "|"
    }
    T_list := RTrim(DropList, "|")
    T_list := StrReplace(DropList, "|", "||",, 1) ; make first item default
    if(T_list != "")
    {
        GuiControl,1:,DropDownList1,|
    }
    GuiControl,1:,DropDownList1,%T_list%
}
;____________________________________________________________
;//////////////[Delete Profile]///////////////
DeleteProfile:
Gui,Submit,NoHide
MsgBox, 1,Are you sure?,All files will be deleted!, 15
IfMsgBox, Cancel
{
	return
}
else
{
    FileRemoveDir, %ServerFolder%\%DropDownList1%,1
    UpdateProfilesDropbox()
    UpdateHomeScreen()
}
return
UpdateBasedOnProfile:
UpdateHomeScreen()
return
;____________________________________________________________
;//////////////[Select new server jar]///////////////
SelectNewServerJarButton:
Gui,Submit,NoHide
FileSelectFile, SelectedFile, 1, , Open a file, java files (*.jar;)
if SelectedFile =
{
    MsgBox,, User didnt select file, No file selected
}
else
{
    FileCopy, %SelectedFile%,% ServerFolder . "\" . DropDownList1 . "\*.*"
    UpdateHomeScreen()
}
return
UpdateHomeScreen()
{
    Gui,1:Submit,NoHide
    SetSettings("Disable")
    SetAdvancedSettings("Disable")
    Guicontrol,1:Hide,StartServerFirstTime
    Guicontrol,1:Hide,StartServer
    loop, Files, % ServerFolder . "\" . DropDownList1 "\*.*", F
    {
        if A_LoopFileName Contains jar
        {
            T_ServerJarFile = %A_LoopFileName%
        }
        else if A_LoopFileName Contains EULA
        {
            Guicontrol,1:Enable,AcceptEULA
            T_EulaExist := true
        }
    }
    Gui,1:Submit,NoHide
    Guicontrol,1:Enable,SelectNewServerJar
    if(T_ServerJarFile == "")
    {
        ;No server file
        Guicontrol,1:,ServerJarFile,
        Guicontrol,1:Hide,StartServerFirstTime
        
    }
    else
    {
        Guicontrol,1:,ServerJarFile,%T_ServerJarFile%
        Guicontrol,1:Show,StartServerFirstTime
        
    }
    if(T_EulaExist)
    {
        Loop, Read, %ServerFolder%\%DropDownList1%\eula.txt
        {
            if A_LoopReadLine Contains eula=true
            {
                Guicontrol,1:Disable,AcceptEULA
                SetSettings("Enable")
                SetAdvancedSettings("Enable")
                Guicontrol,1:Hide,StartServerFirstTime
                Guicontrol,1:Show,StartServer
                Break
            }
        }
    }   
}
;____________________________________________________________
;//////////////[Set states]///////////////
SetSettings(state)
{
    Guicontrol,1:%state%,DifficultyBox
    Guicontrol,1:%state%,GameModeBox
    Guicontrol,1:%state%,ViewDistanceBox
    Guicontrol,1:%state%,MOTDEdit
    Guicontrol,1:%state%,MaxUsersEdit
    Guicontrol,1:%state%,SaveSettings
}
SetAdvancedSettings(state)
{
    Guicontrol,1:%state%,PortEdit
    Guicontrol,1:%state%,AllowCommandBlocksCheck
    Guicontrol,1:%state%,WorldSeedEdit
    Guicontrol,1:%state%,MemortLimitEdit
    ;Guicontrol,1:%state%,SetMemortLimitToBox
    ;Guicontrol,1:%state%,SetMemortLimitTo
    Guicontrol,1:%state%,SaveAdvancedSettings
}
;____________________________________________________________
;//////////////[start server]///////////////
StartServer:
Gui,1:Submit,NoHide
IfExist, %ServerFolder%\%DropDownList1%\StartServer.bat
    FileDelete, %ServerFolder%\%DropDownList1%\StartServer.bat
FileAppend,% "java -Xms" . MemortLimitEdit . "M -Xmx" . MemortLimitEdit . "M -jar " . ServerJarFile . " nogui",%ServerFolder%\%DropDownList1%\StartServer.bat
RunWait, %ServerFolder%\%DropDownList1%\StartServer.bat,%ServerFolder%\%DropDownList1%,Show
return
;____________________________________________________________
;//////////////[Accept EULA]///////////////
AcceptEULAButton:
Gui,1:Submit,NoHide
Loop, Read, %ServerFolder%\%DropDownList1%\eula.txt, %ServerFolder%\%DropDownList1%\eula.tmp
{
	line := % a_LoopReadLine . "`n"
	if ( InStr( line, "eula=false" ) )
		StringReplace, line, line,eula=false,eula=true
		
	FileAppend, %line%
}
FileMove, %ServerFolder%\%DropDownList1%\eula.tmp, %ServerFolder%\%DropDownList1%\eula.txt, 1
UpdateHomeScreen()
return
;____________________________________________________________
;//////////////[First Time start]///////////////
StartServerFirstTime:
if(MemortLimitEdit == "")
{
    MsgBox,,Cant be empty,Memory Limit Cant be empty
    return
}
IfExist, %ServerFolder%\%DropDownList1%\StartServer.bat
    FileDelete, %ServerFolder%\%DropDownList1%\StartServer.bat
FileAppend,% "java -Xms1G -Xmx1G -jar " . ServerJarFile . " nogui",%ServerFolder%\%DropDownList1%\StartServer.bat
RunWait, %ServerFolder%\%DropDownList1%\StartServer.bat,%ServerFolder%\%DropDownList1%,Show
return
;____________________________________________________________
;//////////////[save settings]///////////////
SaveSettings:
Gui,1:Submit,NoHide
if(MOTDEdit == "")
{
    MsgBox,,Cant be empty,MOTD Cant be empty
    return
}
if(MaxUsersEdit == "")
{
    MsgBox,,Cant be empty,Max Users Cant be empty
    return
}
if(ViewDistanceBox == "")
{
    MsgBox,,Cant be empty,View Distance Cant be empty
    return
}
Loop, Read, %ServerFolder%\%DropDownList1%\server.properties, %ServerFolder%\%DropDownList1%\server.tmp
{
	line := % a_LoopReadLine . "`n"
	if ( InStr( line, "difficulty=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "difficulty=" . DifficultyBox
    }
    else if ( InStr( line, "gamemode=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "gamemode=" . GameModeBox
    }
    else if ( InStr( line, "view-distance=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "view-distance=" . ViewDistanceBox
    }
    else if ( InStr( line, "motd=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "motd=" . MOTDEdit
    }
    else if ( InStr( line, "max-players=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "max-players=" . MaxUsersEdit
    }
    
	FileAppend, %line%
}
FileMove, %ServerFolder%\%DropDownList1%\server.tmp, %ServerFolder%\%DropDownList1%\server.properties, 1
return
;____________________________________________________________
;//////////////[save Advanced settings]///////////////
SaveAdvancedSettings:
Gui,1:Submit,NoHide
if(PortEdit == "")
{
    MsgBox,,Cant be empty,Port Cant be empty
    return
}
Loop, Read, %ServerFolder%\%DropDownList1%\server.properties, %ServerFolder%\%DropDownList1%\server.tmp
{
	line := % a_LoopReadLine . "`n"
	if ( InStr( line, "server-port=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "server-port=" . PortEdit
    }
    else if ( InStr( line, "enable-command-block=" ) )
    {
        if(AllowCommandBlocksCheck == 1)
        {
            StringReplace, line, line,%a_LoopReadLine%,% "enable-command-block=true"
        }
        else
        {
            StringReplace, line, line,%a_LoopReadLine%,% "enable-command-block=false"
        }
    }
    else if ( InStr( line, "level-seed=" ) )
    {
        StringReplace, line, line,%a_LoopReadLine%,% "level-seed=" . WorldSeedEdit
    }
    
	FileAppend, %line%
}
FileMove, %ServerFolder%\%DropDownList1%\server.tmp, %ServerFolder%\%DropDownList1%\server.properties, 1
return
;____________________________________________________________
;//////////////[checkForupdates]///////////////
checkForupdates:
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/veskeli/SimpleMinecraftServerManager/main/version.txt", False)
whr.Send()
whr.WaitForResponse()
newversion := whr.ResponseText
if(newversion != "" and newversion != "404: Not Found" and newversion != "500: Internal Server Error")
{
    if(newversion > version)
    {
        MsgBox, 1,Update,New version is  %newversion% `nOld is %version% `nUpdate now?
        IfMsgBox, Cancel
        {
            ;temp stuff
        }
        else
        {
            ;Download update
            SplashTextOn, 250,50,Downloading...,Downloading new version.`nVersion: %newversion%
            FileCreateDir, %AppFolder%
            FileCreateDir, %AppFolder%\temp
            FileMove, %A_ScriptFullPath%, %AppUpdateFile%, 1
            sleep 1000
            UrlDownloadToFile, https://raw.githubusercontent.com/veskeli/SimpleMinecraftServerManager/main/SimpleMinecraftServerManager.ahk, %A_ScriptFullPath%
            Sleep 1000
            SplashTextOff
            loop
            {
                IfExist %A_ScriptFullPath%
                {
                    Run, %A_ScriptFullPath%
                    ExitApp
                }
            }
			ExitApp
        }
    }
}
return