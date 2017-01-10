Strict

Import maxgui.drivers
Import "globals.bmx"

Private
	Global Gen_Win:TGadget = CreateWindow("",0,0,500,75,Null,Window_center|window_hidden|Window_clientcoords)
	Global gww = ClientWidth(gen_win)

	LocalizeGadget CreateLabel("",0,  0,gww,25,gen_win),"{{generatingpuzzle}}"
	LocalizeGadget CreateLabel("",0, 25,gww,25,gen_win),"{{pleasewait}}"

	LocalizeGadget  gen_win, "{{title}}"
	
	Global Gen_Progbar:Tgadget = CreateProgBar(0, 50,gww,25,gen_win)
	Global ListOfWords:TList
	Global Usedwords:TList
	Global PlayWordList:TList
	
	Function GenFill()
		For Local x=0 Until pz_maxwidth
			For Local y=0 Until pz_maxheight
				If Not pz_letters[x,y] 
					pz_letters[x,y] = Rand(65,90)
					'pz_letters[x,y] = Asc(".")
				EndIf	
			Next
		Next	
	End Function

	' I didn't go for speed. I went for STABILITY!
	' With tons of instable software I chose this way :P
	Function GenFlow()
		' Pick a word
		Local word$ = Trim ( String(listofwords.valueatindex(Rand(0,CountList(listofwords)-1))) )
		Local uword$ = Upper(word)
		DebugLog "Chosen word "+uword
		' Hey this word was used before, get the hell outta here!
		If ListContains(usedwords,uword) Return DebugLog( "We already have: "+uword)
		' Define startpoint
		Local stx,sty
		stx = Rand(0,pz_maxwidth-1)
		sty = Rand(0,pz_maxheight-1)
		' Select a direction
		Local dir = Rand(0,(Len gdr)-1)
		If Not gdr[dir] Return ' Illegal direction, sorry!
		'Now set values according to direction
		Local rx,ry
		Select dir
			Case gdr_ud	rx =  0	ry =  1
			Case gdr_du	rx =  0	ry = -1
			Case gdr_lr	rx =  1	ry =  0
			Case gdr_rl	rx = -1	ry =  0
			Default Return Print("*** UNKNOWN DIRECTION: "+dir)
		End Select
		' Can we actually do this?
		Local tx,ty
		tx=stx	ty=sty
		For Local lp=0 Until (Len uword)
			If tx<0 Or ty<0 Or tx>=pz_maxwidth Or ty>=pz_maxheight	Return 'Out of the boundaries.
			If pz_letters[tx,ty] And pz_letters[tx,ty]<>uword[lp] Return ' Letter conflict, goodbye			
			tx:+rx
			ty:+ry
		Next		
		' Apparently, we can let's put it in!
		ListAddLast usedwords,uword
		ListAddLast playwordlist,word
		tx=stx	ty=sty
		For Local lp=0 Until (Len uword)
			pz_letters[tx,ty]=uword[lp]
			tx:+rx
			ty:+ry
		Next
		'Sort the wordlist alphabetically
		SortList playwordlist
		UpdateProgBar gen_progbar,Double(CountList(playwordlist))/Double(numwords)
		If CountList(playwordlist)>=numwords 
			genFill
			?debug
			For Local y=0 Until pz_maxheight
				For Local x=0 Until pz_maxwidth
					WriteStdout Chr(pz_letters[x,y])+" "
				Next
				Print
			Next
			For Local w$=EachIn playwordlist
				Print w
			Next
			? 
			GenChain
		EndIf	
	End Function


Public
	Function StartGenerator()
		HideGadget mm_win
		ShowGadget gen_win
		CurrentFlow = GenFlow
		listofwords = Listfile("Wordlist/"+wordlist)	
		usedwords = New TList	
		playwordlist = New TList
		If requestseed Then SeedRnd requestseed trueseed=requestseed Else trueseed=MilliSecs() SeedRnd trueseed
		Print "Generating on seed: "+trueseed
		For Local a=0 Until pz_maxwidth
			For Local b=0 Until 	pz_maxheight
				pz_letters[a,b]=0
			Next
		Next
'		Notify "SORRY! THE GENERATOR DOESN'T WORK YET!"; End
	End Function

	Function HTMLOutput()
		currentflow = Null
		HideGadget gen_win
		Local file$ = RequestFile("Save puzzle as HTML","Hypertext Markup Language:html",1)
		Local bt:TStream = WriteFile(file)
		If Not bt Notify "Write error!"; Return
		WriteLine bt,"<title> Puzzle seed #"+trueseed+"</title>"
		WriteLine bt,"<h1>Puzzle #"+trueseed+" "+Wordlist+"</h1>"
		WriteLine bt,"<table width=100%> "
		WriteLine bt,"<tr><td><pre>"
		For Local y=0 Until pz_maxheight
			For Local x=0 Until pz_maxwidth
				WriteString bt, Chr(pz_letters[x,y])+" "
			Next
			WriteLine bt,""
		Next
		WriteLine bt,"</pre></td><td>"
		For Local w$=EachIn playwordlist
			 WriteLine bt,w+"<br>"
		Next
		WriteLine bt,"</td></tr></table>"
		CloseFile bt
		ShowGadget mm_win
	End Function
		
	Function jcr6output()
		Local bt:TJCRCreate = JCR_Create(Swapdir+"GeneratedPuzzle")
		Local bo:TJCRCreateStream = bt.createentry("Data","zlib")
		WriteLine bo.stream,"Seed:"+trueseed
		WriteLine bo.stream,"Width:"+pz_maxheight
		WriteLine bo.stream,"Height:"+pz_maxwidth
		WriteLine bo.stream,"Language:"+lang
		WriteLine bo.stream,"WordCount:"+CountList(playwordlist)
		bo.close
		bo = bt.createentry("WordList","zlib")
		For Local w$=EachIn playwordlist 
			WriteLine bo.stream,w
		Next
		bo.close
		bo = bt.createentry("Letters")
		For Local y=0 Until pz_maxheight
			For Local x=0 Until pz_maxwidth
				WriteByte bo, pz_letters[x,y]
			Next
		Next
		bo.close
		bt.close "zlib"	
	End Function	
		
