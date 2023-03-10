#SingleInstance
#Persistent
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Thread, interrupt, 0  ; Make all threads always-interruptible.

/*
--- Class declaration
*/
class GoodBoy 
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.toggle := false
        this.timer := ObjBindMethod(this, "HecknGoodBoy")    ; bind the function HecknGoodBoy to a timer
    }
    
    /*
    ---- Member Function ----
    */
    HecknGoodBoy()
    {
        ; Pet dat dogo gud
        Send {e down}
        Sleep, 1000
        Send {e up}
        Sleep, 1000
        Send {e down}
        Sleep, 1000
        Send {e up}
        Sleep, 1000
        Send {e down}
        Sleep, 1000
        Send {e up}
        Sleep, 1000
        Send {s down}
        Sleep, 100
        Send {s up}
    }

    WhosAGoodBoy()
    {
        timer := this.timer

        if (this.toggle)
        {
            SetTimer, % timer, 1
        }
        else
        {
            SetTimer, % timer, Off
        }
    }
}

dogo := new GoodBoy

return

/* 
---- Hotkeys ----
*/

^n:: ; ctrl + n
    dogo.toggle := !dogo.toggle
    dogo.WhosAGoodBoy()
return

^Numpad6:: ; ctrl + num 6
ExitApp