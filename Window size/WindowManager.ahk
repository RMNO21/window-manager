#NoTrayIcon  ; <-- ADD THIS LINE to hide the system tray icon

#NoEnv
#SingleInstance Force
#Persistent
SetWinDelay, 0
CoordMode, Mouse, Screen

; ==============================================================================
; USER CUSTOMIZATION SECTION
; ==============================================================================

; --- 90% AUTO-MAXIMIZE RULE ---
MaxThreshold := 0.90

; --- RESTORE BUTTON BEHAVIOR ---
RestoreSizePercent := 0.50 

; --- ANIMATION SMOOTHNESS ---
AnimationSteps := 10  
AnimationSpeed := 10  

; ==============================================================================
; GLOBAL STATE VARIABLES (DO NOT CHANGE)
; ==============================================================================
global LastID := 0
global LastWasMaximized := false

; Run the check every 100ms
SetTimer, CheckWindow, 100
return

; ==============================================================================
; MAIN LOOP
; ==============================================================================
CheckWindow:
    ; 1. Get Active Window Info
    WinGet, currentID, ID, A
    
    ; Skip if no window (desktop/start menu)
    if (currentID = "")
        return

    ; Get Current State: 1=Maximized, 0=Normal, -1=Minimized
    WinGet, currentState, MinMax, ahk_id %currentID%

    ; LOGIC A: HANDLE RESTORE BUTTON CLICK (Must be Custom % Centered & Smooth)
    if (currentID = LastID 
        && LastWasMaximized = true 
        && currentState = 0 
        && !GetKeyState("LButton", "P"))
    {
        WinGetPos, StartX, StartY, StartW, StartH, ahk_id %currentID%
        CalculateTarget_Centered(currentID, TargetX, TargetY, TargetW, TargetH)
        AnimateWindow(currentID, StartX, StartY, StartW, StartH, TargetX, TargetY, TargetW, TargetH)
    }

    ; LOGIC B: HANDLE CUSTOM % AUTO-MAXIMIZE
    else if (currentState = 0 && !GetKeyState("LButton", "P"))
    {
        WinGetPos, cX, cY, cW, cH, ahk_id %currentID%
        GetWorkArea(currentID, monLeft, monTop, monWidth, monHeight)
        
        if (cW >= (monWidth * MaxThreshold) && cH >= (monHeight * MaxThreshold)) {
            WinMaximize, ahk_id %currentID%
        }
    }

    LastID := currentID
    LastWasMaximized := (currentState = 1)
return

; ==============================================================================
; ANIMATION AND HELPER FUNCTIONS
; (Omitted for brevity, but you should use the functions from the previous response)
; ==============================================================================

AnimateWindow(hwnd, StartX, StartY, StartW, StartH, EndX, EndY, EndW, EndH) {
    global AnimationSteps, AnimationSpeed
    
    DX := EndX - StartX
    DY := EndY - StartY
    DW := EndW - StartW
    DH := EndH - StartH
    
    Loop, %AnimationSteps% 
    {
        i := A_Index
        CurX := StartX + (DX * i / AnimationSteps)
        CurY := StartY + (DY * i / AnimationSteps)
        CurW := StartW + (DW * i / AnimationSteps)
        CurH := StartH + (DH * i / AnimationSteps)
        
        WinMove, ahk_id %hwnd%,, %CurX%, %CurY%, %CurW%, %CurH%
        Sleep, %AnimationSpeed%
    }
    WinMove, ahk_id %hwnd%,, %EndX%, %EndY%, %EndW%, %EndH%
}

CalculateTarget_Centered(hwnd, ByRef TargetX, ByRef TargetY, ByRef TargetW, ByRef TargetH) {
    global RestoreSizePercent
    
    GetWorkArea(hwnd, mL, mT, mW, mH)
    
    TargetW := mW * RestoreSizePercent
    TargetH := mH * RestoreSizePercent
    
    TargetX := mL + (mW - TargetW) / 2
    TargetY := mT + (mH - TargetH) / 2
}

GetWorkArea(hwnd, ByRef Left, ByRef Top, ByRef Width, ByRef Height) {
    WinGetPos, wX, wY, wW, wH, ahk_id %hwnd%
    midX := wX + (wW / 2)
    midY := wY + (wH / 2)
    
    SysGet, count, MonitorCount
    Loop, %count%
    {
        SysGet, m, Monitor, %A_Index%
        if (midX >= mLeft && midX <= mRight && midY >= mTop && midY <= mBottom) {
            SysGet, wa, MonitorWorkArea, %A_Index%
            Left := waLeft
            Top := waTop
            Width := waRight - waLeft
            Height := waBottom - waTop
            return
        }
    }
    SysGet, wa, MonitorWorkArea, 1
    Left := waLeft
    Top := waTop
    Width := waRight - waLeft
    Height := waBottom - waTop
}