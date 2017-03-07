Strict

Import "generator.bmx"


mm_win:tgadget = CreateWindow(AppFile,0,0,ClientWidth(Desktop())*.75,ClientHeight(Desktop())*.75,Null,window_center | Window_titlebar )
Global mm_ww = ClientWidth(mm_win)
Global mm_wh = ClientWidth(mm_win)
Global mm_cx = mm_ww/2
Global mm_cy = mm_wh/2
LocalizeGadget CreateLabel("yeah",0,0,mm_cx,25,mm_win),"{{dir}}","dir"

Function Goodbye(G:Tgadget) End End Function
callback mm_win,goodbye,"CLOSE"

Global mm_ud:tgadget = CreateButton("",mm_cx  ,0,mm_cx/2,25,mm_win,button_checkbox)
Global mm_du:tgadget = CreateButton("",mm_cx+(mm_cx/2),0,mm_cx/2,25,mm_win,button_checkbox)
SetButtonState mm_ud,cud
SetButtonState mm_du,cdu
Global mm_lr:tgadget = CreateButton("",mm_cx  ,25,mm_cx/2,25,mm_win,button_checkbox)
Global mm_rl:tgadget = CreateButton("",mm_cx+(mm_cx/2),25,mm_cx/2,25,mm_win,button_checkbox)
SetButtonState mm_lr,clr
SetButtonState mm_rl,crl


LocalizeGadget CreateLabel("yeah",0,50,mm_cx,25,mm_win),"{{words}}","words"
Global mm_NumWords:TGadget = CreateComboBox(mm_cx,50,mm_cx,25,mm_win)
For Local i=5 To 40 Step 5 
	AddGadgetItem mm_Numwords,i
Next
SelectGadgetItem mm_numwords,3

LocalizeGadget CreateLabel("yeah",0,75,mm_cx,25,mm_win),"{{list}}"
Global mm_wordlist:tgadget = CreateComboBox(mm_cx,75,mm_cx,75,mm_win)
If Not CountList(wordlistfiles) Notify "No word lists have been found!~nI need at least one to operate"; End
SortList wordlistfiles
For Local w$=EachIn wordlistfiles 
	AddGadgetItem mm_wordlist,w
Next
SelectGadgetItem mm_wordlist,0

LocalizeGadget CreateLabel("yeah",0,100,mm_cx,25,mm_win),"{{seed}}"
Global mm_seed : tgadget = CreateTextField(mm_cx,100,mm_cx,25,mm_win)


LocalizeGadget CreateLabel("yeah",0,125,mm_cx,25,mm_win),"{{language}}"

Global mm_lang : Tgadget = CreateComboBox(mm_cx,125,mm_cx,25,mm_win)

LocalizeGadget CreateLabel("yeah",0,150,mm_cx,25,mm_win),"{{performance}}"
Global mm_perpanel : TGadget = CreatePanel(mm_cx,150,mm_cx,50,mm_win)
Global mm_fast : tgadget = CreateButton("yeah",0,0,mm_cx,25,mm_perpanel,button_radio); LocalizeGadget mm_fast,"{{pcpfast}}"; SetButtonState mm_fast,1
LocalizeGadget CreateButton("yeah",0,25,mm_cx,25,mm_perpanel,button_radio),"{{pcpslow}}"

Private
	Global clang,c
	For Local lng$=EachIn langlist
		AddGadgetItem mm_lang,StripAll(lng )
		If StripAll(lng)=lang clang=c
		c:+1
		?debug
		Print "Init lang "+lng+"; default lang: "+lang
		?
	Next 
	SelectGadgetItem mm_lang,clang
	
	Function SelectLanguage(G:TGadget)
		Print "Localizing as: "+lang+" as requested by the user"
		Local c = SelectedGadgetItem(G)
		lang = GadgetItemText(G,c)
		SetLocalizationLanguage  L(lang)
	End Function
	
	callback mm_lang,SelectLanguage
	
	
	Function DoDir(G:TGadget)
		Local r:Byte
		Select g	
			Case mm_ud r=gdr_ud
			Case mm_du r=gdr_du
			Case mm_lr r=gdr_lr
			Case mm_rl r=gdr_rl
		End Select
		?debug
		Print "Set "+r+" to "+ButtonState(G)
		?
		gdr[r]=ButtonState(G)
	End Function
	callback mm_ud,dodir	dodir mm_ud
	callback mm_du,dodir	dodir mm_du
	callback mm_lr,dodir	dodir mm_lr
	callback mm_rl,dodir	dodir mm_rl
	
	Function ReqSeed(G:TGadget)
		requestseed = GadgetText(G).toint()
		If requestseed trueseed=requestseed Else trueseed=MilliSecs()
		Print "Seed is now: "+trueseed+"          ("+requestseed+")"
	End Function
	reqseed mm_seed
	callback mm_seed,reqseed
	
	Function GetWordList(G:TGadget)
		wordlist = GadgetText(G)
		Print "Using list: "+wordlist
	End Function 
	Getwordlist mm_wordlist
	callback mm_wordlist,GetWordList
	
	Function GetNumWords(G:TGadget)
		Local i = SelectedGadgetItem(g)
		Local r = (i+1)*5
		numwords = r
		Print "We want "+numwords+" words in our puzzle"
	End Function
	getnumwords mm_numwords
	callback mm_numwords,getnumwords
		
Public

LocalizeGadget  mm_win, "{{title}}", "title"
LocalizeGadget mm_ud,"{{dir_ud}}"
LocalizeGadget mm_du,"{{dir_du}}"
LocalizeGadget mm_lr,"{{dir_lr}}"
LocalizeGadget mm_rl,"{{dir_rl}}"


Global mm_html:Tgadget = CreateButton("yeah?",0,300,MM_ww,25,mm_win)
Global mm_play:Tgadget = CreateButton("yeah?",0,325,mm_ww,25,mm_win)

LocalizeGadget mm_html,"{{genhtml}}"
LocalizeGadget mm_play,"{{genplay}}"

Function PlayGame()
	jcr6output
	?win32
	system_ "WordPlay_Play.exe"
	?macos
	Notify "Mac chain not available yet!"
	? 
End Function
	
Function Gen(G:TGadget)
	HideGadget mm_win
	Select g
		Case mm_html  genchain = HTMLOutput
		Case mm_play		genchain = PlayGame
	End Select
	startgenerator
End Function



callback mm_html,gen
callback mm_play,gen
