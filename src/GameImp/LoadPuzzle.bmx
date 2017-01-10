Strict
Import "globals.bmx"

Function LoadPuzzle(F$)
	Print "Loading puzzle: "+f
	Local J:TJCRDir = JCR_Dir(f)
	If Not j 
		Notify "File could not be processed: "+F
		End
	Endif
	puzdata = New StringMap
	For Local l$=EachIn Listfile(JCR_B(J,"Data"))
		Local p$[]=l.split(":")
		If (Len p)=2 MapInsert puzdata,Trim(p[0]),Trim(P[1])
	Next
	If f=defaultpuzzle AppTitle = "Wordplay - Seed #"+PuzData.Value("Seed") Else AppTitle = "Wordplay - "+F
	DebugLog "AppTitle = "+AppTitle
End Function
