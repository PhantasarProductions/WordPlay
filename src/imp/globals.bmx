Strict

Import brl.map
Import maxgui.drivers
Import tricky_units.Listfile
Import tricky_units.ListDir
Import brl.eventqueue

Global MaxLanguages:tmap = New tmap
Function L:Tmaxguilanguage(tag$)
	Return tmaxguilanguage ( MapValueForKey(MaxLanguages,tag) )
End Function

?Not macos
Global  langdir$ = AppDir+"/"+"Languages/"
Global worddir$ = AppDir+"/"+"Wordlist/"
?MacOS
Global langdir$ = AppDir+"/"+StripAll(AppFile)+".app/Contents/Resources/Languages/"
Global worddir$ = AppDir+"/"+StripAll(AppFile)+".app/Contents/Resources/WordList/"
? 

Global langlist:TList = ListDir(langdir)
For Local lf$=EachIn  langlist
SortList langlist
	Print "Loading Language: "+lf
	MapInsert maxlanguages,StripAll(lf),LoadLanguage(langdir+lf)
Next

Global wordlistfiles:TList = ListDir(worddir)

Global lang$ =  "English"
Global cud = 1
Global cdu = 0
Global crl = 0
Global clr = 1

Function Nothing(G:TGadget) End Function ' Silly what you need sometimes, eh? :-P

Type tcallback
	Field action(g:tgadget) = Nothing
End Type
Global CallBackMap : tmap = New tmap
Global CBNothing:TCallback = New tcallback

Function GetCallBack:Tcallback(G:TGadget)
	Local ret:tcallback = tcallback(MapValueForKey(callbackmap,G))
	If Not ret Return CBNothing
	Return ret
End Function

Function Callback(G:TGadget,func(G:TGadget),A$="Action")
	Local CB:Tcallback = New tcallback
	If MapContains(callbackmap,G)
		 CB = getcallback(G)
		Print "Added '"+A+"' function to existing callback"
	Else
		Print "New callback for action "+A+" created"
		MapInsert callbackmap,g,CB
	EndIf
	Select Upper(a)
		Case "ACTION"	CB.action  = func
	End Select
End Function