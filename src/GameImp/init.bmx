Import "LoadPuzzle.bmx"

Function Init()
	AppTitle = "Wordplay"
	LoadPuzzle(DefaultPuzzle)
	Graphics 1200,pzf_s*41
	puzfont = LoadImageFont("incbin::whitrabt.ttf",pzf_s)
	If Not puzfont Notify "WARNING:~nPuzzle font not properly loaded"
	Cls
	TileImage bcki,0,0
	Local p:TPixmap = GrabPixmap(0,0,GraphicsWidth(),GraphicsHeight())
	Print GraphicsWidth()+"x"+GraphicsHeight()
	bcki2=LoadImage(p)
End Function
