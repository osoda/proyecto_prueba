F12::Reload
~End::
{
	MouseGetPos, MouseX, MouseY
	PixelGetColor, Xcolor, 858, 425, RGB
	Sleep, 300
	MouseMove, 858, 425
	Sleep, 1000
	MsgBox The color at the current cursor position is %Xcolor%.
	return
}