
	processor 6502
	include "vcs.h"
	include "macro.h"

	org  $f000

; Now we're going to drive the TV signal properly.
; Assuming NTSC standards, we need the following:
; - 3 scanlines of VSYNC
; - 37 blank lines
; - 192 visible scanlines
; - 30 blank lines

; We'll use the VSYNC register to generate the VSYNC signal,
; and the VBLANK register to force a blank screen above
; and below the visible frame (it'll look letterboxed on
; the emulator, but not on a real TV)


globalVarForSlowerScrollingStartVal: .byte 3

; Let's define a variable to hold the starting color
; at memory address $81
BGColor	equ $81
globalVarForSlowerScrolling equ $82
BGColorBACKUP	equ $83 ; added this to save the current BGColor before in-visible-scanline-area hacking but don't use it ATM as I just add/sub a KNOWN const literal so I don't need to save / restore the previous value

; The CLEAN_START macro zeroes RAM and registers
Start	CLEAN_START
	lda globalVarForSlowerScrollingStartVal
    sta globalVarForSlowerScrolling
        
NextFrame
; Enable VBLANK (disable output)
	lda #2
        sta VBLANK
; At the beginning of the frame we set the VSYNC bit...
	lda #2
	sta VSYNC
; And hold it on for 3 scanlines...
	sta WSYNC
	sta WSYNC
	sta WSYNC
; Now we turn VSYNC off.
	lda #0
	sta VSYNC

; Now we need 37 lines of VBLANK...
	ldx #37
LVBlank	sta WSYNC	; accessing WSYNC stops the CPU until next scanline
	dex		; decrement X
	bne LVBlank	; loop until X == 0

; Re-enable output (disable VBLANK)
	lda #0
        sta VBLANK
; 192 scanlines are visible
; We'll draw some rainbows
	ldx #192
	lda BGColor	; load the background color out of RAM
ScanLoop
; comment the following 'adc' out if not want verically different colors but just two one-color blocks:
 	;adc #1		; add 1 to the current background color in A 
	sta COLUBK	; set the background color
	
	; 8 nop's: at about 20% will there be the start of the new colors; with twice as many: about 40% etc. And with no nop's at all, nothing
	nop
		nop
			nop
				nop
					nop
						nop
							nop
								nop
	
		
	adc #7 		; change bgcolor to +7 so that the change is clearly visible (1 can be less visible as in most cases it's only an intensity change if at all)
	sta COLUBK
	
	sta WSYNC	; WSYNC doesn't care what value is stored
	sbc #7 		; resetting *substracting)  the previously added 7 from the acc
	
	dex
	bne ScanLoop

; Enable VBLANK again
	lda #2
        sta VBLANK
; 30 lines of overscan to complete the frame
	ldx #30
LVOver	sta WSYNC
	dex
	bne LVOver
	
; The next frame will start with current color value - 1
; to get a downwards scrolling effect
;	dec BGColor
        dec globalVarForSlowerScrolling
        bne NextFrame 		; still not reached 0 - do NOT change the color yet!
        ; currently FULLY disabled everything color cycling animation here as I just want to see how I can start displaying something else INSIDE a scanline by changing the bg color
;        dec BGColor 		; now we can change the color
        lda globalVarForSlowerScrollingStartVal			; reinit globalVarForSlowerScrolling
        sta globalVarForSlowerScrolling

; Go back and do another frame
	jmp NextFrame
	
	org $fffc
	.word Start
	.word Start
