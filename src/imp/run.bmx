Strict
Import "globals.bmx"

Print "Localizing as: "+lang
SetLocalizationMode LOCALIZATION_ON 
SetLocalizationLanguage  L(lang)

Private
	Global eid,esource:Tgadget,cb:tcallback
	Repeat
		If currentflow currentflow
		PollEvent
		eid = EventID()
		esource = tgadget(EventSource())
		If esource
			cb = GetCallback(esource)
			?debug
			If eid
				Print "id = "+eid
				Print "gadget_action = "+event_gadgetaction
			EndIf
			?	
			Select eid
				Case event_gadgetaction	cb.action esource
				Case event_windowclose	cb.close esource
			End Select
		EndIf
	Forever

