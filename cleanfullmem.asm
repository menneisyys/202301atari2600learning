	include "vcs.h"
	include "macro.h"	

    processor 6502

    seg code
    org $F000       ; define the ROM code origin at $F000


Start:
	CLEAN_START ; this MUST be after "Start" or whatever declared at org $FFFC!!! Otherwise, the code won't ever be executed!
    ldx #$3E
;    stx COLUBK

Start2:
	stx COLUBK
	inx
	inx
	jmp Start2
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill  ROM size to exactly 4KB
; Also tells 6502 where our program should start (at $FFFC)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC       ; moves/jumps origin to ROM address $FFFC
    .word Start     ; puts 2 bytes at position $FFFC (where program starts)
    .word Start	    ; puts interrupt vector at position $FFFE (unused in VCS)
