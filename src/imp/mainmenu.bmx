Strict

Import "globals.bmx"


Global mm_win:tgadget = CreateWindow(AppFile,0,0,ClientWidth(Desktop())*.75,ClientHeight(Desktop())*.75,Null,window_center | Window_titlebar )
Global mm_ww = ClientWidth(mm_win)
Global mm_wh = ClientWidth(mm_win)
Global mm_cx = mm_ww/2
Global mm_cy = mm_wh/2
LocalizeGadget CreateLabel("yeah",0,0,mm_cx,25,mm_win),"{{dir}}","dir"

Global mm_ud:tgadget = CreateButton("",mm_cx  ,0,mm_cx/2,25,mm_win,button_checkbox)
Global mm_du:tgadget = CreateButton("",mm_cx+(mm_cx/2),0,mm_cx/2,25,mm_win,button_checkbox)
SetButtonState mm_ud,cud
SetButtonState mm_du,cdu
Global mm_lr:tgadget = CreateButton("",mm_cx  ,25,mm_cx/2,25,mm_win,button_checkbox)
Global mm_rl:tgadget = CreateButton("",mm_cx+(mm_cx/2),25,mm_cx/2,25,mm_win,button_checkbox)
SetButtonState mm_lr,clr
SetButtonState mm_rl,crl


LocalizeGadget CreateLabel("yeah",0,50,mm_cx,25,mm_win),"{{words}}","words"
Global NumWords:TGadget = CreateComboBox(mm_cx,50,mm_cx,25,mm_win)
For Local i=5 To 25 Step 5 
	AddGadgetItem Numwords,i
Next
SelectGadgetItem numwords,3

LocalizeGadget  mm_win, "{{title}}", "title"

LocalizeGadget mm_ud,"{{dir_ud}}"
LocalizeGadget mm_du,"{{dir_du}}"
LocalizeGadget mm_lr,"{{dir_lr}}"
LocalizeGadget mm_rl,"{{dir_rl}}"