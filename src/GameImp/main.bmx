Import "Init.bmx"

Function DrawLetters()
	SetImageFont puzfont
	SetColor 255,255,255
	Print pw+"x"+ph
	Local x,y
	Local l$
	For x=0 Until pw For y=0 Until ph 
		l = Chr(puzletters[x,y])
		DrawText l,(x*25)+(TextWidth(l)/2),(y*25)+(TextHeight(l)/2)
	Next Next
End Function

Function DrawScreen()
	DrawLetters()
End Function

Function GoMain()
	Repeat
		Cls
		drawscreen
		?debug
			If KeyDown(KEY_B) And KeyDown(KEY_Y) And KeyDown(KEY_E) End
		?
		Flip
	Forever
End Function
