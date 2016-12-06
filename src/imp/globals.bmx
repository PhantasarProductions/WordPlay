Strict

Import brl.map
Import maxgui.drivers

Global MaxLanguages:tmap = New tmap
Function L:Tmaxguilanguage(tag$)
	Return tmaxguilanguage ( MapValueForKey(MaxLanguages,tag) )
End Function