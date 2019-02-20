proc part {ref value footprint} {
  puts "    (comp (ref $ref) (value $value) (footprint modules:$footprint))"
}

proc wire {code name args} {
  puts "    (net (code $code) (name $name)"
  foreach pin $args {
    puts "      (node (ref [lindex $pin 0]) (pin [lindex $pin 1]))"
  }
  puts "    )"
}

puts "(export (version D)"
puts "  (components"

part R1 2 0805
part R2 1M 0805

part C1 10u 0805
part C2 22u 0805
part C3 1u 0805

part IC1 TPS61200 DRC
part IC2 PIC10F320 MC

part L1 2.2u XFL4020

part MCLR MCLR PAD-1.0mm
part PCLK PCLK PAD-1.0mm
part PDAT PDAT PAD-1.0mm
part VDD VDD PAD-1.0mm

part + +LED PAD-1.5mm
part - LED- PAD-1.5mm

part PIN1 PIN PIN-1.0mm
part PIN2 PIN PIN-1.0mm

for {set i 1} {$i <= 9} {incr i} {
  part VIA$i VIA VIA-0.6mm
}

puts "  )"
puts "  (nets"

wire 0 GND {C1 2} {C2 2} {C3 2} {IC1 11} {IC1 4} {IC1 9} {IC2 7} {IC2 9} {PIN1 1} {PIN2 1} {R1 2} {R2 1} {VIA4 1} {VIA5 1} {VIA6 1} {VIA7 1} {VIA8 1} {VIA9 1}
wire 1 N1 {IC1 3} {L1 2}
wire 2 N2 {+ 1} {C2 1} {IC1 2}
wire 3 N3 {C3 1} {IC1 1} {IC2 2} {R2 2} {VDD 1}
wire 4 N4 {IC1 7} {IC2 4} {PCLK 1}
wire 5 N5 {- 1} {IC1 10} {R1 1}
wire 6 N6 {IC2 5} {PDAT 1}
wire 7 N7 {IC2 8} {MCLR 1}
wire 8 SUPPLY {C1 1} {IC1 5} {IC1 6} {IC1 8} {IC2 3} {L1 1} {VIA1 1} {VIA2 1} {VIA3 1}

puts "  )"
puts ")"
