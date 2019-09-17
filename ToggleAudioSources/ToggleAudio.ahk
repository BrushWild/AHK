#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

; Class declaration
class ToggleAudio{
    __New()
    {
        ; The headphone enpoint string and endpoint vars will probably need to be adjusted for your personal machine
        this.headphoneEndpointString := "Speakers (Realtek High Definition Audio)"
        this.endpointVar1 := 1
        this.endpointVar2 := 2
        this.endpointToggle := False
        if (this.IsDeviceHeadphones())
        {
            this.endpointToggle := True
        }
        this.SetEndpoint()
        this.ChangeIcon()
    }
    ToggleEndpoint()
    {
        this.endpointToggle := !this.endpointToggle
        this.SetEndpoint()
        this.ChangeIcon()
    }
    ChangeIcon()
    {
        if (this.IsDeviceHeadphones())
        {
            Menu, Tray, Icon, head-0.ico,,1
        }
        else
        {
            Menu, Tray, Icon, speak-0.ico,,1 
        }
    }
    SetEndpoint()
    {
        VA_SetDefaultEndpoint("playback:" (this.endpointToggle ? this.endpointVar1 : this.endpointVar2), 0)        
    }
    IsDeviceHeadphones()
    {
        deviceName := VA_GetDeviceName(VA_GetDevice())
        if ("" . deviceName = this.headphoneEndpointString)
        {
            return True
        }
        else
        {
            return False
        }
    }
}

; Script Initialize
toggleAudio := new ToggleAudio

; Right click menu options
Menu, Tray, Add
Menu, Tray, Add, Toggle Audio Source, MenuToggleEndpoint

; End script initialize
return

; Menu functions
MenuToggleEndpoint:
    toggleAudio.ToggleEndpoint()
Return

; Hotkeys
!x::
    toggleAudio.ToggleEndpoint()
Return

; Helpers
KillToolTip:
    SetTimer, KillToolTip, Off
    ToolTip
Return