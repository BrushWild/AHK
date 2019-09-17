#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

/*
---- Class declarations ----
*/
class CycleAudio
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        ; The headphone enpoint strings and max var will probably need to be adjusted for your personal machine
        this.endpointString1 := "Speakers (Realtek High Definition Audio)"
        this.endpointString2 := "Acer X34 (NVIDIA High Definition Audio)"
        this.endpointString3 := ""
        this.endpointMax := 2
        this.endpointIndex := this.GetEndpointIndex()
        this.SetEndpoint()
        this.ChangeIcon()
    }
    /*
    ---- Cycles the endpoints and is the main function to call ----
    */
    CycleEndpoint()
    {
        this.endpointIndex := this.endpointIndex + 1
        if (this.endpointIndex > this.endpointMax)
        {
            this.endpointIndex := 1
        }
        this.SetEndpoint()
        this.ChangeIcon()
    }
    ChangeIcon()
    {
        ; These expect the icon to exist in the source folder
        cachedIndex := this.GetEndpointIndex()
        if (cachedIndex == 1)
        {
            Menu, Tray, Icon, head-0.ico,,1
        }
        else if (cachedIndex == 2)
        {
            Menu, Tray, Icon, speak-0.ico,,1
        }
        else if (cachedIndex == 3)
        {
            Menu, Tray, Icon, head-0.ico,,1
        }
    }
    SetEndpoint()
    {
        VA_SetDefaultEndpoint("playback:" this.endpointIndex, 0)

        if (! VA_GetDevice("playback:" this.endpointIndex))
        {
            ToolTip % "Could not find output device for this index=" this.endpointIndex
            SetTimer, KillToolTip, 3000
        }
    }
    GetEndpointIndex()
    {
        retIndex := 0 
        deviceName := VA_GetDeviceName(VA_GetDevice())
        if ("" . deviceName = this.endpointString1)
        {
            retIndex := 1
        }
        else if ("" . deviceName = this.endpointString2)
        {
            retIndex := 2
        }
        else if ("" . deviceName = this.endpointString3)
        {
            retIndex := 3
        }

        ; Debug for device name
        ;MsgBox, 0, Debug, %deviceName%

        return retIndex
    }
}

; Script Initialize for CycleAudio
cycleAudio := new CycleAudio

; Right click menu options
Menu, Tray, Add
Menu, Tray, Add, Cycle Audio Source, MenuCycleEndpoint

; End script initialize
return

; Menu functions
MenuCycleEndpoint:
    cycleAudio.CycleEndpoint()
Return

; Hotkeys
!x::
    cycleAudio.CycleEndpoint()
Return

/* 
---- Helpers ----
*/
KillToolTip:
    SetTimer, KillToolTip, Off
    ToolTip
Return