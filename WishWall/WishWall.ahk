/*
---- DISCLAIMER! ----
This is not my original creation. Go throw some love to the creator at www.shurochi.com
I adapted this script to be (subjectively) more readable and add some customized functionality.
*/

#Persistent
#SingleInstance Force

/*
---- Class declaration ----
*/
class WishWall
{
	/*
    ---- Class constructor ----
    */
	__New()
	{
		; class variables
		this.wishNumber := 0
		this.pos_x := 0.0
		this.pos_y := 0.0
		this.cycle_time := 55.0
		this.res_scalar := 1.0
		this.sens_scalar := 0
		this.recoil := 0

		; set up variables
		this.LoadWallSensTxt()
		this.GetScreenHeight()
	}

	/*
    ---- Class functions ----
    */

	; Load the sensitivity from a file
	LoadWallSensTxt()
	{
		FileRead, sens, %A_ScriptDir%\wall_sens.txt
		if ErrorLevel 
		{
			this.change_sens()
		}
		this.sens_scalar := sens / 8.0
		this.recoil := 2.9999 / this.sens_scalar
	}

	; grab the screen heigh
	GetScreenHeight()
	{
		switch %A_ScreenHeight%
		{
			case 720:
			this.res_scalar := 1.5
	
			case 1080:
			this.res_scalar := 1.3
	
			case 1440:
			this.res_scalar := 1
	
			case 2160:
			this.res_scalar := 0.75
		}
	}

	; Grabs player input
	GetWishInput()
	{
		if (!this.CheckD2())
			return false

		WishNumber := 0
		InputBox, WishNumber, Wish wall menu, 1. Ethereal Key (once per account)`n2. Glittering Key chest spawn`n3. Numbers of Power emblem`n4. Shuro Chi encounter`n5. Morgeth encounter`n6. Vault encounter`n7. Riven encounter`n8. Hope for the Future song`n9. Failsafe dialogue`n10. Drifter dialogue`n11. Party effect on precision kills`n12. Random effect around players' heads`n13. Petra's Run`n14. Corrupted Eggs spawn`n15. Change sensitivity,,300,365
		this.wishNumber := WishNumber
		return true
	}

	; Execute the selected wish
	MakeAWish()
	{
		if (!this.CheckD2())
			return false

		switch this.wishNumber
		{
			case 1:
			this.key()	

			case 2:
			this.chest()

			case 3:
			this.emblem()

			case 4:
			this.shuro()

			case 5:
			this.morgeth()

			case 6:
			this.vault()

			case 7:
			this.riven()

			case 8:
			this.song()

			case 9:
			this.failsafe()

			case 10:
			this.drifter()

			case 11:
			this.party()

			case 12:
			this.halo()

			case 13:
			this.petra()

			case 14:
			this.eggs()

			case 15:
			this.change_sens()

			default:
			MsgBox, Invalid menu option
		}

		return true
	}

	; Verify the correct window
	CheckD2()
    {
        WinGetTitle, activeWindow, A
        title := "Destiny 2"
        IfInString, activeWindow, %title%
        {
            return true
        }
        Else
        {
            return false
        }
    }

	; The following are helper functions for all wishes
	shoot(Array, LoopCount)
	{
		Loop %LoopCount%
		{
			i := 1
			Loop 10
			{
				switch Array[i]
				{
					case 0:
					column := column
					row := row
				
					case 1:
					column := -410
					row := -255
				
					case 2:
					column := -215
					row := -280
				
					case 3:
					column := 0
					row := -285
				
					case 4:
					column := 215
					row := -280
				
					case 5:
					column := 410
					row := -255
				
					case 6:
					column := -410
					row := -80
				
					case 7:
					column := -215
					row := -100
				
					case 8:
					column := 0
					row := -100
				
					case 9:
					column := 215
					row := -100
				
					case 10:
					column := 410
					row := -80
				
					case 11:
					column := -410
					row := 110
				
					case 12:
					column := -210
					row := 100
				
					case 13:
					column := 0
					row := 100
				
					case 14:
					column := 210
					row := 100
				
					case 15:
					column := 410
					row := 110
				
					case 16:
					column := -410
					row := 310
				
					case 17:
					column := -210
					row := 310
				
					case 18:
					column := 0
					row := 310
				
					case 19:
					column := 210
					row := 310
				
					case 20:
					column := 410
					row := 310
				}

				if (Array[i] == 0) {
					DllCall("mouse_event", "UInt", 0x01, "UInt", 0, "UInt", 0 - this.recoil / 4)
					Sleep, 85			
				} else if (Array[i] == "") {
				} else {
					DllCall("mouse_event", "UInt", 0x01, "UInt", column * this.res_scalar / this.sens_scalar - this.pos_x, "UInt", row * this.res_scalar / this.sens_scalar - this.pos_y + this.recoil)
					Sleep, this.cycle_time
					Click
				}
			
				this.pos_x := column * this.res_scalar / this.sens_scalar
				this.pos_y := row * this.res_scalar / this.sens_scalar
				i++
			}
		}
	}

	done()
	{
		Send, r
		DllCall("mouse_event", "UInt", 0x01, "UInt", 0 - this.pos_x, "UInt", 0 - this.pos_y)
		Send, {w down}
		Sleep, 200
		Send, {w up}
		Sleep, 600
		Send, {s down}
		Sleep, 230
		Send, {s up}
	}

	change_sens()
	{
		InputBox, new_sens,, Input new sens:,,150,130
		if new_sens is integer
		{
			if (new_sens > 0 && new_sens < 101) {
				FileDelete, %A_ScriptDir%\wall_sens.txt
				FileAppend, %new_sens%, %A_ScriptDir%\wall_sens.txt
				Return
			}
		}
		MsgBox, Invalid sens value
	}

	key()
	{
		Array := [3, 4, 5, 9, 10, 18, 11, 12, 16, 1]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 18, 12, 16, 17, 2]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 18, 11, 16, 17, 6]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 18, 11, 12, 17, 7]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 18, 14, 15, 19, 20]
		this.shoot(Array, 4)
		Array := [3, 4, 5, 9, 10, 18, 11, 12, 16, 17]
		this.shoot(Array, 2)
		Array := [3, 4, 5, 9, 10, 11, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 12, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 16, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [3, 4, 5, 9, 10, 17]
		this.shoot(Array, 1)
		this.done()
	}

	chest()
	{
		Array := [3, 8, 13, 18, 20, 1, 6, 5, 10, 15]
		this.shoot(Array, 3)
		Array := [3, 8, 13, 18, 20, 1, 6, 11, 16, 0]
		this.shoot(Array, 1)
		Array := [3, 8, 13, 18, 20, 11, 16, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [3, 8, 13, 18, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 5)
		Array := [3, 8]
		this.shoot(Array, 1)	
		this.done()
	}

	emblem()
	{
		Array := [17, 19, 11, 13, 15, 7, 9, 1, 3, 5]
		this.shoot(Array, 1)
		Array := [17, 19, 11, 13, 15, 0, 0, 0, 0, 0]
		this.shoot(Array, 8)
		Array := [17, 19, 7, 9, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 4)
		this.done()
	}

	shuro()
	{
		Array := [2, 3, 4, 1, 7, 14, 20, 5, 9, 12]
		this.shoot(Array, 2)
		Array := [2, 3, 4, 1, 7, 14, 20, 9, 12, 16]
		this.shoot(Array, 2)
		Array := [2, 3, 4, 1, 7, 14, 20, 5, 12, 16]
		this.shoot(Array, 2)
		Array := [2, 3, 4, 1, 7, 14, 20, 5, 9, 16]
		this.shoot(Array, 2)
		Array := [2, 3, 4, 1, 7, 14, 20, 5, 9, 8]
		this.shoot(Array, 3)
		DllCall("mouse_event", "UInt", 0x01, "UInt", 0, "UInt", 30)
		Send, R
		Sleep, 2000
		Array := [2, 3, 4, 12, 16, 8, 6, 10, 11, 15]
		this.shoot(Array, 3)
		Array := [2, 3, 1, 7, 14, 20, 5, 17, 18, 19]
		this.shoot(Array, 2)
		Array := [9, 12, 16, 6, 10, 11, 15, 17, 18, 19]
		this.shoot(Array, 2)
		Array := [4, 1, 7, 14, 20, 5, 9, 12, 16, 8]
		this.shoot(Array, 2)
		Array := [6, 10, 11, 15, 17, 18, 19, 0, 0]
		this.shoot(Array, 2)
		this.done()
	}

	morgeth()
	{
		Array := [8, 3, 13, 18, 2, 4, 17, 19, 7, 9]
		this.shoot(Array, 4)
		Array := [8, 3, 13, 18, 2, 4, 17, 19, 12, 14]
		this.shoot(Array, 4)
		Array := [8, 3, 13, 18, 2, 4, 7, 9, 12, 14]
		this.shoot(Array, 3)
		Array := [8, 3, 13, 18, 17, 19, 1, 5, 16, 20]
		this.shoot(Array, 3)
		Array := [8, 2, 7, 9, 12, 14, 1, 5, 16, 20]
		this.shoot(Array, 1)
		Array := [8, 3, 13, 18, 4, 17, 19, 7, 9, 12]
		this.shoot(Array, 1)
		Array := [14, 1, 5, 16, 20]
		this.shoot(Array, 1)
		this.done()
	}

	vault()
	{
		Array := [3, 2, 4, 16, 17, 18, 19, 20, 1, 5]
		this.shoot(Array, 5)
		Array := [3, 2, 4, 16, 17, 18, 19, 20, 7, 9]
		this.shoot(Array, 5)
		Array := [3, 2, 4, 16, 17, 18, 1, 5, 7, 9]
		this.shoot(Array, 1)
		Array := [3, 2, 4, 19, 20, 1, 5, 7, 9, 6]
		this.shoot(Array, 1)
		Array := [3, 2, 4, 1, 5, 7, 9, 10, 11, 15]
		this.shoot(Array, 1)
		Array := [3, 1, 5, 7, 9, 0, 0, 0, 0, 0]
		this.shoot(Array, 2)
		Array := [3]
		this.shoot(Array, 1)
		this.done()
	}

	riven()
	{
		Array := [1, 16, 10, 15, 13, 3, 18, 6, 11, 9]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 3, 18, 6, 11, 14]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 3, 18, 6, 11, 5]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 3, 18, 9, 14, 20]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 3, 18, 5, 2, 17]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 3, 18, 6, 11, 20]
		this.shoot(Array, 2)
		Array := [1, 16, 10, 15, 13, 9, 14, 5, 2, 17]
		this.shoot(Array, 1)
		Array := [1, 16, 10, 15, 13, 9, 14, 20, 2, 17]
		this.shoot(Array, 1)
		Array := [1, 16, 10, 15, 6, 11, 5, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [1, 16, 9, 14, 20]
		this.shoot(Array, 1)
		this.done()
	}

	song()
	{
		Array := [13, 3, 8, 18, 2, 7, 12, 17, 4, 9]
		this.shoot(Array, 4)
		Array := [13, 3, 8, 18, 2, 7, 12, 17, 14, 19]
		this.shoot(Array, 4)
		Array := [13, 3, 8, 18, 2, 7, 4, 9, 14, 19]
		this.shoot(Array, 2)
		Array := [13, 3, 2, 7, 12, 17, 4, 9, 14, 19]
		this.shoot(Array, 2)
		Array := [13, 3, 8, 18, 12, 17, 4, 9, 14, 19]
		this.shoot(Array, 2)
		Array := [13, 8, 18, 4, 9, 14, 19, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [13, 8, 18]
		this.shoot(Array, 1)
		this.done()
	}

	failsafe()
	{
		Array := [14, 7, 8, 9, 12, 13, 0, 0, 0, 0]
		this.shoot(Array, 2)
		Array := [14, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 12)
		this.done()
	}

	drifter()
	{
		Array := [7, 8, 13, 14, 10, 15, 19, 20, 1, 2]
		this.shoot(Array, 2)
		Array := [7, 8, 13, 14, 10, 15, 19, 5, 6, 11]
		this.shoot(Array, 2)
		Array := [7, 8, 13, 14, 20, 0, 0, 0, 0, 0]
		this.shoot(Array, 2)
		Array := [7, 8, 13, 14, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [7, 8, 0, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 5)
		this.done()
	}

	party()
	{
		Array := [4, 5, 10, 11, 16, 17, 15, 19, 20, 9]
		this.shoot(Array, 1)
		Array := [4, 5, 10, 1, 2, 6, 11, 16, 17, 15]
		this.shoot(Array, 5)
		Array := [4, 5, 10, 1, 2, 6, 11, 16, 17, 9]
		this.shoot(Array, 3)
		Array := [4, 5, 10, 1, 2, 6, 19, 20, 9, 0]
		this.shoot(Array, 1)
		Array := [4, 5, 10, 1, 2, 6, 19, 20, 13, 0]
		this.shoot(Array, 2)
		Array := [4, 5, 10, 1, 2, 6, 19, 0, 0, 0]
		this.shoot(Array, 2)
		Array := [4, 5, 10, 1, 2, 6, 20, 8, 0, 0]
		this.shoot(Array, 2)
		this.done()
	}

	halo()
	{
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 1, 6]
		this.shoot(Array, 1)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 11, 7]
		this.shoot(Array, 1)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 12, 16]
		this.shoot(Array, 2)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 11, 12]
		this.shoot(Array, 2)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 11, 16]
		this.shoot(Array, 1)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 16, 0]
		this.shoot(Array, 1)
		Array := [14, 15, 20, 13, 5, 8, 9, 10, 0, 0]
		this.shoot(Array, 1)
		Array := [14, 15, 20, 13, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 3)
		Array := [14, 15, 20, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 3)
		this.done()
	}

	petra()
	{
		Array := [4, 9, 12, 17, 3, 1, 6, 15, 20, 5]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 3, 1, 6, 15, 20, 10]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 3, 1, 6, 15, 20, 11]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 3, 1, 6, 15, 20, 16]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 3, 5, 10, 11, 16, 2]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 1, 6, 15, 20, 7, 14]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 3, 5, 10, 11, 16, 19]
		this.shoot(Array, 2)
		Array := [1, 6, 15, 20, 3, 5, 10, 11, 16, 0]
		this.shoot(Array, 2)
		Array := [4, 9, 12, 17, 1, 6, 15, 20, 0, 0]
		this.shoot(Array, 1)
		this.done()
	}

	eggs()
	{
		Array := [8, 3, 17, 20, 2, 4, 14, 13, 1, 11]
		this.shoot(Array, 1)
		Array := [8, 3, 17, 20, 2, 4, 14, 13, 5, 16]
		this.shoot(Array, 5)
		Array := [8, 3, 17, 20, 2, 4, 14, 1, 0, 0]
		this.shoot(Array, 2)
		Array := [8, 3, 17, 20, 2, 4, 1, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [8, 3, 17, 20, 2, 1, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [8, 3, 17, 20, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [8, 3, 17, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 1)
		Array := [8, 3, 0, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 2)
		Array := [8, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		this.shoot(Array, 2)
		this.done()
	}
}

; Create new instance
wish := new WishWall

; End main script initialize
return

; Hotkeys (Note: All hotkeys verify that destiny 2 is the active window. Default behavior of the key is used otherwise.)
$F3::
if (!wish.GetWishInput()) ; Get a new wish input
    Send {F3}
return

$F4::
if (!wish.MakeAWish()) ; Use the last input wish
    Send {F4}
return
