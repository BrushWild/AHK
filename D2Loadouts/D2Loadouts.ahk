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
            return false
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
        return true
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

$Numpad0::
if (!swapper.SwapLoadout(1))
    Send {Numpad0}
return

$Numpad1::
if (!swapper.SwapLoadout(2))
    Send {Numpad1}
return

$Numpad2::
if (!swapper.SwapLoadout(3))
    Send {Numpad2}
return

$Numpad3::
if (!swapper.SwapLoadout(4))
    Send {Numpad3}
return

$Numpad4::
if (!swapper.SwapLoadout(5))
    Send {Numpad4}
return

$Numpad5::
if (!swapper.SwapLoadout(6))
    Send {Numpad5}
return

$Numpad6::
if (!swapper.SwapLoadout(7))
    Send {Numpad6}
return

$Numpad7::
if (!swapper.SwapLoadout(8))
    Send {Numpad7}
return

$Numpad8::
if (!swapper.SwapLoadout(9))
    Send {Numpad8}
return

$Numpad9::
if (!swapper.SwapLoadout(10))
    Send {Numpad9}
return