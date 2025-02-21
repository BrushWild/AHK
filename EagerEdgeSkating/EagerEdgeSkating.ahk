#SingleInstance, Force
SendMode, Input
SetWorkingDir, %A_ScriptDir%

/*
--- Create the Gui, DO NOT TOUCH THIS SECTION
*/
CustomColor := "EEAA99"  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s32  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cLime, XXXXX YYYYY  ; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 150


/*
--- Class declaration
*/
class EES 
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.skateState := 1
        this.shortNames := Array("H Heavy", "H Light", "W Heavy", "W Light")

        this.autoHide := true

        ; Create a timer to auto hide the Gui
        this.timer := ObjBindMethod(this, "HideGui")
        this.UpdateOSD()
    }
    
    /*
    ---- Member Functions ----
    */
    HunterHeavySkate()
    {
        Click, Down Right
        Sleep, 5
        Click, Up Right
        Sleep, 45
        Send {Space down}
        Send {x down}
        Sleep, 35
        Send {Space up}
        Send {x up}
    }

    HunterLightSkate()
    {
        Sleep, 10
        Send {Space down}
        Sleep, 10
        Send {Space up}
        Sleep, 10
        Click, Down Left
        Sleep, 10
        Click, Up Left
        Sleep, 25
        Send {Space down}
        Sleep, 25
        Send {Space up}
        Sleep, 25
        Send {x down}
        Sleep, 25
        Send {x up}
    }

    WarlockHeavyWellSkate()
    {
        Click, Down Right
        Sleep, 5
        Click, Up Right
        Sleep, 45
        Send {Space down}
        Send {f down}
        Sleep, 35
        Send {Space up}
        Send {f up}
    }

    WarlockLightWellSkate()
    {
        Send {Space down}
        Sleep, 10
        Send {Space up}
        Sleep, 10
        Click, Down Left
        Sleep, 10
        Click, Up Left
        Sleep, 25
        Send {Space down}
        Sleep, 25
        Send {Space up}
        Sleep, 25
        Send {f down}
        Sleep, 25
        Send {f up}
    }

    SwitchSkateStates()
    {
        if (this.CheckD2())
        {
            this.skateState += 1
            if (this.skateState > 4)
            {
                this.skateState := 1
            }

            ;this.StatePrint() ; DEPRICATED IN FAVOR OF GUI

            this.ShowGui()
            this.UpdateOSD()
        }
    }

    SendSkateOutput()
    {
        if (this.CheckD2())
        {
            state := this.skateState
            Switch state 
            {
                Case 1: this.HunterHeavySkate()
                    
                Case 2: this.HunterLightSkate()
    
                Case 3: this.WarlockHeavyWellSkate()
    
                Case 4: this.WarlockLightWellSkate()
                    
                Default: Send {space}
            }

            ;this.ShowGui(250)
        }
    }

    /*
    --- DEPRICATED
    StatePrint()
    {
        if (this.CheckD2())
        {
            state := this.skateState
            stateString := this.shortNames[state]
            Sleep, 50
            Send {Enter}
            Sleep, 100
            Send %stateString%
            Sleep, 500
            Send {Escape}
        }
    }
    */

    CheckD2()
    {
        /*
        WinGetTitle, activeWindow, A
        title := "Destiny 2"
        IfInString, activeWindow, %title%
        {
            return true
        }
        Else
        {
            return false
        }
        */

        If (WinActive("ahk_exe destiny2.exe"))
        {
            return true
        }
        Else
        {
            return false
        }
    }

    ShowGui( guiDuration := 1000 )
    {
        Sysget, totalWidth, 16
        Sysget, totalHeight, 17
        offsetX := totalWidth * .8
        offsetY := totalHeight * .8

        Gui, Show, x%offsetX% y%offsetY% NoActivate  ; NoActivate avoids deactivating the currently active window.

        if (this.autoHide)
        {
            ; start the timer
            timer := this.timer
            duration := guiDuration
            SetTimer, % timer, % duration
        }
    }

    HideGui()
    {
        Gui, Hide

        ; delete the timer
        timer := this.timer
        SetTimer, % timer, off
    }

    UpdateOSD()
    {
        state := this.skateState
        osdText := this.shortNames[state]
        GuiControl,, MyText, %osdText%
    }

    ToggleAutoHideGui()
    {
        if (!this.CheckD2())
        {
            return false
        }

        this.autoHide := !this.autoHide

        if (!this.autoHide)
        {
            this.ShowGui()
        }
        Else
        {
            this.HideGui()
        }
    }

    HoldMiddleMouse()
    {
        if (this.CheckD2())
        {
            Send {MButton Down}
            Sleep 1250
            Send {MButton Up}
        }
    }
}

/*
---- Initialize the declared class ----
*/
skate := new EES

return

/* 
---- Hotkeys ----
*/

; Cycle classes to skate with
$NumpadAdd::
    if (!skate.SwitchSkateStates())
        Send {NumpadAdd}
return

$F5::
    if (!skate.ToggleAutoHideGui())
        Send {F5}
return

; Press for zoomies! 
$F4::
    if (!skate.SendSkateOutput())
        Send {F4}
return

$WheelUp::
    if (!skate.HoldMiddleMouse())
        Send {WheelUp}
return

^Numpad6:: ; ctrl + num 6
ExitApp