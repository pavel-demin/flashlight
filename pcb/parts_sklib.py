from skidl import Pin, Part, SchLib, SKIDL, TEMPLATE

SKIDL_lib_version = '0.0.1'

parts = SchLib(tool=SKIDL).add_parts(*[
    Part(name='TPS61200',dest=TEMPLATE,tool=SKIDL,ref_prefix='IC',num_units=1,do_erc=True,footprint='modules:DRC',pins=[
        Pin(num='1',name='VAUX',func=Pin.PWROUT,do_erc=True),
        Pin(num='2',name='VOUT',func=Pin.PWROUT,do_erc=True),
        Pin(num='3',name='L',func=Pin.PWRIN,do_erc=True),
        Pin(num='4',name='PGND',func=Pin.PWROUT,do_erc=True),
        Pin(num='5',name='VIN',func=Pin.PWRIN,do_erc=True),
        Pin(num='6',name='EN',do_erc=True),
        Pin(num='7',name='UVLO',do_erc=True),
        Pin(num='8',name='PS',do_erc=True),
        Pin(num='9',name='GND',func=Pin.PWROUT,do_erc=True),
        Pin(num='10',name='FB',do_erc=True),
        Pin(num='11',name='PAD',func=Pin.PWROUT,do_erc=True)]),
    Part(name='PIC10F320',dest=TEMPLATE,tool=SKIDL,ref_prefix='IC',num_units=1,do_erc=True,footprint='modules:MC',pins=[
        Pin(num='1',name='NC',func=Pin.NOCONNECT,do_erc=True),
        Pin(num='2',name='VDD',func=Pin.PWRIN,do_erc=True),
        Pin(num='3',name='RA2',func=Pin.BIDIR,do_erc=True),
        Pin(num='4',name='RA1',func=Pin.BIDIR,do_erc=True),
        Pin(num='5',name='RA0',func=Pin.BIDIR,do_erc=True),
        Pin(num='6',name='NC',func=Pin.NOCONNECT,do_erc=True),
        Pin(num='7',name='VSS',func=Pin.PWROUT,do_erc=True),
        Pin(num='8',name='RA3',do_erc=True),
        Pin(num='9',name='PAD',func=Pin.PWROUT,do_erc=True)]),
    Part(name='R',dest=TEMPLATE,tool=SKIDL,ref_prefix='R',num_units=1,do_erc=True,footprint='modules:0805',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True),
        Pin(num='2',name='~',func=Pin.PASSIVE,do_erc=True)]),
    Part(name='C',dest=TEMPLATE,tool=SKIDL,ref_prefix='C',num_units=1,do_erc=True,footprint='modules:0805',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True),
        Pin(num='2',name='~',func=Pin.PASSIVE,do_erc=True)]),
    Part(name='L',dest=TEMPLATE,tool=SKIDL,ref_prefix='L',num_units=1,do_erc=True,footprint='modules:XFL4020',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True),
        Pin(num='2',name='~',func=Pin.PASSIVE,do_erc=True)]),
    Part(name='PAD',dest=TEMPLATE,tool=SKIDL,ref_prefix='PAD',num_units=1,do_erc=True,footprint='modules:PAD-1.0mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True)]),
    Part(name='VIA',dest=TEMPLATE,tool=SKIDL,ref_prefix='VIA',num_units=1,do_erc=True,footprint='modules:VIA-0.6mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True)]),
    Part(name='PIN',dest=TEMPLATE,tool=SKIDL,ref_prefix='PIN',num_units=1,do_erc=True,footprint='modules:PIN-1.0mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE,do_erc=True)])])
