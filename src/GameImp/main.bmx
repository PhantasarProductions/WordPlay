Strict
Import "Init.bmx"
Private

Function DrawLetters()
    Rem
	SetBlend lightblend
	Local ms=MilliSecs()/5
	For Local x=0 Until GraphicsWidth()
		SetColor 0,0,50+(Sin(x+ms)*50)
		DrawLine x,0,x,GraphicsHeight()
	Next
	For Local y=0 Until GraphicsHeight()
		SetColor 0,0,50+(Sin(y+ms)*50)
		DrawLine 0,y,GraphicsWidth(),y
	Next
	EndRem
    ' Show puzzle
	Local mx=Floor(MouseX()/pzf_s)
	Local my=Floor(MouseY()/pzf_s)
	SetBlend alphablend
	SetAlpha 1
	SetImageFont puzfont
	SetColor 255,255,255
	'Print pw+"x"+ph
	Local x,y
	Local l$
	For x=0 Until pw For y=0 Until ph 
		l = Chr(puzletters[x,y])
		If mx=x And my=y SetColor 255,0,0 Else SetColor 255,255,255
		DrawText l,(x*pzf_s)+(TextWidth(l)/2),(y*pzf_s)+(TextHeight(l)/2)
		?debug
		If (x*pzf_s)+(TextWidth(l)/2)>GraphicsWidth() Or (y*pzf_s)+(TextHeight(l)/2)>GraphicsHeight() Print "WARNING pos("+x+","+y+") out of screen range"
		?
	Next Next
	y=5
	For Local w$=EachIn puzwordslist
		DrawText w,(41*pzf_s),y
		If ListContains(puzsolved,Upper(w)) DrawLine( (41*pzf_s),y+(TextHeight(w)/2),(41*pzf_s)+TextWidth(w),y+(TextHeight(w)/2) )
		y:+TextHeight(w)
	Next
	If vast
		SetAlpha .75
		SetColor 255,180,0
		DrawLine (vastx*pzf_s)+(pzf_s/2),(vasty*pzf_s)+(pzf_s/2),MouseX(),MouseY()
		SetAlpha 1
	EndIf
	For Local b:tpbox = EachIn boxes b.draw ;Next
End Function

Function DrawTime()
	SetColor 255,180,0
	If Not oldtime 
		oldtime=CurrentTime()
	ElseIf oldtime<>CurrentTime()
		tmsc:+1
		oldtime = CurrentTime()
		If tmsc>=60 tmsc:-60; tmmn:+1
		If tmmn>=60 tmmn:-60; tmhr:+1
		If tmsc=0 bckc=Rand(0,7)
	EndIf
	Local st$ = ""
	If tmhr st:+tmhr+"h"
	If tmmn st:+tmmn+"'"
	If tmsc st:+tmsc+"~q"
	Local tmw=TextWidth(st)
	Local tmh=TextHeight(st)
	Local scw=GraphicsWidth()
	Local sch=GraphicsHeight()
	DrawText st,scw-tmw,sch-(tmh*2.5)
End Function

Function DrawOk()
	SetColor 180,255,0
	Local d$ = PuzFound+"/"+PuzHave
	Local tmw=TextWidth(d)
	Local tmh=TextHeight(d)
	Local scw=GraphicsWidth()
	Local sch=GraphicsHeight()
	DrawText d,scw-tmw,sch-tmh
End Function

Function DrawBack()
	If Not bcki Return
	Local x,y
	'Local scw=GraphicsWidth()
	'Local sch=GraphicsHeight()
	'Local cx = scw/2
	'Local cy = sch/2
	'x = cx+(Sin(bckdeg)*100)
	'y = cy+(Cos(bckdeg)*100)
	bckdeg:+bckspd
	If bckdeg>360 bckdeg:-360
	SetColor bckr,bckg,bckb
	'TileImage bcki,x,y
	SetScale 1,1
	DrawImage bcki2,00,0
	If bckr<bckra[bckc] bckr:+1
	If bckg<bckga[bckc] bckg:+1
	If bckb<bckba[bckc] bckb:+1
	If bckr>bckra[bckc] bckr:-1
	If bckg>bckga[bckc] bckg:-1
	If bckb>bckba[bckc] bckb:-1
	SetColor 255,255,255	DrawText bckc+">"+bckr+"/"+bckg+"/"+bckb+"  "+bckra[bckc]+"/"+bckga[bckc]+"/"+bckba[bckc]+"  ("+x+","+y+") "+GraphicsWidth()+"x"+GraphicsHeight(),0,0
End Function

Function DrawScreen()
	DrawBack
	DrawLetters
	DrawTime
	DrawOk
End Function

Global vastx,vasty,vast
Function MouseCheck()
	Local down=MouseDown(1)
	Local mx=MouseX()
	Local my=MouseY()
	Local endx,endy,i
	Local woord$
	If (Not vast) And down
		vastx=mx/pzf_s
		vasty=my/pzf_s
		If vastx>pw Or vasty>ph Return
		vast=True
	ElseIf (Not down) And Vast
		vast=False
		endx=mx/pzf_s
		endy=my/pzf_s
		woord=""
		If     endx=vastx And endy>vasty
			For i=vasty To endy Step  1 woord:+pzlet(vastx,i) Next; DebugLog "VUD"
		ElseIf endx=vastx And endy<vasty
			For i=vasty To endy Step -1 woord:+pzlet(vastx,i) Next; DebugLog "VDU"
		ElseIf endy=vasty And endx<vastx
			For i=vastx To endx Step -1 woord:+pzlet(i,vasty) Next; DebugLog "HRL"
		ElseIf endy=vasty And endx>vastx
			For i=vastx To endx Step  1 woord:+pzlet(i,vasty) Next; DebugLog "HLR"
		Else 
			DebugLog "UNK: ("+vastx+","+vasty+") >> ("+endx+","+endy+")"
		EndIf
		Print "Mouse up >> "+woord
		For Local w$=EachIn puzwordslist
			If Upper(w)=woord And (Not ListContains( puzsolved, woord )) ListAddLast puzsolved,woord; SortList puzsolved; Abox vastx,vasty,endx+1,endy+1; puzfound=CountList(puzsolved)
		Next
	EndIf
End Function

Public
Function GoMain()
	Repeat
		Cls
		drawscreen
		?debug
			If KeyDown(KEY_B) And KeyDown(KEY_Y) And KeyDown(KEY_E) End
		?
		MouseCheck
		Flip
	Forever
End Function
