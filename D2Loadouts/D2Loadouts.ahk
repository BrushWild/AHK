#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

if FileExist("tricorn.ico")
{
    Menu, Tray, Icon, tricorn.ico,,1
}

/*
---- Class declaration ----
*/
class D2Loadout
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.XposArray := [633, 760, 633, 760, 633, 760, 633, 760, 633, 760]
        this.YposArray := [514, 514, 641, 641, 768, 768, 899, 899, 1022, 1022]
    }

    SwapLoadout( index )
    {
        if (!this.CheckD2())
        {
            return
        }
        xPos := this.XposArray[index]
        yPos := this.YposArray[index]
        Send {i}
        Sleep, 700
        Send {Left}
        Sleep, 200
        MouseMove, xPos, yPos, 0
        Sleep, 100
        Send {Click}
        Sleep, 50
        Send {Escape}
        Sleep, 50
        Send {Escape}
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

; Create cycle audio class instance
swapper := new D2Loadout

; End main script initialize
return

; Hotkeys
!d::
MouseGetPos, xpos, ypos 
MsgBox, The cursor is at X%xpos% Y%ypos%.
return

Numpad0::
swapper.SwapLoadout(1)
return

Numpad1::
swapper.SwapLoadout(2)
return

Numpad2::
swapper.SwapLoadout(3)
return

Numpad3::
swapper.SwapLoadout(4)
return

Numpad4::
swapper.SwapLoadout(5)
return

Numpad5::
swapper.SwapLoadout(6)
return

Numpad6::
swapper.SwapLoadout(7)
return

Numpad7::
swapper.SwapLoadout(8)
return

Numpad8::
swapper.SwapLoadout(9)
return

Numpad9::
swapper.SwapLoadout(10)
return