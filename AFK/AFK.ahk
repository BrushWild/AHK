#SingleInstance
#Persistent

/*
         _--"-.
      .-"      "-.
     |""--..      '-.
     |      ""--..   '-.
     |.-. .-".    ""--..".
     |'./  -_'  .-.      |
     |      .-. '.-'   .-'
     '--..  '.'    .-  -.
          ""--..   '_'   :
                ""--..   |
                      ""-'
*/

if FileExist("cheeseIcon.ico")
{
    Menu, Tray, Icon, cheeseIcon.ico,,1
}

/*
--- Class declaration
*/
class xpCheese 
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.toggle := false                            ; create the toggle
        this.state := 1
        this.stateNames := Array("Trinity", "Sunbreaker")
        timer := ObjBindMethod(this, "StankyCheese")    ; bind the function StankyCheese to the timer
        SetTimer, % timer, 0                            ; start the timer
    }
    
    /*
    ---- Member Function ----
    */
    StankyCheese()
    {
                                                        ; heck'n stringy, ooey-gooey, and pungent cheese
        if (this.toggle)
        {
            if (!this.CheckD2())
            {
                this.StartStop()
                return
            }

            state := this.state
            Switch state
            {
                case 1:
                {
                    this.Trinity()
                }
                case 2:
                {
                    this.Sunbreaker()
                }
            }
        }
    }

    SwitchState()
    {
        if (this.CheckD2())
        {
            this.state += 1
            if (this.state > 2)
            {
                this.state := 1
            }
            this.StatePrint()
            return true
        }
        return false
    }

    StartStop()
    {
        this.toggle := !this.toggle
    }

    Sunbreaker()
    {
        Send, /                                     ; this is the "grenade" key. Change this if needed
        Sleep, 1200
        Send, a
        Sleep, 400
        Send, d
        Sleep, 2800
    }

    Trinity()
    {
        Click, Down
        Sleep, 600
        Click, Up
        Sleep, 500
        Send {LControl Down}
        Sleep, 500
        Send {LControl Up}
        Sleep, 2800
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

    StatePrint()
    {
        if (this.CheckD2())
        {
            state := this.state
            stateString := this.stateNames[state]
            Sleep, 50
            Send {Enter}
            Sleep, 100
            Send %stateString%
            Sleep, 1000
            Send {Escape}
        }
    }
}

afk := new xpCheese

return

/* 
---- Hotkeys ----
*/

$F11::
    if (!afk.SwitchState())
        Send {F11}
return

$F10::
    if (afk.CheckD2())
        afk.StartStop()
    Else
        Send {F10}
return

$F6::
ExitApp
