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
        this.inputVolume := 23.5
        this.defaultVolume := 23.5
        this.timer := ObjBindMethod(this, "SetMicVolume")
        timer := this.timer
        SetTimer % timer, 10000
        this.timer2electricboogaloo := ObjBindMethod(this, "SetDefaultMic")
        timer2 := this.timer2electricboogaloo
        SetTimer % timer2, 10000
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
                volumeStr := VA_GetVolume("1", "", "capture")
                volume := volumeStr + 0.0
                if ( volume < desiredVolume )
                {
                    VA_SetVolume( desiredVolume, "1", "", "capture" )
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
^d::
    force.SetDefaultMic()
return