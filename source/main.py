"""Main Module"""
import os
import sys
import mmap
import traceback
from vm.Assembler import Assembler
from vm.VirtualMachine import VirtualMachine
sys.path.append("..")
from memory.Mem import *
#import time

def main():
    """This is my main function, runs vm and assembler"""
    try:
        if len(sys.argv) >= 2:
            if os.path.isfile(sys.argv[1]):
                print(f"Usage: python main.py {sys.argv[1]} found\n")
            else:
                print(f"Usage: python main.py file {sys.argv[1]} not found\n")
                return 1 #exit(1) #no execution without filename
        elif len(sys.argv) == 1:
            print("Usage: python main.py No arguments provided\n")
            return 3

        file_name = sys.argv[1]
        size = os.path.getsize(file_name)
        #st = time.time()
        if file_name.endswith("asm"):
            assm = Assembler(file_name)
            VirtualMachine(assm.get_mem(), file_name, assm.size)
        elif file_name.endswith("bin"):
            with open(file_name, "r+b") as file:
                mm = mmap.mmap(file.fileno(), size, access=mmap.ACCESS_DEFAULT)
                VirtualMachine(Memory(0, mm, ISA()), file_name, size)
                mm.close()
        else:
            print(f"Usage: python main.py the file provided is not and .asm file nor .bin file: {file_name}\n")
            return 2 #the file has an unreconized file extension
    except:
        print(f"Something Happened: {sys.exc_info()[1]}")
        print(traceback.format_exc())
        return 4
    #print("\n\nTime: %s" % (time.time() - st))
    return 0

if __name__ == '__main__':
    main()
