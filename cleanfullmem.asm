	include "vcs.h"
	include "macro.h"	

    processor 6502

    seg code
    org $F000       ; define the ROM code origin at $F000


Start:
	CLEAN_START

    lda #12         
	sta COLUBK
	
;	SLEEP 10000 ; error: segment: code fffc                    vs current org: 10396 - Aborting assembly - cleanfullmem.asm (27): error: Origin Reverse-indexed.
;SLEEP ; no error?!?
;SLEEP 0 ; cleanfullmem.asm (18): error: Unknown Mnemonic '0'.
;SLEEP 1 ; error: Unknown Mnemonic '1'.
;	SLEEP 1 ; with a prefixing indentation / tab, unlike before: 'MACRO ERROR: 'SLEEP': Duration must be > 1'
	SLEEP 2 ; works!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill  ROM size to exactly 4KB
; Also tells 6502 where our program should start (at $FFFC)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC       ; moves/jumps origin to ROM address $FFFC
    .word Start     ; puts 2 bytes at position $FFFC (where program starts)
    .word Start	    ; puts interrupt vector at position $FFFE (unused in VCS)
