Import "LoadPuzzle.bmx"

Function Init()
	AppTitle = "Wordplay"
	LoadPuzzle(DefaultPuzzle)
	Graphics 1200,pzf_s*41
	puzfont = LoadImageFont("incbin::whitrabt.ttf",pzf_s)
	If Not puzfont Notify "WARNING:~nPuzzle font not properly loaded"
End Function
