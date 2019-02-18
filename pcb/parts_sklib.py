from skidl import Pin, Part, SchLib, SKIDL, TEMPLATE

SKIDL_lib_version = '0.0.1'

parts = SchLib(tool=SKIDL).add_parts(*[
    Part(name='TPS61200',dest=TEMPLATE,tool=SKIDL,ref_prefix='IC',num_units=1,footprint='modules:DRC',pins=[
        Pin(num='1',name='VAUX',func=Pin.PWROUT),
        Pin(num='2',name='VOUT',func=Pin.PWROUT),
        Pin(num='3',name='L',func=Pin.INPUT),
        Pin(num='4',name='PGND',func=Pin.PWRIN),
        Pin(num='5',name='VIN',func=Pin.PWRIN),
        Pin(num='6',name='EN',func=Pin.INPUT),
        Pin(num='7',name='UVLO',func=Pin.INPUT),
        Pin(num='8',name='PS',func=Pin.INPUT),
        Pin(num='9',name='GND',func=Pin.PWRIN),
        Pin(num='10',name='FB',func=Pin.INPUT),
        Pin(num='11',name='PAD',func=Pin.PWRIN)]),
    Part(name='PIC10F320',dest=TEMPLATE,tool=SKIDL,ref_prefix='IC',num_units=1,footprint='modules:MC',pins=[
        Pin(num='1',name='NC',func=Pin.NOCONNECT),
        Pin(num='2',name='VDD',func=Pin.PWRIN),
        Pin(num='3',name='RA2',func=Pin.BIDIR),
        Pin(num='4',name='RA1',func=Pin.BIDIR),
        Pin(num='5',name='RA0',func=Pin.BIDIR),
        Pin(num='6',name='NC',func=Pin.NOCONNECT),
        Pin(num='7',name='VSS',func=Pin.PWRIN),
        Pin(num='8',name='RA3',func=Pin.INPUT),
        Pin(num='9',name='PAD',func=Pin.PWRIN)]),
    Part(name='R',dest=TEMPLATE,tool=SKIDL,ref_prefix='R',num_units=1,footprint='modules:0805',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE),
        Pin(num='2',name='~',func=Pin.PASSIVE)]),
    Part(name='C',dest=TEMPLATE,tool=SKIDL,ref_prefix='C',num_units=1,footprint='modules:0805',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE),
        Pin(num='2',name='~',func=Pin.PASSIVE)]),
    Part(name='L',dest=TEMPLATE,tool=SKIDL,ref_prefix='L',num_units=1,footprint='modules:XFL4020',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE),
        Pin(num='2',name='~',func=Pin.PASSIVE)]),
    Part(name='PAD',dest=TEMPLATE,tool=SKIDL,ref_prefix='PAD',num_units=1,footprint='modules:PAD-1.0mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE)]),
    Part(name='VIA',dest=TEMPLATE,tool=SKIDL,ref_prefix='VIA',num_units=1,footprint='modules:VIA-0.6mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE)]),
    Part(name='PIN',dest=TEMPLATE,tool=SKIDL,ref_prefix='PIN',num_units=1,footprint='modules:PIN-1.0mm',pins=[
        Pin(num='1',name='~',func=Pin.PASSIVE)])])
