#SingleInstance force
	
Version=1.5.3
fenster := "Öffnen"
inifile=ScannerApp.ini
ErweitertStatus=0
vorauswahl=%1%
;msgbox vorauswahl = -%vorauswahl%-

FileCreateDir, temp
FileInstall, scource\p2j.exe, temp\p2J.exe, 1
FileInstall, scource\J2P.exe, temp\J2P.exe, 1
Fileinstall, scource\ScannerApp.ini, temp\%inifile%, 1
FileInstall, scource\Scanner.jpg, temp\Scanner.jpg, 1 

IniRead, CountStartDate, temp\%inifile% , Datalogging, CountStartDate, Datum
IniRead, J2PCounter, temp\%inifile% , Datalogging, J2PCounter, leer
IniRead, P2JCounter, temp\%inifile% , Datalogging, P2JCounter, leer
IniRead, P2JCounterA, temp\%inifile% , Datalogging, P2JCounterA, leer
IniRead, J2PCounterJ, temp\%inifile% , Datalogging, J2PCounterJ, leer
IniRead, J2PCounterN, temp\%inifile% , Datalogging, J2PCounterN, leer
IniRead, J2PCounterA, temp\%inifile% , Datalogging, J2PCounterA, leer
if CountStartDate=Datum
	{
	FormatTime, Zeitstring, D1
	IniWrite, %Zeitstring%, temp\%inifile%, Datalogging, CountStartDate
	IniWrite, 0, temp\%inifile%, Datalogging, J2PCounter
	IniWrite, 0, temp\%inifile%, Datalogging, P2JCounter
	IniWrite, 0, temp\%inifile%, Datalogging, P2JCounterA
	IniWrite, 0, temp\%inifile%, Datalogging, J2PCounterJ
	IniWrite, 0, temp\%inifile%, Datalogging, J2PCounterN
	IniWrite, 0, temp\%inifile%, Datalogging, J2PCounterA
	IniRead, CountStartDate, temp\%inifile% , Datalogging, CountStartDate, Datum
	IniRead, J2PCounter, temp\%inifile% , Datalogging, J2PCounter, leer
	IniRead, P2JCounter, temp\%inifile% , Datalogging, P2JCounter, leer
	IniRead, P2JCounterA, temp\%inifile% , Datalogging, P2JCounterA, leer
	IniRead, J2PCounterJ, temp\%inifile% , Datalogging, J2PCounterJ, leer
	IniRead, J2PCounterN, temp\%inifile% , Datalogging, J2PCounterN, leer
	IniRead, J2PCounterA, temp\%inifile% , Datalogging, J2PCounterA, leer
;	msgbox, %inifile% wurde angelegt (AktuellerWert=%AktuellerWert%)
	}
IniRead, CountStartDate, temp\%inifile% , Datalogging, CountStartDate, Datum

IniRead, Tooltip, temp\%inifile%, ScannerAppSettings, Tooltip, 0

IniRead, FolderName1, temp\%inifile%, ScannerAppSettings, FolderDir1, iniError
IniRead, FolderName2, temp\%inifile%, ScannerAppSettings, FolderDir2, iniError
IniRead, FolderName3, temp\%inifile%, ScannerAppSettings, FolderDir3, iniError
IniRead, FolderName4, temp\%inifile%, ScannerAppSettings, FolderDir4, iniError
IniRead, FolderName5, temp\%inifile%, ScannerAppSettings, FolderDir5, iniError
IniRead, FolderName6, temp\%inifile%, ScannerAppSettings, FolderDir6, iniError
IniRead, FolderName7, temp\%inifile%, ScannerAppSettings, FolderDir7, iniError
IniRead, FolderName8, temp\%inifile%, ScannerAppSettings, FolderDir8, iniError
IniRead, FolderName9, temp\%inifile%, ScannerAppSettings, FolderDir9, iniError
IniRead, FolderName10, temp\%inifile%, ScannerAppSettings, FolderDir10, iniError

IniRead, TempPfad, temp\%inifile%, ScannerAppSettings, TempPfad , archiviert\
if vorauswahl < 1
	IniRead, vorauswahl, temp\%inifile%, ScannerAppSettings, vorauswahl , %vorauswahl%
;IniRead, vorauswahl, temp\%inifile%, ScannerAppSettings, vorauswahl , Choose1
IniRead, ReservierFile, temp\%inifile%, ScannerAppSettings, ReservierFile , reserviert.dat
ReservierFileVerz = %QuellLaufwerk%%ReservierFile%
IniRead, TicketverfallsZeitInMin, temp\%inifile%, ScannerAppSettings, TicketverfallsZeitInMin , 5
IniRead, SleepTime, temp\%inifile%, ScannerAppSettings, SleepTime , 100
Apptitle=Gescannte Dokumente

;#######
Gui, Add, Picture, x-4 y-4 w4000 h3000 , temp\Scanner.jpg
Gui, Add, Picture, x-56 y0 w590 h275 , temp\Scanner.jpg

Gui, Add, Button, x419 y50 gErweitert vErweitert, >>
Gui, Add, GroupBox, x481 y30 w200 h450, Erweitert
Gui, Add, Button, x500 y70 w163 h30 gP2J gArchivAnzeigen, Archiv anzeigen
Gui, Add, Button, x500 y120 w163 h30 gP2J gArchivLeeren, Archiv leeren
Gui, Add, Button, x500 y170 w163 h30 gP2J gZwischenablageWiederherstellen, Zwischenablage wiederherstellen

Gui, Add, Text,x500 y385 +BackgroundTrans , Counter:
Gui, Add, Text,x500 y405 vJ2PCounterText +BackgroundTrans cSilver, J2P:%J2PCounter%
Gui, Add, Text,x500 y425 vP2JCounterText +BackgroundTrans cSilver, P2J:%P2JCounter%
Gui, Add, Text,x500 y445 +BackgroundTrans cSilver vComputerNameAndNumber, Dieser Computer: %Computername% (%vorauswahl%)

Gui, Add, Combobox, x50 y192 w135 vPCAuswahl gAuswahlChange Choose%vorauswahl% , Daniel (ENWS05)|Schneider (ENWS11)|Scholz (ENWS12)|Server|Sandra (ENWS19)|Metze (ENWS18)|Abrechnung (ENWS01)|bagd51a6|Deborah (ENWS10)
Gui, Add, Text, x50 y223 w50, Dateiname:
Gui, Add, Combobox, x120 y223 w135 vFileNameGui Choose1 , %Computername%|VO - HG %A_YYYY%|VA z. KK - HG %A_YYYY%|z.KK - HG %A_YYYY%|Genehmigung|Unterl. mitg. - HG %A_YYYY%|KK bez. - HG %A_YYYY%|Auftragsbestätigung|Schweigepflichtentbindung|Archivierte Kartei|
Gui, Add, GroupBox, x310 y250 w115 h60, PDF zu Bild
Gui, Add, Button, x318 y270 w100 h30 gP2J, PDF zu JPG
Gui, Add, Button, x320 y215 w100 h30 gOrdner, Ordner
Gui, Add, Button, x53 y270 w100 h30 gAssistent vAssistentButton +Default, &Assistent

Gui, Add, Checkbox, x170 y275 vSplitPDF gSplitPDF +BackgroundTrans, &eine PDF pro Bild

;Gui, Add, Button, x170 y270 w100 h30 gDateienVorhanden, Dateien Vorhanden
;Gui, Add, Button, x170 y225 w100 h30 gArchivieren, Archivieren
Gui, Add, GroupBox, x46 y250 w230 h60, Bild zu PDF
Gui, Add, edit, x46 y320 w380 h160 vStatustext ReadOnly ClassStatustext,
Gui +OwnDialogs
GuiControl, Focus, Assistent
Gui, Show, h500 w481 xCenter y100, %Apptitle% %Version%
gosub Auswahl

ArchivAnzeigen:
;msgbox, archiv soll geöffnet werden
run %QuellLaufwerk%archiviert
GuiControlget, LogContent,, Statustext
GuiControl,, Statustext, %LogContent%Archivordner geöffnet (%QuellLaufwerk%Archiviert)`n
ControlSend, Edit2, ^{End}, 
return

ArchivLeeren:
SetBatchLines, -1  ; Führt die Operation mit maximaler Geschwindigkeit aus.
Ordnergroeße = 0
Loop, %QuellLaufwerk%archiviert\*.jpg, , 0
    Ordnergroeße += %A_LoopFileSize%
Loop, %QuellLaufwerk%archiviert\*.pdf, , 0
    Ordnergroeße += %A_LoopFileSize%
MB := ((Ordnergroeße/1024)/1024)
MsgBox, 4,, Soll das Archiv von "%selection%" wirklich gelöscht werden? `n(%MB% MB)
IfMsgBox Yes
	{
	filedelete, %QuellLaufwerk%archiviert\*.jpg
	filedelete, %QuellLaufwerk%archiviert\*.pdf
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Archivordner %selection% (%MB% MB) gelöscht`n
	ControlSend, Edit2, ^{End}, 
	}
else
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Archivordner %selection% (%MB% MB) nicht gelöscht`n
	ControlSend, Edit2, ^{End}, 
	}
return

ZwischenablageWiederherstellen:
msgbox, diese Funktion wird später noch hinzugefügt
return

GUI:
;########Euronetfehler fixen (überdeckt den öffnendialog)
GoSub, TOOLTIP
Loop
	{
	WinWait, %fenster%
	WinSet, AlwaysOnTop, toggle, %fenster%
	sleep 5000
	}
return
;###tooltips

SplitPDF:
gui, Submit, nohide
if SplitPDF = 1
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%SplitPDF aktiviert`n
	ControlSend, Edit2, ^{End}, 
	}
if SplitPDF = 0
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%SplitPDF wieder deaktiviert`n
	ControlSend, Edit2, ^{End}, 
	}
	;msgbox, SplitPDF = %SplitPDF%
; 1 oder 0
return

;#######ende tooltips
restart:
return

Erweitert:
if ErweitertStatus = 0
	{
	ErweitertStatus = 1
	Gui, Show, w701 , %Apptitle% %Version% - Erweitert
	}
else
	{
	ErweitertStatus = 0
	Gui, Show, w481 , %Apptitle% %Version%
	}

return

AuswahlChange:
GuiControlget, selection,, PCAuswahl
if (selection ="Daniel (ENWS05)")
	run %A_ScriptName% 1
else if (selection ="Schneider (ENWS11)")
	run %A_ScriptName% 2
else if (selection ="Scholz (ENWS12)")
	run %A_ScriptName% 3
else if (selection ="Server")
	run %A_ScriptName% 4
else	if (selection ="Sandra (ENWS19)")
	run %A_ScriptName% 5
else if (selection ="Metze (ENWS18)")
	run %A_ScriptName% 6
else if (selection ="Abrechnung (ENWS01)")
	run %A_ScriptName% 7
else	if (selection ="bagd51a6")
	run %A_ScriptName% 8
else if (selection ="Deborah (ENWS10)")
	run %A_ScriptName% 9
/*
else if (selection ="Leer")
	run %A_ScriptName% 10
*/
Exitapp
	return

	
	;Daniel (ENWS05)|Schneider (ENWS11)|Scholz (ENWS12)|Server|Sandra (ENWS19)|Metze (ENWS18)|Abrechnung (ENWS01)|bagd51a6|Deborah (ENWS10)
;#######
Auswahl:
GuiControlget, selection,, PCAuswahl
if (selection ="Daniel (ENWS05)")
    QuellLaufwerk=%FolderName1%
else if (selection ="Schneider (ENWS11)")
    QuellLaufwerk=%FolderName2%
else if (selection ="Scholz (ENWS12)")
    QuellLaufwerk=%FolderName3%
else if (selection ="Server")
    QuellLaufwerk=%FolderName4%
else if (selection ="Sandra (ENWS19)")
    QuellLaufwerk=%FolderName5%
else if (selection ="Metze (ENWS18)")
    QuellLaufwerk=%FolderName6%
else if (selection ="Abrechnung (ENWS01)")
    QuellLaufwerk=%FolderName7%
else if (selection ="bagd51a6")
    QuellLaufwerk=%FolderName8%
else if (selection ="Deborah (ENWS10)")
    QuellLaufwerk=%FolderName9%
/*
else if (selection ="Leer")
    QuellLaufwerk=%FolderName10%
*/
else
    QuellLaufwerk=%selection%\
goto GUI
;#######
Ordner:
run %QuellLaufwerk%
GuiControlget, LogContent,, Statustext
GuiControl,, Statustext, %LogContent%Ordner geöffnet (%QuellLaufwerk%)`n
ControlSend, Edit2, ^{End}, 
return
;goto GUI
;#######

;#######
P2J:
;Z?en
IniRead, P2JCounter, temp\%inifile% , Datalogging, P2JCounter, leer
P2JCounterAdd := ++P2JCounter
IniWrite, %P2JCounterAdd%, temp\%inifile%, Datalogging, P2JCounter
IniRead, P2JCounter, temp\%inifile% , Datalogging, P2JCounter, leer

FileSelectFile, AusgewaehlteDatei, 3,%QuellLaufwerk% , Datei öffnen, PDF-Dateien (*.pdf)
If AusgewaehlteDatei =
	{
	;Z?en
	IniRead, P2JCounterA, temp\%inifile% , Datalogging, P2JCounterA, leer
	P2JCounterAAdd := ++P2JCounterA
	IniWrite, %P2JCounterAAdd%, temp\%inifile%, Datalogging, P2JCounterA
	IniRead, P2JCounterA, temp\%inifile% , Datalogging, P2JCounterA, leer
	MsgBox,262144,, Dann eben nicht :-(
	}
Else
	{
    RunWait temp\p2j.exe "%AusgewaehlteDatei%"
	StringTrimRight, Bilderordner, AusgewaehlteDatei, 4
	FileMoveDir, %A_WorkingDir%\PDF_to_JPG_files, %Bilderordner%, 2
	if errorlevel
		{
		msgbox,262144, das hat nicht geklappt
		GuiControlget, LogContent,, Statustext
		GuiControl,, Statustext, %LogContent%PDF entpacken fehlgeschlagen`n
		ControlSend, Edit2, ^{End}, 
		}
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%PDF entpackt nach: %Bilderordner%`n
	ControlSend, Edit2, ^{End}, 
	run %Bilderordner%
	IniRead, P2JCounter, temp\%inifile%, ScannerAppSettings, P2JCounter,
	P2JCounterNeu := ++P2JCounter
	IniWrite, %P2JCounterNeu%, temp\%inifile%, ScannerAppSettings, P2JCounter
	IniRead, P2JCounter, temp\%inifile%, ScannerAppSettings, P2JCounter,
	}

return
;goto GUI
;#######

Assistent:
	GuiControlget, FileName,, FileNameGui
;gezaehlt
	IniRead, J2PCounter, temp\%inifile% , Datalogging, J2PCounter, leer
	J2PCounterAdd := ++J2PCounter
	IniWrite, %J2PCounterAdd%, temp\%inifile%, Datalogging, J2PCounter
	IniRead, J2PCounter, temp\%inifile% , Datalogging, J2PCounter, leer


MsgBox, 262147,Assistent, JA: Ich möchte die Dokumente jetzt scannen. `n`nNEIN: Ich habe die Dokumente versehentlich schon gescannt. (Es kann zu Fehlern kommen)`n
IfMsgBox NO
	{
	;Zählen
	IniRead, J2PCounterN, temp\%inifile% , Datalogging, J2PCounterN, leer
	J2PCounterNAdd := ++J2PCounterN
	IniWrite, %J2PCounterNAdd%, temp\%inifile%, Datalogging, J2PCounterN
	IniRead, J2PCounterN, temp\%inifile% , Datalogging, J2PCounterN, leer

    	gosub DateienVorhanden
	}
IfMsgBox YES
	{
	;Zählen
	IniRead, J2PCounterJ, temp\%inifile% , Datalogging, J2PCounterJ, leer
	J2PCounterJAdd := ++J2PCounterJ
	IniWrite, %J2PCounterJAdd%, temp\%inifile%, Datalogging, J2PCounterJ
	IniRead, J2PCounterJ, temp\%inifile% , Datalogging, J2PCounterJ, leer

	ReservierFileVerz = %QuellLaufwerk%%ReservierFile%
	if FileExist(ReservierFileVerz) 
		{
		IniRead, TickettextComputer , %ReservierFileVerz%,Ticketkäufer , Computer
		IniRead, TickettextDate , %ReservierFileVerz%,Ticketkäufer , Date
		Loop, %ReservierFileVerz%
			{ 
			  today = %A_Now% ; aktuelles Datum/Uhrzeit 
			  EnvSub, today, %A_LoopFileTimeModified%, Minutes ; Differenz 
			  If today > %TicketverfallsZeitInMin% ; ?er als 5 Minuten? 
			  { 
			    FileDelete, %A_LoopFileFullPath% ; Datei l??en 
			    ;Msgbox, 266240 , Ticket war vorhanden, Ein Ticket war vorhanden, wurde aber gelöscht, da es älter als %TicketverfallsZeitInMin% Minuten war. `n(Von %TickettextComputer%)
			    Gosub Assistent
			  } 
			}
		msgbox, 262149 , Scannordner noch belegt... , %TickettextComputer% hat sich vor %today% Minuten ein Scannticket reserviert. `nDies ist %TicketverfallsZeitInMin% Minuten gültig, wenn der Scannvorgang nicht schon vorher abgeschlossen ist. `nBitte Warten...
		IfMsgBox Retry
			    Gosub Assistent
			Else
			GuiControl,-Disabled, Assistent
			GuiControl,-Disabled, Dateien vorhanden
			GuiControl,-Disabled, PCAuswahl
			exit
		}
		GoSub restart
		Sleep %SleepTime%

		
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1


	FileMove, %QuellLaufwerk%*.bmp, %QuellLaufwerk%%TempPfad%, 1

	FileMove, %QuellLaufwerk%*.pdf, %QuellLaufwerk%%TempPfad%, 1
;hier wird reserviert.dat geschrieben
	IniWrite, %computername% , %QuellLaufwerk%%ReservierFile%,Ticketkäufer , Computer
	IniWrite, %A_Now% , %QuellLaufwerk%%ReservierFile%,Ticketkäufer , Date

	MsgBox,262144,, Jetzt bitte die gewünschten Dokumente einscannen.`nDann OK drücken.
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Folgende Dateien werden zusammengeführt`n
	ControlSend, Edit2, ^{End}, 


if SplitPDF = 1
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Folgende Dateien werden umgewandelt:`n
	Loop, %QuellLaufwerk%*.jpg
		{
		GuiControlget, LogContent,, Statustext
		GuiControl,, Statustext, %LogContent% %A_LoopFileName%`n --> %FileName%_%A_index%_%A_LoopFileName%.pdf`n`n
		ControlSend, Edit2, ^{End}, 
		Sleep, %SleepTime%
		If a_index = 100
			break
	GuiControlget, FileName,, FileNameGui
		RunWait temp\J2P.exe "%QuellLaufwerk%%FileName%_Datei%A_index%" "%QuellLaufwerk%%A_LoopFileName%"
		}
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Fertig! Pfad zu den PDF Dateien: %QuellLaufwerk%`n
	ControlSend, Edit2, ^{End}, 
	;FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	clipboard = %QuellLaufwerk%
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	FileDelete, %QuellLaufwerk%%ReservierFile%
	
	GuiControl,-Disabled, Assistent
	GuiControl,-Disabled, Dateien Vorhanden
	GuiControl,-Disabled, PCAuswahl
	
	}
Else
	{
	Loop, %QuellLaufwerk%*.jpg
		{
		    GuiControlget, LogContent,, Statustext
		    GuiControl,, Statustext, %LogContent% %A_LoopFileName%`n
		    ControlSend, Edit2, ^{End}, 
		    Sleep, %SleepTime%
		    If a_index = 100
		        break
		}
	GuiControlget, FileName,, FileNameGui
	RunWait temp\J2P.exe %QuellLaufwerk%%computername%.pdf %QuellLaufwerk%*.jpg
		FileMove, %QuellLaufwerk%%computername%.pdf, %QuellLaufwerk%%FileName%.pdf ,1
	clipboard = %QuellLaufwerk%%FileName%.pdf
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Fertig! Pfad zur PDF Datei: %QuellLaufwerk%%FileName%.pdf`n
	ControlSend, Edit2, ^{End}, 
	
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	FileDelete, %QuellLaufwerk%%ReservierFile%
	Sleep, %SleepTime%
	GuiControl,-Disabled, Assistent
	GuiControl,-Disabled, Dateien Vorhanden
	GuiControl,-Disabled, PCAuswahl
	}	
	

	
	;goto GuiClose
	;goto GUI
	return
	}
	else
	{
	;abbrechen
	;Z?en
	IniRead, J2PCounterA, temp\%inifile% , Datalogging, J2PCounterA, leer
	J2PCounterAAdd := ++J2PCounterA
	IniWrite, %J2PCounterAAdd%, temp\%inifile%, Datalogging, J2PCounterA
	IniRead, J2PCounterA, temp\%inifile% , Datalogging, J2PCounterA, leer
	
	return
	}
;#######
DateienVorhanden:
GuiControl,+Disabled, Assistent
GuiControl,+Disabled, Dateien Vorhanden
GuiControl,+Disabled, PCAuswahl
gosub DateienVorhanden3 ;??springe DateienVorhanden1
DateienVorhanden2:
GuiControl,-Disabled, Assistent
GuiControl,-Disabled, Dateien Vorhanden
GuiControl,-Disabled, PCAuswahl
DateienVorhanden3:
ReservierFileVerz = %QuellLaufwerk%%ReservierFile%
if FileExist(ReservierFileVerz) 
	{
	IniRead, TickettextComputer , %ReservierFileVerz%,Ticketkäufer , Computer
	IniRead, TickettextDate , %ReservierFileVerz%,Ticketkäufer , Date
	Loop, %ReservierFileVerz%
		{ 
		  today = %A_Now% ; aktuelles Datum/Uhrzeit 
		  EnvSub, today, %A_LoopFileTimeModified%, Minutes ; Differenz 
		  If today > %TicketverfallsZeitInMin% ; ?er als 5 Minuten? 
		  { 
		    FileDelete, %A_LoopFileFullPath% ; Datei l??en 
		    ;Msgbox,270336 , Ticket war vorhanden, Ein Ticket war vorhanden, wurde aber gelöscht, da es älter als %TicketverfallsZeitInMin% Minuten war. `n(Von %TickettextComputer%)
		    Gosub DateienVorhanden2
		  } 
		} 
	msgbox, 270341 , Scannordner noch belegt... , %TickettextComputer% hat sich vor %today% Minuten ein Scannticket reserviert. `nDies ist %TicketverfallsZeitInMin% Minuten gültig, wenn der Scannvorgang nicht schon vorher abgeschlossen ist. `nBitte Warten...
		IfMsgBox Retry
		    Gosub DateienVorhanden
		Else
		FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
		FileDelete, %QuellLaufwerk%%ReservierFile%
		GuiControl,-Disabled, Assistent
		GuiControl,-Disabled, Dateien Vorhanden
		GuiControl,-Disabled, PCAuswahl
		exit
	}
	
	
if SplitPDF = 1
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Folgende Dateien werden umgewandelt:`n
	Loop, %QuellLaufwerk%*.jpg
		{
			GuiControlget, LogContent,, Statustext
			GuiControl,, Statustext, %LogContent% %A_LoopFileName%`n --> %FileName%_%A_index%_%A_LoopFileName%.pdf`n`n
			ControlSend, Edit2, ^{End}, 
			Sleep, %SleepTime%
			If a_index = 100
				break
			RunWait temp\J2P.exe "%QuellLaufwerk%%FileName%_Datei%A_index%" "%QuellLaufwerk%%A_LoopFileName%"
		}
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Fertig! Pfad zu den PDF Dateien: %QuellLaufwerk%`n
	ControlSend, Edit2, ^{End}, 
	;FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	clipboard = %QuellLaufwerk%
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	FileDelete, %QuellLaufwerk%%ReservierFile%
	GuiControl,-Disabled, Assistent
	GuiControl,-Disabled, Dateien Vorhanden
	GuiControl,-Disabled, PCAuswahl
	}
else	
	{
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Folgende Dateien werden zusammengefügt`n
	Loop, %QuellLaufwerk%*.jpg
		{
			GuiControlget, LogContent,, Statustext
			GuiControl,, Statustext, %LogContent% %A_LoopFileName%`n
			ControlSend, Edit2, ^{End}, 
			Sleep, %SleepTime%
			If a_index = 100
				break
		}
	RunWait temp\J2P.exe %QuellLaufwerk%%Computername%.pdf %QuellLaufwerk%*.jpg
		FileMove, %QuellLaufwerk%%computername%.pdf, %QuellLaufwerk%%FileName%.pdf ,1
	GuiControlget, LogContent,, Statustext
	GuiControl,, Statustext, %LogContent%Fertig! Pfad zur PDF Datei: %QuellLaufwerk%%FileName%.pdf`n
	ControlSend, Edit2, ^{End}, 
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	clipboard = %QuellLaufwerk%%FileName%.pdf
	FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
	FileDelete, %QuellLaufwerk%%ReservierFile%
	GuiControl,-Disabled, Assistent
	GuiControl,-Disabled, Dateien Vorhanden
	GuiControl,-Disabled, PCAuswahl	
	}
	
	
	
	
	
	
	
	
;FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
;Gosub GuiClose
Gosub restart
;goto GUI
;#######
;#######
Archivieren:

ReservierFileVerz = %QuellLaufwerk%%ReservierFile%
if FileExist(ReservierFileVerz) 
	{
	IniRead, TickettextComputer , %ReservierFileVerz%,Ticketkäufer , Computer
	IniRead, TickettextDate , %ReservierFileVerz%,Ticketkäufer , Date
	Loop, %ReservierFileVerz%
		{ 
		  today = %A_Now% ; aktuelles Datum/Uhrzeit 
		  EnvSub, today, %A_LoopFileTimeModified%, Minutes ; Differenz 
		  If today > %TicketverfallsZeitInMin% ; ?er als 5 Minuten? 
		  { 
		    FileDelete, %A_LoopFileFullPath% ; Datei l??en 
		    ;Msgbox,4096 , Ticket war vorhanden, Ein Ticket war vorhanden, wurde aber gelöscht, da es älter als %TicketverfallsZeitInMin% Minuten war. `n(Von %TickettextComputer%)
		    Gosub Assistent
		  } 
		} 
	msgbox, 270341 , Scannordner noch belegt... , %TickettextComputer% hat sich vor %today% Minuten ein Scannticket reserviert. `nDies ist %TicketverfallsZeitInMin% Minuten gültig, wenn der Scannvorgang nicht schon vorher abgeschlossen ist. `nBitte Warten...
		IfMsgBox Retry
		    Gosub Assistent
		Else
		GuiControl,-Disabled, Assistent
		GuiControl,-Disabled, Dateien Vorhanden
		GuiControl,-Disabled, PCAuswahl
		exit
	}
GoSub restart

Sleep %SleepTime%

FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1

FileMove, %QuellLaufwerk%*.bmp, %QuellLaufwerk%%TempPfad%, 1


GuiControlget, LogContent,, Statustext
GuiControl,, Statustext, %LogContent%Archiviert!`n
ControlSend, Edit2, ^{End}, 

FileMove, %QuellLaufwerk%*.jpg, %QuellLaufwerk%%TempPfad%, 1
Sleep, %SleepTime%
GuiControl,-Disabled, Assistent
GuiControl,-Disabled, Dateien Vorhanden
GuiControl,-Disabled, PCAuswahl
;goto GuiClose
;goto GUI
return

;#######
GuiEscape:
GuiClose:
ButtonCancel:
ExitApp

;####Tooltipschnipsel2
TOOLTIP: ;The label for the function so the function can be called again.
; in this array for the first element define a tooltip message, for the second element the name of a control 
; the third element another tooltip message and the fourth element another name of control and so on
;  ***********       tooltip message,control's name

If tooltip = 1 ;Again, if tooltips are disabled, the tooltip value is 1. The only tooltip that shows with this array is the Enable Tooltips button tooltip.
{
   msg_control_array =
      ,click here to enable tooltips,tooltipoff
}
else ;I placed the original code below the else, so if tooltip doesn't equal 1 (the first time the script is run, and when tooltips are enabled) the script will function normally.
{
   msg_control_array =
     	,tip for text or picture,text1 ;By adding 0x100 and vtext1 to the Gui, Add, Text control options, that gui now shows this tooltip.
     	,Es wurde schon gescannt. Dateien werden danach archiviert,Dateien Vorhanden
     	,Der Zielordner wird geöffnet `n(%QuellLaufwerk%),Ordner
;     	,Es sollte noch nicht gescannt worden sein. Dateien werden danach archiviert,Assistent
     	,PDF wieder in Bilddateien umwandeln.`nZielverzichnis bitte dem Logfenster entnehmen,PDF zu JPG
	,Ordner in dem sich die Bilddateien befinden`n(siehe Scanner),PCAuswahl
	,Entfernt alle bisherigen Bilddateien aus dem Scannordner`nWie es der Assistent macht.`nDie Dateien befinden sich dann im Ordner archiviert,Archivieren
	,Wird z.B. bei mehseitigen Scanns für eVA oder eKVAs benötigt,SplitPDF
	,So oft wurde eine PDF-Datei erstellt,J2PCounterText
	,So viele PDF Dateien wurden wieder in Bilddateien umgewandelt,P2JCounterText
	,Computername und Positionsliste in dem Dropdownfeld,ComputerNameAndNumber
	,Hiermit starten,AssistentButton
	,Dieser Name wird ins Euronet DAS übernommen,FileNameGui
	
}   
OnMessage(0x200, "WM_MOUSEMOVE")
OnMessage(0x2a3, "WM_MOUSELEAVE")
return

WM_MOUSEMOVE(wParam, lParam)
{
   global gcontrol        ; in case I need this variable outside of the funtion
   gcontrol := A_GuiControl
   X := lParam & 0xFFFF      ;  in case I need the mouse X posicion
   Y := lParam >> 16         ;  in case I need the mouse Y posicion
   if gcontrol =
   {
   tooltip ; added this to remove tooltip when leaving controls
   return    ;  exit funtion if control = ""
   }
   global msg_control_array
   Loop, parse, msg_control_array, `,
   { 
   if gcontrol = %A_LoopField%
      {
      tooltip %msg%
      break
      } ; end if
   msg := A_LoopField
   } ; end loop 
   ; THE FOLLOWING 3 LINES ARE COMMENTED OUT FROM THE ORIGINAL SCRIPT SO THAT TOOLTIPS STAY VISIBLE AS LONG AS THE CURSOR IS ON THE CONTROL.
   ;  sleep 1200 ; increase this value if you want tooltip to be display longer
   ;  OnMessage(0x200, "")   ; disable OnMessage(0x200, "WM_MOUSEMOVE") so that the tooltip
   ;  tooltip                ; will appear only once while moving the mouse within the control
   ; I ADDED THESE TWO LINES SO THAT IF THE WINDOW LOSES FOCUS (ALT-TAB, or a popup) THE TOOLTIP DISAPPEARS.
   IfWinNotActive,%windowname%
   tooltip
}
;end function      

RETURN

button_click: ;this label is now separate from the the function so that clicking the buttons still work after adding the Disable Tooltips button.
msg_control_array = ;keeps the original array from overriding this tooltip ;This clears the array so that the clicked button tooltips will show.
If tooltip <> 1      ;If tooltips are NOT disabled, the following line shows the tooltip
tooltip You clicked on a button (button name=%gcontrol%)
sleep 1500
tooltip ;This clears the tooltip after showing for 1.5 seconds.
GoSub, TOOLTIP ; Reloads the function so all tooltips return to normal. This is why I put the function under it's own label.
RETURN
