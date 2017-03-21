Strict


Framework     jcr6.zlibdriver
?win32
Import        BRL.DirectSoundAudio
Import        BRL.OpenALAudio
?Not win32
Import        BRL.FreeAudioAudio
?


Import        brl.glmax2d
Import        brl.freetypefont
Import        brl.pngloader
Import        brl.oggloader
Import        "icon/icon.o"
Import        "GameImp/main.bmx"


'incbin
Import        "gameimp/fonts/whiterabbit/whiterabbit.bmx"
'Import        "gameimp/Pix/Pix.h.bmx"
'Import        "gameimp/Audio/Audio.h.bmx"

init
GoMain
