#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to it's speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory

; Table of Contents:
; 1.  Ctrl+Alt+h   - Displays Help (Readme file)
; 2.  Ctrl+R       - Reload Script.
; 3.  Ctrl+Space   - Sets active window on top.  Toggles On/Off.
; 4.  Ctrl+Shift+m - Pastes in Member ID and all other relevant information.  Place of Service = 11.
; 5.  Ctrl+Shift+n - Pastes in Member ID and all other relevant information.  Place of Service = 12.
; 6.  Ctrl+Shift+p - Paste in Procedure Code, Modifier, Units, From/To Date, and Billed Charge Amount.  Pastes information into web form.
; 7.  Ctrl+Alt+p   - Debugger for the Script above.
; 8.  Code to Support Member ID.

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^!h::
; Ctrl+Alt+h - Show Help (the Readme file)
FileRead, Readme, %A_ScriptDir%\Readme.md
Gui, Add, Text,, %Readme%
Gui, Show,, Help for Wife's AutoHotKey Scripts
Return

;//////////////////////////////////////////////////////////////////////////////////////////

^r::
; Ctrl+r to Reload Script
Msgbox, 4, Reload Script, Do you really want to reload this script?
ifMsgBox, Yes
  Reload
Return

;//////////////////////////////////////////////////////////////////////////////////////////

^SPACE::Winset, Alwaysontop, , A
;Ctrl+Space - Sets active window to always on top.  Toggles On/Off

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

^+m::
;Ctrl+Shift+M - Pastes in Member ID and all other relevant information.  Place of Service = 11.
placeOfService := "10" ; Actually sets POS to 11.  10 works here for whatever reason.
EnterMemberID(placeOfService)
Return

;//////////////////////////////////////////////////////////////////////////////////////////

^+n::
;Ctrl+Shift+N - Pastes in Member ID and all other relevant information.  Place of Service = 12.
placeOfService := "12" ; Sets POS to 12.
EnterMemberID(placeOfService)
Return

;//////////////////////////////////////////////////////////////////////////////////////////

^+p::
;Ctrl+Shift+P - Paste in Procedure Code, Modifier, Units, From/To Date, and Billed Charge Amount.  Pastes information into web form.
StringReplace, clipboard, clipboard, `r`n ; Removes carriage returns and new lines
array := StrSplit(clipboard, "`t") ; Delimits the clipboard by tab

; Put all of the data into variables for readability
procCode := array[1]
modCode := array[2]
fromDate := array[3]
toDate := array[4]
units := array[5]
billedCharge := array[6]

; Trim whitespaces to ensure proper function
procCode = %procCode%
modCode = %modCode%
fromDate = %fromDate%
toDate = %toDate%
units = %units%
billedCharge = %billedCharge%

delay = 400 ; Delay in milliseconds.  Lower is faster.  Warning: Setting this too low might cause issues.

; Put all the stuff on the page.
Send, %procCode%
Sleep, delay * 2
Send, {Tab}
Sleep, delay 
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, %modCode%
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, %units%
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, %fromDate%
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, %toDate%
Sleep, delay
Send, {Tab}
Sleep, delay
Send, {Tab}
Sleep, delay
Send, %billedCharge%

return

^!p::
; Debugging for Ctrl+Shift+p
StringReplace, clipboard, clipboard, `r`n ; Removes carriage returns and new lines

array := StrSplit(clipboard, "`t") ; Delimits the clipboard by tab

; Put all of the data into variables for readability
procCode := array[1]
modCode := array[2]
fromDate := array[3]
toDate := array[4]
units := array[5]
billedCharge := array[6]

clipboard := "Proc: " procCode "`r`nModifier: " modCode "`r`nFrom: " fromDate "`r`nTo: " toDate "`r`nUnits: " units "`r`nBilled: " billedCharge
msgbox % clipboard

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////

EnterMemberID(placeOfService)
{
	StringReplace, clipboard, clipboard, `r`n ; Removes carriage returns and new lines
	clipboard = %clipboard% ; Remove whitespaces

	; Put all of the data into variables for readability
	memberID := clipboard
	providerID := "1427179076-01"
	diagCode := "Z59.9"
	outcomeCode := "01"
	
	delay = 400 ; Delay in milliseconds.  Lower is faster.  Warning: Setting this too low might cause issues.
	
	; Put all the stuff onto the page.
	Send, %memberID%
	Sleep, delay * 2
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, %providerID%
	Sleep, delay * 1.5
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay * 2
	Send, %placeOfService%
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, %outcomeCode%
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, {Tab}
	Sleep, delay
	Send, %diagCode%
}
