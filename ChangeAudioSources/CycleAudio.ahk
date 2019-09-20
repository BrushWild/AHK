#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

/*
---- Class declaration ----
*/
class CycleAudio
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        ; The headphone enpoint strings and max var will probably need to be adjusted for your personal machine
        ; -- Alt+D will create a message box with the string on the current playback device (endpoint)
        this.endpointString1 := "Speakers (Realtek High Definition Audio)"
        this.endpointString2 := "Acer X34 (NVIDIA High Definition Audio)"
        this.endpointString3 := ""
        this.endpointMax := 2
        this.endpointIndex := this.GetEndpointIndex()
        this.playSounds := True
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
        if (this.playSounds) 
            this.PlaySound()
    }

    /*
    ---- Changes the icon based on the device name ----
    */
    ChangeIcon()
    {
        ; These expect the icon to exist in the source folder of the script/exe
        deviceName := VA_GetDeviceName(VA_GetDevice())
        if ("" . deviceName = this.endpointString1)
        {
            Menu, Tray, Icon, %A_ScriptDir%\head-0.ico,,1
        }
        else if ("" . deviceName = this.endpointString2)
        {
            Menu, Tray, Icon, %A_ScriptDir%\speak-0.ico,,1
        }
        else if ("" . deviceName = this.endpointString3)
        {
            Menu, Tray, Icon, %A_ScriptDir%\speak-0.ico,,1
        }
    }

    /*
    ---- Chooses which endpoint based on the index and sets the endpoint using the defined strings ----
    */
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

    /*
    ---- Get the current endpoing index ----
    */
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

    /*
    ---- Creates a pop-up box with the current device name ----
    */
    EndpointNameMsgBox()
    {
        deviceName := VA_GetDeviceName(VA_GetDevice())
        MsgBox, 0, Debug, %deviceName%
    }

    /*
    ---- QUACK ----
    */
    PlaySound()
    {
        SoundPlay, %A_ScriptDir%\quack.wav, Wait
    }

    /*
    ---- Toggles member bool and changes the checkbox of the tray menu ----
    */
    TogglePlaySoundsOnChange()
    {
        this.playSounds := !this.playSounds
        Menu, Tray, ToggleCheck, Play sounds
    }
}

; Create cycle audio class instance
cycleAudio := new CycleAudio

; Right click menu options
Menu, Tray, Add ; this adds a separating line
Menu, Tray, Add, Play sounds, MenuTogglePlaySounds
if (cycleAudio.playSounds)
    Menu, Tray, Check, Play sounds
;Menu, Tray, Add, Get Source Name, MenuEndpointNameMsgBox
Menu, Tray, Add, Cycle audio source, MenuCycleEndpoint

; End main script initialize
return

/* 
---- Menu Functions ----
*/
MenuCycleEndpoint:
    cycleAudio.CycleEndpoint()
Return

MenuEndpointNameMsgBox:
    cycleAudio.EndpointNameMsgBox()
Return

MenuTogglePlaySounds:
    cycleAudio.TogglePlaySoundsOnChange()
Return

/* 
---- Hotkeys ----
*/
!x::
    cycleAudio.CycleEndpoint()
Return

!m::
    cycleAudio.TogglePlaySoundsOnChange()
Return

!d::
    cycleAudio.EndpointNameMsgBox()
Return

/* 
---- Helpers ----
*/
KillToolTip:
    SetTimer, KillToolTip, Off
    ToolTip
Return