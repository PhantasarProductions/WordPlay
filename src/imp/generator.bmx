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


	Function GenFlow()
	End Function


Public
	Function StartGenerator()
		HideGadget mm_win
		ShowGadget gen_win
		CurrentFlow = GenFlow		
'		Notify "SORRY! THE GENERATOR DOESN'T WORK YET!"; End
	End Function

