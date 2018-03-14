define low $00; ;low byte
define high $01; ;high byte

LDA #$00
STA low
LDA #$02
STA high
LDA #$06

 JSR init ;jumps subroutine
 JSR background
 JSR initH
 JSR init1
 JSR vertLow1
 JSR init2
 JSR vertLow1
 JSR end


init: ;goes back to JSR
  LDX #$00
  RTS

background: ;fills up the background
  STA $0200, X
  STA $0300, X
  STA $0400, X
  STA $0500, X
  CPX #$FF
  INX
  BNE background

initHorizontal: ;initialing for the horizontal lines
  LDX #$00
  LDA #$07

horizontal: ;uses loops to fill the horizontal lines
  STA $0340, X
  STA $04A0, X
  INX ;increments x
  CPX #$20 ;compares x register
  BNE horizontal ;branches if not equal

init1: ;iniatilizing for the vertical line
  LDA #$0A
  STA low
  LDA #$02
  STA high

draw1: ;draw function to draw the vertical lines using indirect
  LDA #$07
  LDY #$00
  STA (low),Y
  JMP vertLow1 ;jumps to vertlow1

vertLow1:
  LDA low ;load low byte
  CLC ;clear carry flag
  ADC #$20 ;add with carry
  STA low ;stores low byte in a register
  BCS vertHigh1 ;branch when carry flag is set
  JMP draw1 ;jumps to draw

vertHigh1:
  LDA high ;load high byte
  ADC $02 ;add with carry
  STA high ;stores high byte in a register
  TAX ;transfers accumalator to x
  CPX #$06 ;compares x register
  BNE draw1 ;branches if not equal
  JMP init2 ;jumps to init2

init2: ;initializes for the second vertical line
  LDA #$15
  STA low
  LDA #$02
  STA high

draw2:
  LDA #$07
  LDY #$00
  STA (low),Y
  JMP vertLow2

vertLow2:
  LDA low ;loads low byte
  CLC ;clears carry flag for the high byte
  ADC #$20 ;add with carry
  STA low ;stores lows byte
  BCS vertHigh2 ;branches when carry flag set
  JMP draw2

vertHigh2:
  LDA high ;load high byte
  ADC $02 ;add with carry
  STA high ;stores high byte
  TAY ;tranfers accumaltor to y
  CPY #$06 ;compares y register
  BNE draw2 ;branches if not equal
  JMP end ;jumps to end

end: ;ends the code
  BRK
