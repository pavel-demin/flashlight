from skidl import *

u1 = Part('parts', 'TPS61200', footprint = 'modules:DRC')
u2 = Part('parts', 'PIC10F320', footprint = 'modules:MC')

r1 = Part('parts', 'R', value = '2', footprint = 'modules:0805')
r2 = Part('parts', 'R', value = '10k', footprint = 'modules:0805')

c1 = Part('parts', 'C', value = '10u', footprint = 'modules:0805')
c2 = Part('parts', 'C', value = '22u', footprint = 'modules:0805')
c3 = Part('parts', 'C', value = '1u', footprint = 'modules:0805')

l1 = Part('parts', 'L', value = '2.2u', footprint = 'modules:XFL4020')

vdd = Part('parts', 'PAD', ref = 'VDD', value = 'VDD', footprint = 'modules:PAD-1.0mm')
vss = Part('parts', 'PAD', ref = 'VSS', value = 'VSS', footprint = 'modules:PAD-1.0mm')
clk = Part('parts', 'PAD', ref = 'CLK', value = 'PCLK', footprint = 'modules:PAD-1.0mm')
dat = Part('parts', 'PAD', ref = 'DAT', value = 'PDAT', footprint = 'modules:PAD-1.0mm')
clr = Part('parts', 'PAD', ref = 'CLR', value = 'MCLR', footprint = 'modules:PAD-1.0mm')

ledp = Part('parts', 'PAD', ref = '+', value = '+LED', footprint = 'modules:PAD-1.5mm')
ledn = Part('parts', 'PAD', ref = '-', value = 'LED-', footprint = 'modules:PAD-1.5mm')

vias_supply = 3 * Part('parts', 'VIA', footprint = 'modules:VIA-0.6mm', dest = TEMPLATE)
vias_gnd = 9 * Part('parts', 'VIA', footprint = 'modules:VIA-0.6mm', dest = TEMPLATE)

supply = Net('SUPPLY')
gnd = Net('GND')
nets = 7 * Net()

u1[:] += NC
u2[:] += NC
supply += c1[1], l1[1], u1[5, 6, 8]
gnd += c1[2], c2[2], c3[2], u1[4, 9, 11], r1[2], u2[1, 7, 9], vss[1]
nets[0] += l1[2], u1[3]
nets[1] += u1[2], c2[1], ledp[1]
nets[2] += u1[1], c3[1], u2[2], r2[2], vdd[1]
nets[3] += u1[7], r2[1], u2[4], clk[1]
nets[4] += u1[10], r1[1], ledn[1]
nets[5] += u2[5], dat[1]
nets[6] += u2[8], clr[1]

for via in vias_supply: supply += via[1]
for via in vias_gnd: gnd += via[1]

generate_netlist()