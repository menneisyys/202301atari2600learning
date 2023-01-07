	include "vcs.h"
	include "macro.h"	

    processor 6502

    seg code
    org $F000       ; define the ROM code origin at $F000


Start:
	CLEAN_START

    lda #12         
	sta COLUBK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill  ROM size to exactly 4KB
; Also tells 6502 where our program should start (at $FFFC)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC       ; moves/jumps origin to ROM address $FFFC
    .word Start     ; puts 2 bytes at position $FFFC (where program starts)
    .word Start	    ; puts interrupt vector at position $FFFE (unused in VCS)
