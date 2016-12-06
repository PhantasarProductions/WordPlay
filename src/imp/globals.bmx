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

For Local lf$=EachIn ListDir(langdir)
	Print "Loading Language: "+lf
	MapInsert maxlanguages,StripAll(lf),LoadLanguage(langdir+lf)
Next

Global wordlistfiles:TList = ListDir(worddir)

Global lang$ =  "English"
Global cud = 1
Global cdu = 0
Global crl = 0
Global clr = 1

