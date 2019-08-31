#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Toggle = 0
Return

#SPACE::
Toggle := !Toggle
Winset, Alwaysontop, , A
WinGetTitle, Title, A
if (Toggle) {
TrayTip, OnTop, %Title% is on top, 0.5, 0
}
else {
TrayTip, OnTop, %Title% is not on top, 0.5, 0
}
Return
;MsgBox, The active window is "%Title%".