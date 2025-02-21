#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

if FileExist("mic.ico")
{
    Menu, Tray, Icon, mic.ico,,1
}

/*
---- Class declaration ----
*/
class ForceMicVolume
{
    /*
    ---- Class constructor ----
    */
    __New()
    {
        this.endpointMax := 0
        this.defaultVolume := 22.5
        this.inputVolume := this.defaultVolume
        this.LoadSettingsIni()
        
        this.timer := ObjBindMethod(this, "SetMicVolume")
        timer := this.timer
        SetTimer % timer, 10000
        this.timer2electricboogaloo := ObjBindMethod(this, "SetDefaultMic")
        timer2 := this.timer2electricboogaloo
        SetTimer % timer2, 60000
        this.activeDeviceIndex := 0
    }

    SetMicVolume()
    {
        index := 1
        this.endpointMax := this.CountMicInputs()
        while index <= this.endpointMax
        {
            device := VA_GetDevice("capture:" index)
            if (device == 0)
            {
                return
            }
            deviceName := VA_GetDeviceName(device)
            rode := "RODE NT-USB"
            IfInString, deviceName, %rode%
            {
                desiredVolume := this.inputVolume + 0.0
                volumeStr := VA_GetVolume("1", "", "capture:" index)
                volume := volumeStr + 0.0
                if (volume != desiredVolume)
                {
                    VA_SetVolume( desiredVolume, "1", "", "capture:" index)
                }
                return
            }
            index := index + 1
        }
    }

    SetDefaultMic()
    {
        index := 1
        this.endpointMax := this.CountMicInputs()
        activeIndex := this.activeDeviceIndex
        while index <= this.endpointMax
        {
            device := VA_GetDevice("capture:" index)
            if (device == 0 || this.activeDeviceIndex == index)
            {
                return
            }
            deviceName := VA_GetDeviceName(device)
            broadcast := "Broadcast"
            IfInString, deviceName, %broadcast%
            {
                VA_SetDefaultEndpoint(deviceName, 0)
                VA_SetDefaultEndpoint(deviceName, 2)
                this.activeDeviceIndex := index
                return
            }
            index := index + 1
        }
    }

    CountMicInputs()
    {
        count := 0
        index := 1
        max := 99
        while index <= max
        {
            device := VA_GetDevice("capture:" index)
            if (device == 0)
            {
                return count ; exit early
            }
            index := index + 1
            count := count + 1
        }
        return count ; covering all code paths
    }

    SetVolume()
    {
        input := 0
        InputBox, input, ForceMicInput, New input volume (0 - 100), input, 200, 150
        if ( input = "" )
        {
            input := this.defaultVolume + 0.0
        }
        this.inputVolume := input
        if FileExist("mic_settings.ini") 
        {
            IniWrite, %input%, mic_settings.ini, Variables, Volume
        }
        this.SetMicVolume()
    }

    GetInputNames()
    {
        index := 1
        this.endpointMax := this.CountMicInputs()
        while index <= this.endpointMax
        {
            device := VA_GetDevice("capture:" index)
            if (device == 0)
            {
                return
            }
            deviceName := VA_GetDeviceName(device)
            ;MsgBox, , , %deviceName%
            
            desiredMic := "NVIDIA Broadcast"
            IfInString, deviceName, %desiredMic%
            {
                VA_SetDefaultEndpoint(device, 0)
                VA_SetDefaultEndpoint(device, 2)
                return
            }
            */
            index := index + 1
        }
    }

    LoadSettingsIni()
    {
        if !FileExist("mic_settings.ini") 
        {
            MsgBox, No mic_settings.ini found, please input your settings now.
            InputBox, vol, Volume, Input your ingame volume (default: 30):,, 230, 150
            ;InputBox, recoil, Recoil, Input your recoil (default: 2.95`,` higher = down):,, 230, 150
            ;InputBox, cycle_time, Speed / shot delay, Input shot delay in ms (default: 53`,` higher = slower):,, 230, 150
            IniWrite, %vol%, mic_settings.ini, Variables, Volume
            ;IniWrite, %recoil%, wall_settings.ini, Variables, Recoil
            ;IniWrite, %cycle_time%, wall_settings.ini, Variables, Cycle_Time

            this.inputVolume := vol
            ;this.recoil := recoil
            ;this.cycle_time := cycle_time
        } 
        else 
        {
            IniRead, vol, mic_settings.ini, Variables, Volume
            ;IniRead, recoil, mic_settings.ini, Variables, Recoil
            ;IniRead, cycle_time, mic_settings.ini, Variables, Cycle_Time

            this.inputVolume := vol
        }
    }
}

; Create cycle audio class instance
force := new ForceMicVolume

; Right click menu options
Menu, Tray, Add ; this adds a separating line
Menu, Tray, Add, Set input volume, MenuVolume

; End main script initialize
return

; Menu functions
MenuVolume:
    force.SetVolume()
Return

; Hotkeys
^m::
    force.SetDefaultMic()
return