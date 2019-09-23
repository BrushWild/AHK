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

        ; create variables
        this.endpointMax := this.CountActiveAudioOutputs()
        if (this.endpointMax <= 0)
        {
            this.UserSetEndpointMax()
        }
        this.playSounds := True

        ; create arrays
        this.endpointNameArray := []
        this.endpointIconArray := []

        ; put stuff in the arrays
        this.LoadEndpointNames()

        ; TODO: Add icons - until I can figure out a way to programatically assign icons to outputs, these need to be done manually
        ;this.endpointIconArray.Push("head-0.ico")
        ;this.endpointIconArray.Push("speak-0.ico")

        ; other initialize stuff
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
        if (this.playSounds) 
            this.PlaySound()
    }

    /*
    ---- Changes the icon based on the device name ----
    */
    ChangeIcon()
    {
        iconLocation := this.endpointIconArray[this.endpointIndex]
        if (iconLocation && this.endpointMax > 0)
        {
            Menu, Tray, Icon, %A_ScriptDir%\icons\%iconLocation%,,1
        }
        else
        {
            ; Default if we can't find an icon
            Menu, Tray, Icon, %A_ScriptDir%\icons\SpectrumGreenIco.ico,,1
        }
    }

    /*
    ---- Chooses which endpoint based on the index and sets the endpoint using the defined strings ----
    */
    SetEndpoint()
    {
        endpointName := this.endpointNameArray[this.endpointIndex]
        if (endpointName)
        {
            VA_SetDefaultEndpoint(endpointName, 0)
        }
    }

    /*
    ---- Get the current endpoint index ----
    */
    GetEndpointIndex()
    {
        retIndex := 1
        deviceName := VA_GetDeviceName(VA_GetDevice())
        for index, element in this.endpointNameArray
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
        SoundPlay, %A_ScriptDir%\sounds\quack.wav, Wait
    }

    /*
    ---- Toggles member bool and changes the checkbox of the tray menu ----
    */
    TogglePlaySoundsOnChange()
    {
        this.playSounds := !this.playSounds
        Menu, Tray, ToggleCheck, Play sounds
    }

    /*
    ---- Grab output names ----
    */
    LoadEndpointNames()
    {
        index := 1
        while index <= this.endpointMax
        {
            device := VA_GetDevice("playback:" index)
            if (device == 0)
            {
                return
            }
            this.endpointNameArray.Push(VA_GetDeviceName(device))
            index := index + 1
        }
    }

    /*
    ---- Counts active audio output devices ----
    */
    CountActiveAudioOutputs()
    {
        count := 0
        index := 1
        max := 99
        while index <= max
        {
            device := VA_GetDevice("playback:" index)
            if (device == 0)
            {
                return count ; exit early
            }
            this.endpointNameArray.Push(VA_GetDeviceName(device))
            index := index + 1
            count := count + 1
        }
        return count ; covering all code paths
    }

    /*
    ---- Define number of inputs to look for ----
    */
    UserSetEndpointMax()
    {
        newMax := 0
        InputBox, newMax, CycleAudio.ahk, Please define the number of audio outputs.,,,
        this.endpointMax := newMax
        this.endpointNameArray := []
        this.LoadEndpointNames()
    }
}

; Create cycle audio class instance
cycleAudio := new CycleAudio

; Right click menu options
Menu, Tray, Add ; this adds a separating line
Menu, Tray, Add, Set number of outputs, MenuUserSetEndpointMax
Menu, Tray, Add, Play sounds, MenuTogglePlaySounds
if (cycleAudio.playSounds)
    Menu, Tray, Check, Play sounds
Menu, Tray, Add ; this adds a separating line
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

MenuUserSetEndpointMax:
    cycleAudio.UserSetEndpointMax()
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