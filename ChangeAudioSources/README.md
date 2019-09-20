# README for CycleAudio.ahk
This script cycles between defined audio sources via the tray menu (right click) or hotkeys. I've also tried to add some audio/visual feedback when you change outputs. I've included two icons and a quack sound to give context when you change your output.

* Alt+X: Cycles between audio output devices.
* Alt+M: Turns on/off sounds when cycling.
* Alt+D: Opens a message box with the name of the current output device.

**NOTE**: This will not work immediately. There will probably be necessary tweaks on your end to make it work.

Here are some steps to get it working for you:
1. Open CycleAudio.ahk in a text editor of your choice
2. Open the Windows 'Sounds' menu (ControlPanel>HardwareAndSound>Sounds) ![Sounds](https://user-images.githubusercontent.com/15281119/65313056-94aced80-db48-11e9-9fae-8b3112c6479b.png)
3. Copy the name of a desired audio output with the following example format "Acer X34 (NVIDIA High Definition Audio)" (see image for reference)
4. From CycleAudio.ahk, find 'this.endpointString1' and paste your string
5. Repeat steps 2-4 for as many outputs as you want to cycle through and add a new 'this.endpointStringX' (where "X" is incremented) as well as add the appropriate control logic to the following functions:
   1. ChangeIcon()
   2. SetEndpoint()
   3. GetEndpointIndex()
6. Change 'this.endpointMax' to the number of outputs you want to cycle through
7. Profit!!! 
