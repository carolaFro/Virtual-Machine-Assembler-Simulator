"""
Assembler, parses the data on the given file to machine language
"""
import sys
sys.path.append("..")
from memory.Mem import *
from memory.isa import *

FLAG = False
offset = 0
class Assembler():
    """Assembler class with all needed methods"""
    def __init__(self, file_name):
        """init method"""
        self.file_name = file_name
        self.isa = ISA()
        self.sym_table = {}
        tokens = self.first_pass(file_name)
        self.file_name = open(file_name.replace('.asm', '.bin'), 'wb+')
        self.size = self.size + 1024
        byte_code = mmap.mmap(self.file_name.fileno(), length=self.size)
        self.mem = Memory(self.sym_table, byte_code, self.isa)
        self.mem.byte_code.flush()
        self.second_pass(tokens)

    def get_mem(self):
        """returns mmap memory"""
        return self.mem

    def first_pass(self, file_name):
        """The first pass reads the file and creates sym_tab with all labels"""
        token_lines = parse(file_name)
        global offset
        for i in range(len(token_lines)):
            inner = token_lines[i]
            if offset == 0:
                offset = 4
            if inner[0] in self.isa.instructions:
                offset = offset + 12
            elif inner[0] not in self.isa.instructions:
                if ".BYT" in inner:
                    if is_label(inner[0]):
                        self.sym_table[inner[0]] = offset
                    offset = offset + 1
                elif ".INT" in inner:
                    if is_label(inner[0]):
                        self.sym_table[inner[0]] = offset
                    offset = offset + 4
                elif inner[1] in self.isa.instructions:
                    self.sym_table[inner[0]] = offset
                    offset = offset + 12
            else:
                raise Exception(f"Instruction not supported or not recognized {inner[0]}")
        self.size = offset
        write_dic(self.sym_table)
        return token_lines

    def second_pass(self, tokens):
        """The Second pass reads the file again and the dictionary to generate bytecode"""
        global FLAG
        self.mem.offset = 4
        for current_set in tokens:
            if ".BYT" in current_set:
                self.mem.writeByte(current_set)
                self.mem.offset = self.mem.offset + 1
            elif ".INT" in current_set:
                self.mem.writeInt(current_set)
                self.mem.offset = self.mem.offset + 4
            elif current_set[1] in self.isa.instructions:
                self.mem.writeOp(current_set[1:])
            elif current_set[0] in self.isa.instructions:
                if FLAG is False:
                        self.mem.pc = self.mem.offset #first line of code
                        self.mem.writeInt(self.mem.pc)
                        FLAG = True
                self.mem.writeOp(current_set)
            elif current_set[0] not in self.mem.sym_table and \
                current_set[0] not in self.isa.instructions:
                raise Exception(f"This token is not in SymTab nor in ISA: {current_set[0]}")
        stack = self.isa.registers
        self.isa.reg[stack["SL"]] = self.mem.offset + 1 #Stack limit register
        self.isa.reg[stack["SB"]] = self.size - 1
        self.isa.reg[stack["SP"]] = self.isa.reg[stack["SB"]] - 4
        self.isa.reg[stack["FP"]] = 0

def parse(file_name):
    """Parse, reads each line of the file and returns a list of list with each line tokenized"""
    tokens = []
    with open(file_name, "r", encoding="utf-8") as file:
        for line in file.read().split('\n'):
            if len(line) == 0:
                continue
            if ';' in line:
                line = line[0 : line.index(';')]
                if len(line) == 0:
                    continue

            if ',' in line and not '.BYT' in line:
                line = line.replace(',', '')

            if '#' in line:
                line = line.replace('#', '')

            token_list = line.strip()
            token_list = token_list.split()

            if len(token_list) == 0:
                continue
            tokens.append(token_list)

        return tokens

def write_dic(sym_tab):
    """Creates a file to visualize the symbol table"""
    with open('asm/symtab.csv', 'w') as dictionary:
        for key in sym_tab.keys():
            dictionary.write(f"{key},{sym_tab[key]}\n")

def is_label(token):
    if token == ".BYT" or token == ".INT":
        return False
    else:
        return True
