 LDA #$00 ;loads 0 in the A register
 LDX #$00 ;loads 0 in the a register
LOOP: ;loop so that you can fill in the top row
 STA $0200,X ;stores A into the memory and adds
 INX ;increments x
 TXA ;transfer x to a
 CPX #$20 ;compares till 32 spots are filled
 BNE LOOP ;if there is no flags add to new location
 BRK ;break flag
