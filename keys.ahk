RunOrRaise(class, run) {
	if WinActive(class) {
		WinMinimize, %class%
	}
	else if WinExist(class) {
		WinActivate, %class%
	}
	else {
		Run, %run%
	}
}

ToggleMax() {
	WinGet MX, MinMax, A
	if MX
		WinRestore A
	else
		WinMaximize A
}

AltTab(){
    list := ""
    WinGet, id, list
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinActive, ahk_id %this_ID%
            continue
        WinGetTitle, title, ahk_id %this_ID%
        If (title = "")
            continue
        If (!IsWindow(WinExist("ahk_id" . this_ID)))
            continue
        WinActivate, ahk_id %this_ID%, ,2
            break
    }
}

;-----------------------------------------------------------------
; Check whether the target window is activation target
;-----------------------------------------------------------------
IsWindow(hWnd){
    WinGet, dwStyle, Style, ahk_id %hWnd%
    if ((dwStyle&0x08000000) || !(dwStyle&0x10000000)) {
        return false
    }
    WinGet, dwExStyle, ExStyle, ahk_id %hWnd%
    if (dwExStyle & 0x00000080) {
        return false
    }
    WinGetClass, szClass, ahk_id %hWnd%
    if (szClass = "TApplication") {
        return false
    }
    return true
}

CapsLock::Control
#q::WinClose, A
#Enter::Run, "wt"

f1::RunOrRaise("ahk_class CASCADIA_HOSTING_WINDOW_CLASS", "wt")
f2::RunOrRaise("ahk_class MozillaWindowClass", "firefox.exe")
f3::RunOrRaise("ahk_class SUMATRA_PDF_FRAME", "SumatraPDF.exe")
;; f4::Send !{TAB}

#k::#Up
#j::#Down
#h::#Left
;; #l::#Right
;; win+l is lockscreen :/

#f::ToggleMax()

!r::Reload

f4:: AltTab()
