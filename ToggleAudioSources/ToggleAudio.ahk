#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)
#SingleInstance force ;forces a single instance of the script

;SETS THE TRAY ICON, ADDS AN OPTION TO RUN THE SCRIPT FROM THE TRAY
VA_SetDefaultEndpoint("playback:" 2, 0)
Toggle = 1;
Menu, Tray, Icon, head-0.ico,,1			;default is speaker icon
Menu, Tray, NoStandard				;?
;Menu, Tray, Add, &Switch Playback Device 	;add tray option
Menu, Tray, Add, 				;add blank line
Menu, Tray, Standard				;?
;Menu, Tray, Default, &Switch Playback Device	;default option is new option
Return

;TOGGLE HEADPHONES AND SPEAKERS (if those are the only 2 playback devices enabled)
!x::   ;alt+x toggles headphones / speakers
Toggle := !Toggle
;VA_SetDefaultEndpoint("playback:" (Toggle ? 2 : 1), 0)
if (Toggle) {
VA_SetDefaultEndpoint("playback:" 1, 0) 		;This line sets the audio playback device 1 = speaker, 2 = headphones. Your audio output device numbers will be different
Menu, Tray, Icon, speak-0.ico,,1 
;Menu, Tray, Icon, head-0.ico,,1				;This line sets the icon in the tray
;TrayTip, Speaker, Audio switched to speakers, 0.5, 0	;
}
else {
VA_SetDefaultEndpoint("playback:" 2, 0)
Menu, Tray, Icon, head-0.ico,,1
;Menu, Tray, Icon, speak-0.ico,,1
;TrayTip, Headphones, Audio switched to headphones, 0.5, 0
}
;Run, C:\Program Files\Rainmeter\Rainmeter.exe !RefreshApp
return