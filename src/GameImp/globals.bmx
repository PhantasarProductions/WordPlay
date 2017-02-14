strict
Import brl.max2d
Import tricky_units.Dirry
Import jcr6.jcr6main
Import tricky_units.StringMap
Import tricky_units.Listfile
Import Tricky_Units.Rectangles

Global swapdir$ = Dirry("$AppSupport$/WordPlay/")
Global defaultpuzzle$ = Swapdir+"Generatedpuzzle"

Global PuzData:StringMap
Global puzletters:Byte[,]
Global puzwordslist:TList,puzwords$[]
Global puzsolved:TList

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