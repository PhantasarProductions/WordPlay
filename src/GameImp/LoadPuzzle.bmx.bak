Strict
Import "globals.bmx"

Function LoadPuzzle(F$)
	Print "Loading puzzle: "+f
	Local J:TJCRDir = JCR_Dir(f)
	If Not j 
		Notify "File could not be processed: "+F
		End
	EndIf
	puzdata = New StringMap
	For Local l$=EachIn Listfile(JCR_B(J,"Data"))
		Local p$[]=l.split(":")
		If (Len p)=2 MapInsert puzdata,Trim(p[0]),Trim(P[1])
		DebugLog p[0]+" = "+p[1]
	Next
	If f=defaultpuzzle AppTitle = "Wordplay - Seed #"+PuzData.Value("Seed") Else AppTitle = "Wordplay - "+F
	puzletters = New Byte[ puzdata.value("Width").toint() , puzdata.value("Height").toint() ]
	Local BT:TStream = ReadFile( JCR_B( J,"Letters") )
	For Local lx=0 Until puzdata.value("Width").toint() For Local ly=0 Until puzdata.value("Height").toint()
		puzletters[lx,ly]=ReadByte(BT)
	Next Next
	puzwordslist = Listfile ( JCR_B( J,"Wordlist" ) )
	puzwords=String[](ListToArray(puzwordslist))
	For Local i=0 Until (Len puzwords) DebugLog i + "   "+puzwords[i] Next
	For Local w$=EachIn puzwordslist DebugLog "list>> "+W Next
	DebugLog "AppTitle = "+AppTitle
	pw = puzdata.value("Width").toint()
	ph = puzdata.value("Height").toint()
	puzsolved = New TList
	boxes=New tlist
End Function
