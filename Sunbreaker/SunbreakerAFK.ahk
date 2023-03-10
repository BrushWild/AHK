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
class SunbreakerAFK 
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.toggle := false                            ; create the toggle
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
            Send, /                                     ; this is the "grenade" key. Change this if needed
            Sleep, 1200
            Send, a
            Sleep, 400
            Send, d
            Sleep, 2800
        }
    }
}

afk := new SunbreakerAFK

return

/* 
---- Hotkeys ----
*/

^NumpadEnter:: ; ctrl + num enter
    afk.toggle := !afk.toggle  
return

^Numpad0:: ; ctrl + num 0
    afk.toggle := !afk.toggle  
return

^Numpad6:: ; ctrl + num 6
ExitApp
