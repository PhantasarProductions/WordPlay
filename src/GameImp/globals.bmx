Strict
Import brl.max2d
Import tricky_units.Dirry
Import jcr6.jcr6main
Import tricky_units.StringMap
Import tricky_units.Listfile
Import Tricky_Units.Rectangles

Import "Pix/Pix.h.bmx"


Global swapdir$ = Dirry("$AppSupport$/WordPlay/")
Global defaultpuzzle$ = Swapdir+"Generatedpuzzle"

Global PuzData:StringMap
Global puzletters:Byte[,]
Global puzwordslist:TList,puzwords$[]
Global puzsolved:TList
Global puzfound,puzhave

Function pzlet$(x,y)
	If x>=0 And y>=0 And x<pw And y<ph Return Chr(puzletters[x,y])
	Return "<???>("+x+","+y+")"
End Function

Global pw,ph
Const pzf_s=20


Global puzfont:timagefont


Type tpBox
	Field x,y,w,h
	Field r,g,b
	Method draw()
		SetColor r,g,b
		Rect x,y,w,h
	End Method
End Type
Global boxes:TList
Function addbox(x,y,w,h)
	Local d:tpbox = New tpbox
	d.x=x; d.y=y; d.w=w; d.h=h
	d.r=Rand(0,255); d.g=Rand(0,255); d.b=Rand(0,255)
	ListAddLast boxes,d
	DebugLog "Generated box: ("+x+","+y+","+w+","+h+")"
End Function
Function abox(x1,y1,x2,y2)
	Local w=x2-x1
	Local h=y2-y1
	DebugLog "ab("+x1+","+y1+","+x2+","+y2+")   ===> "+w+"x"+h
	addbox x1*pzf_s,y1*pzf_s,w*pzf_s,h*pzf_s
End Function


' Time
Global tmHr,tmMn,tmSc,OldTime$


' Background
Global bckdeg:Double=0,bckspd:Double=.5
Global bckr,bckg,bckb
Global bckra[8],bckga[8],bckba[8]
Global bcki2:Timage
bckra[0]=255
bckga[1]=255
bckba[3]=255
bckra[4]=255
bckga[4]=255
bckba[5]=255
bckga[5]=255
bckra[6]=255
bckba[6]=255
bckra[7]=255
bckga[7]=255
bckba[7]=255

Global bckc=Rand(0,7)
bckr=255
bckg=255
bckb=255
Global bcki:TImage = LoadImage("incbin::Background.png")
If Not bcki Print "WARNING: BACKGROUND NOT LOADED!!"


