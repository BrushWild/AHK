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

        ; create arrays
        this.endpointStringArray := []
        this.endpointIconArray := []

        ; put stuff in the arrays
        this.endpointStringArray.Push("Speakers (Realtek High Definition Audio)")
        this.endpointStringArray.Push("Acer X34 (NVIDIA High Definition Audio)")
        this.endpointIconArray.Push("head-0.ico")
        this.endpointIconArray.Push("speak-0.ico")

        ; other initialize stuff
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
        index := this.GetEndpointIndex()
        iconLocation := this.endpointIconArray[this.endpointIndex]
        Menu, Tray, Icon, %A_ScriptDir%\%iconLocation%,,1
    }

    /*
    ---- Chooses which endpoint based on the index and sets the endpoint using the defined strings ----
    */
    SetEndpoint()
    {
        VA_SetDefaultEndpoint(this.endpointStringArray[this.endpointIndex], 0)
    }

    /*
    ---- Get the current endpoing index ----
    */
    GetEndpointIndex()
    {
        retIndex := 1
        deviceName := VA_GetDeviceName(VA_GetDevice())
        for index, element in this.endpointStringArray
        {
            if ("" . deviceName = element)
            {
                retIndex := index
            }
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