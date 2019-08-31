plan := 0

#p:: ;set's hotkey to Win + p, change this line for your hotkey
if (plan = 0) {
	Run, powercfg /s 381b4222-f694-41f0-9685-ff5bb260df2e,,Hide ;switch to balanced - GUID needs replaced
	ToolTip, Power plan: Balanced ;notification
	SetTimer, KillTooltip, 1000 ;remove notification in 2000 ms (i.e. 2 s)
	plan := 1 ;switch to high performance next time
} else if (plan = 1) {
	Run, powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c,,Hide ;switch to high performance - GUID needs replaced
	ToolTip, Power plan: High Performance ;notification
	SetTimer, KillTooltip, 1000 ;remove notification in 2000 ms (i.e. 2 s)
	plan := 2 ;switch to power save next time
} else if (plan = 2) {
	Run, powercfg /s a1841308-3541-4fab-bc81-f71556f20b4a,,Hide ;switch to power save - GUID needs replaced
	ToolTip, Power plan: Power Save ;notification
	SetTimer, KillTooltip, 1000 ;remove notification in 2000 ms (i.e. 2 s)
	plan := 0 ;switch to balanced next time
}
return

KillTooltip:
SetTimer, KillTooltip, off ;disable timer after one run
ToolTip ;no parameters hides existing tooltip
return