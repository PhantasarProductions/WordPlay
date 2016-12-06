Strict
Import "globals.bmx"

Print "Localizing as: "+lang
SetLocalizationMode LOCALIZATION_ON 
SetLocalizationLanguage  L(lang)

Repeat
	PollEvent
Forever

