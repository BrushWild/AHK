# README for CycleAudio.ahk
This script cycles between defined audio sources via the tray menu (right click) or hotkeys. I've also added some audio/visual feedback when you change outputs by including two icons and a quack sound to give context when you change your output.

* Alt+X: Cycles between audio output devices.
* Alt+M: Turns on/off sounds when cycling.
* Alt+D: Opens a message box with the name of the current output device.

**NOTE**: If you want super special icons there will be necessary tweaks on your end to make it work.

Here are some steps to get it working for you:
1. Open the windows Sounds setitings menu (Control Panel > Hardware and Sound > Sounds)
2. Open CycleAudio.ahk in a text editor of your choice 
3. Find "TODO: Add icons" (line 33)
4. For each active audio device from the Sounds window (starting top to bottom), add a new "this.endpointIconArray.Push(...)" replacing "..." with the icon file name to CycleAudio.ahk
5. Compile your script and run
6. Profit!!!

*Bonus*: If you want the script to start with windows, place a shortcut to your compiled exe at 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
