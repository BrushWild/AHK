#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; forces one instance
#include VA.ahk
Toggle = 1;
Return

rainmeter := "C:\Users\sr117\Downloads\Rainmeter-4.0"

#z:: ; Win+Z
{
    Toggle := !Toggle
    if (Toggle)
    {
        Menu, Tray, Icon, SpectrumGreenIco.ico,,1 
	Run, C:\Users\sr117\Downloads\Rainmeter-4.0\Rainmeter.exe !ShowFade "Fountain of Colors\Clone"
    }
    else
    {
	Menu, Tray, Icon, SpectrumBlackIco.ico,,1 
	Run, C:\Users\sr117\Downloads\Rainmeter-4.0\Rainmeter.exe !HideFade "Fountain of Colors\Clone"
    } 
    return
}

