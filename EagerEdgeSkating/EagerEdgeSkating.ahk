#NoEnv
#SingleInstance, Force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Thread, Interrupt, 0

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
        this.toggle := true
        this.skateState := 1
        this.states := Array("HunterHeavySkate", "HunterLightSkate", "WarlockHeavySkate", "WarlockLightSkate")
    }
    
    /*
    ---- Member Functions ----
    */
    HunterHeavySkate()
    {
        Click, Down Right
        Sleep, 53
        Send {Space down}
        Sleep, 42
        Click, Up Right
        Sleep, 37
        Send {x down}
        Sleep, 48
        Send {space up}
        Sleep, 63
        Send {x up}
    }

    HunterLightSkate()
    {
        Send {Space down}
        Sleep, 10
        Click, Down Left
        Sleep, 10
        Send {Space up}
        Sleep, 10
        Click, Up Left
        Sleep, 10
        Send {Space down}
        Send {x down}
        Sleep, 30
        Send {Space up}
        Send {x up}
    }

    WarlockHeavyWellSkate()
    {
        Click, Down Right
        Sleep, 53
        Send {Space down}
        Sleep, 42
        Click, Up Right
        Sleep, 37
        Send {f down}
        Sleep, 48
        Send {space up}
        Sleep, 63
        Send {f up}
    }

    WarlockLightWellSkate()
    {
        Send {Space down}
        Sleep, 10
        Click, Down Left
        Sleep, 10
        Send {Space up}
        Sleep, 10
        Click, Up Left
        Sleep, 10
        Send {Space down}
        Send {f down}
        Sleep, 30
        Send {Space up}
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
^NumpadAdd::
    skate.SwitchClassSkate()
return

; Swap between heavy/light skating
^NumpadEnter::
    skate.SwitchSkateStates()
return

; Press for zoomies! 
^F4::
    skate.SendSkateOutput()
return

^Numpad6:: ; ctrl + num 6
ExitApp