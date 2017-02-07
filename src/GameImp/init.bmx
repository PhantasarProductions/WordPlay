Import "LoadPuzzle.bmx"

Function Init()
	AppTitle = "Wordplay"
	LoadPuzzle(DefaultPuzzle)
	Graphics 1000,800
	puzfont = LoadImageFont("incbin::whitrabt.ttf",25)
	If Not puzfont Notify "WARNING:~nPuzzle font not properly loaded"
End Function
