proc part {ref footprint {value ""}} {
  puts "    (comp (ref $ref) (footprint modules:$footprint))"
}

proc wire {name args} {
  puts "    (net (name $name)"
  foreach element $args {
    set list [split $element /]
    puts "      (node (ref [lindex $list 0]) (pin [lindex $list 1]))"
  }
  puts "    )"
}

puts "(export (version D)"
puts "  (components"

part R1 0805 2
part R2 0805 1M

part C1 0805 10u
part C2 0805 22u
part C3 0805 1u

part IC1 DRC TPS61200
part IC2 MC PIC10F320

part L1 XFL4020 2.2u

part MCLR PAD-1.0mm
part PCLK PAD-1.0mm
part PDAT PAD-1.0mm
part VDD PAD-1.0mm

part + PAD-1.5mm
part - PAD-1.5mm

part PIN1 PIN-1.0mm
part PIN2 PIN-1.0mm

for {set i 1} {$i <= 9} {incr i} {
  part VIA$i VIA-0.6mm
}

puts "  )"
puts "  (nets"

wire SUPPLY C1/1 IC1/5 IC1/6 IC1/8 IC2/3 L1/1 VIA1/1 VIA2/1 VIA3/1
wire GND C1/2 C2/2 C3/2 IC1/11 IC1/4 IC1/9 IC2/7 IC2/9 PIN1/1 PIN2/1 R1/2 R2/1 VIA4/1 VIA5/1 VIA6/1 VIA7/1 VIA8/1 VIA9/1
wire N1 IC1/3 L1/2
wire N2 +/1 C2/1 IC1/2
wire N3 C3/1 IC1/1 IC2/2 R2/2 VDD/1
wire N4 IC1/7 IC2/4 PCLK/1
wire N5 -/1 IC1/10 R1/1
wire N6 IC2/5 PDAT/1
wire N7 IC2/8 MCLR/1

puts "  )"
puts ")"
