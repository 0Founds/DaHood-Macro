; <COMPILER: v1.1.37.02>
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
global isRunning := false
global keybind := ""
global oldKeybind := ""
global delay := 10
global waitingForKeybind := false
Gui, Color, 000000
Gui, Font, s5, Consolas
Gui, Add, Text, cffffff,
( 
 _____ ______   ________  ________  ________  ________         
|\   _ \  _   \|\   __  \|\   ____\|\   __  \|\   __  \        
\ \  \\\__\ \  \ \  \|\  \ \  \___|\ \  \|\  \ \  \|\  \       
 \ \  \\|__| \  \ \   __  \ \  \    \ \   _  _\ \  \\\  \      
  \ \  \    \ \  \ \  \ \  \ \  \____\ \  \\  \\ \  \\\  \     
   \ \__\    \ \__\ \__\ \__\ \_______\ \__\\ _\\ \_______\    
    \|__|     \|__|\|__|\|__|\|_______|\|__|\|__|\|_______|    
                                                               
                                                               
)
Gui, Font, s12, Consolas
Gui, Add, Text, cffffff, Current Keybind:
Gui, Add, Text, vKeybindDisplay cffffff w200 h20, NONE
Gui, Add, Button, gSetKeybind, Set Keybind
Gui, Font, s12, Consolas
Gui, Add, Text, cffffff, Macro Delay:
Gui, Add, Edit, vDelayEdit w52, %delay%
Gui, Add, Button, gSaveSettings, Save
Gui, Font, s10, Consolas
Gui, Show,, macro
return
SetKeybind:
if (oldKeybind != "")
{
Hotkey, %oldKeybind%, ToggleMacro, Off
}
GuiControl,, KeybindDisplay, Select a button.
Input, keybind, L1 T1
if (ErrorLevel = "Timeout")
{
GuiControl,, KeybindDisplay, NO BUTTON
return
}
StringUpper, keybind, keybind
GuiControl,, KeybindDisplay, %keybind%
Hotkey, ~*%keybind%, ToggleMacro
oldKeybind := keybind
GuiControl,, KeybindDisplay,your macro toggle is %keybind% . 
return
SaveSettings:
GuiControlGet, keybind, , KeybindDisplay
GuiControlGet, delay, , DelayEdit
delay := (delay < 1) ? 1 : delay
return
ToggleMacro:
isRunning := !isRunning
if isRunning {
SetTimer, RunMacro, % delay
} else {
SetTimer, RunMacro, Off
}
return
RunMacro:
Send, {Blind}{WheelUp}
Sleep, %delay%
Send, {Blind}{WheelDown}
Sleep, %delay%
return
GuiClose:
ExitApp