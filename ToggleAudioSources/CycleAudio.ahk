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
        this.soundOnChange := True
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
        if (this.soundOnChange) 
            this.PlaySound()
    }
    ChangeIcon()
    {
        ; These expect the icon to exist in the source folder
        deviceName := VA_GetDeviceName(VA_GetDevice())
        if ("" . deviceName = this.endpointString1)
        {
            Menu, Tray, Icon, head-0.ico,,1
        }
        else if ("" . deviceName = this.endpointString2)
        {
            Menu, Tray, Icon, speak-0.ico,,1
        }
        else if ("" . deviceName = this.endpointString3)
        {
            Menu, Tray, Icon, speak-0.ico,,1
        }
    }
    SetEndpoint()
    {
        if (this.endpointIndex == 1)
        {
            VA_SetDefaultEndpoint(this.endpointString1, 0)
        }
        else if (this.endpointIndex == 2)
        {
            VA_SetDefaultEndpoint(this.endpointString2, 0)
        }
        else if (this.endpointIndex == 3)
        {
            VA_SetDefaultEndpoint(this.endpointString3, 0)
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
        return retIndex
    }
    EndpointNameMsgBox()
    {
        ; Debug for device name
        deviceName := VA_GetDeviceName(VA_GetDevice())
        MsgBox, 0, Debug, %deviceName%
    }
    PlaySound()
    {
        SoundPlay, %A_ScriptDir%\quack.wav, Wait
    }
    TogglePlaySoundsOnChange()
    {
        this.soundOnChange := !this.soundOnChange
        Menu, Tray, ToggleCheck, Play sounds
    }
}

; Script Initialize for CycleAudio
cycleAudio := new CycleAudio

; Right click menu options
Menu, Tray, Add ; this adds a separating line
Menu, Tray, Add, Play sounds, MenuTogglePlaySounds
Menu, Tray, Check, Play sounds
;Menu, Tray, Add, Get Source Name, MenuEndpointNameMsgBox
Menu, Tray, Add, Cycle audio source, MenuCycleEndpoint

; End script initialize
return

; Menu functions
MenuCycleEndpoint:
    cycleAudio.CycleEndpoint()
Return

MenuEndpointNameMsgBox:
    cycleAudio.EndpointNameMsgBox()
Return

MenuTogglePlaySounds:
    cycleAudio.TogglePlaySoundsOnChange()
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