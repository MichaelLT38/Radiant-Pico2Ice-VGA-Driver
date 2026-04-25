from machine import Pin
import ice

fpga = ice.fpga(
    cdone=Pin(40),
    clock=Pin(21),
    creset=Pin(31),
    cram_cs=Pin(5),
    cram_mosi=Pin(4),
    cram_sck=Pin(6),
    frequency=48
)

file = open("Good_VGA_Pico2Ice_impl_3.bin", "br")  # last working was VGA_impl_3.bin
fpga.start()
fpga.cram(file)
file.close()

with open("test.txt", "w") as file:
    file.write("VGA Generator Started!\n")
    file.write("FPGA Clock Frequency: 12 MHz\n")