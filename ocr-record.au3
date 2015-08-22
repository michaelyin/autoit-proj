#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <Constants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
;#include <wait.au3>

Func readTxt()
	Local $sData = ClipGet()

    ; Display the data returned by ClipGet.
    SplashTextOn("Title", $sData, -1, -1, -1, -1, $DLG_TEXTLEFT, "", 24)
    Sleep(2000)
    SplashOff()

	Return $sData

EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
    WinWait($title,$text,$timeout)
    If Not WinActive($title,$text) Then WinActivate($title,$text)
    WinWaitActive($title,$text,$timeout)
EndFunc

Func startOcr()
	; Display the current working directory.
    ;MsgBox($MB_SYSTEMMODAL, "", "The current working directory: " & @CRLF & @WorkingDir)
    ; Set the working directory C:\demo, where I put the HvwsDemo.exe
	FileChangeDir("C:\Applications\hanvon_2015_08_20_Demo")
    ; Display the working directory after setting it to the windows directory.
    ;MsgBox($MB_SYSTEMMODAL, "", "The current working directory: " & @CRLF & @WorkingDir)

   run("HvwsDemo.exe", "", @SW_MAXIMIZE)
EndFunc   ;==>Example

Opt("MouseCoordMode", 0)
AutoItSetOption("ExpandEnvStrings",1)
startOcr()
_WinWaitActivate("公式识别Demo", "")

Local $hWnd = WinActivate("公式识别Demo")

;clear result area
MouseMove(12,635)
MouseDown("left")
MouseUp("left")

; Select all data in field and delete selected text

Send("{CTRLDOWN}{CTRLUP}{CTRLDOWN}a{CTRLUP}{DEL}")

; clean clip board
ClipPut("process images ...")

;Run('C:\Users\Xuecheng\Documents\Hope_blackboard\hanvon_ocr\hanvon-equ-ocr-Demo\HvwsDemo.exe')
_WinWaitActivate("公式识别Demo","toolStrip1")
MouseClick("left",68,60,1)
_WinWaitActivate("Open","Namespace Tree Contr")
MouseClick("left",465,173,1)
MouseMove(1107,653)
MouseDown("left")
MouseMove(1105,651)
MouseUp("left")
#endregion --- Au3Recorder generated code End ---

$cnt = 0

While 1

    If $cnt >= 9 Then
		ExitLoop
	EndIf

	MouseMove(12,635)
	MouseDown("left")
	MouseUp("left")

	; Select all data in field and copy selected text
	Send("{CTRLDOWN}a{CTRLUP}")
	Send("{CTRLDOWN}c{CTRLUP}")

	Local $clip = readTxt()
	Local $iPos = StringInStr($clip, "code: Ok")

	If $iPos > 0 Then
		;MsgBox($MB_SYSTEMMODAL, "Example", "$iPos was positive!")
		ExitLoop
	EndIf

	Sleep(5000)
	$cnt = $cnt + 1

WEnd

$file = FileOpen("C:\Users\Xuecheng\result.txt",  258)

FileWrite($file, $clip)
FileClose($file)

WinClose($hWnd)








