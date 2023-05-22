#SingleInstance, Force
SendMode, Input
SetWorkingDir, %A_ScriptDir%

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
        this.toggle := this.skateState < 3 ? true : false
        this.states := Array("HunterHeavySkate", "HunterLightSkate", "WarlockHeavySkate", "WarlockLightSkate")
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

    SwitchClassSkate()
    {
        this.toggle := !this.toggle
        this.SwitchSkateStates()
    }

    SwitchSkateStates()
    {
        if (this.toggle)
        {
            if (this.skateState == 1)
            {
                this.skateState := 2
            }
            Else
            {
                this.skateState := 1
            }
        }
        Else
        {
            if (this.skateState == 3)
            {
                this.skateState := 4
            }
            Else
            {
                this.skateState := 3
            }
        }

        this.StatePrint()
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
        }
    }

    StatePrint()
    {
        if (this.CheckD2())
        {
            state := this.skateState
            stateString := this.states[state]
            Sleep, 50
            Send {Enter}
            Sleep, 100
            Send %stateString%
            Sleep, 1000
            Send {Escape}
        }
    }

    CheckD2()
    {
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
    if (!skate.SwitchClassSkate())
        Send {NumpadAdd}
return

; Swap between heavy/light skating
$NumpadEnter::
    if (!skate.SwitchSkateStates())
        Send {NumpadEnter}
return

; Press for zoomies! 
$F4::
    if (!skate.SendSkateOutput())
        Send {F4}
return

^Numpad6:: ; ctrl + num 6
ExitApp