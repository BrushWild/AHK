# README for CycleAudio.ahk
This script cycles between defined audio sources via the tray menu (right click) or hotkeys. I've also tried to add some audio/visual feedback when you change outputs. I've included two icons and a quack sound to give context when you change your output.

* Alt+X: Cycles between audio output devices.
* Alt+M: Turns on/off sounds when cycling.
* Alt+D: Opens a message box with the name of the current output device.

**NOTE**: This will not work immediately. There will probably be necessary tweaks on your end to make it work.

Here are some steps to get it working for you:
1. Open CycleAudio.ahk in a text editor of your choice
2. Open the Windows 'Sound' menu (ControlPanel>HardwareAndSound>Sounds) ![Sounds](https://user-images.githubusercontent.com/15281119/65322084-aeefc700-db5a-11e9-9e74-3dc81f0c2d4b.png)
3. Copy the name of a desired audio output with the following example format "Acer X34 (NVIDIA High Definition Audio)" (see image for reference)
4. From CycleAudio.ahk, add "this.endpointNameArray.Push(...)" (under the 'New()' function) replacing the "..." with your new audio output string from step 3
5. For new icons, do the same as step 4, but add "this.endpointIconArray.Push(...)" replacing "..." with the icon file name
6. Repeat steps 3-5 for as many outputs/icons as you want to cycle through
7. Change 'this.endpointMax' to the number of outputs you want to cycle through
8. Compile your script and run
9. Profit!!! 

*Bonus*: If you want the script to start with windows, place a shortcut to your compiled exe at 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
