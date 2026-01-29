"""Memory manager"""
import sys
import mmap
sys.path.append("..")
from memory.isa import *

class Memory():
    """memory class"""
    def __init__(self, symtab, byte_code, isa):
        """Init method"""
        self.sym_table = symtab
        self.offset = 0
        self.pc = 0
        self.isa = isa
        self.byte_code = byte_code

    def writeByte(self, token):
        """Write byte into memory"""
        chars = get_token(token)
        if "'" in chars and '\\' not in chars:
            byt = chars.replace("'", '').strip().encode('utf-8')
            byt = int.from_bytes(byt, "little")
        elif '\\' in chars:
                byt = key_board_cmd(chars)
        else:
            byt = int(token[2])

        self.byte_code.seek(self.offset)
        self.byte_code.write_byte(byt)

    def writeInt(self, token):
        """Writes four bytes int into memory"""
        if isinstance(token, int):
            key = 0
            self.byte_code.seek(key)
            byt = int(token).to_bytes(4, "little", signed= False)
        else:
            num = get_token(token)
            byt = int(num).to_bytes(4, "little", signed= True)
            self.byte_code.seek(self.offset)
        j = 0
        while j < len(byt):
            self.byte_code.write_byte(byt[j])
            j = j + 1

    def writeOp(self, token):
        """writes four bytes ints instructions and operands into memory"""
        op_code = ""; op1 = ""; op2 = ""
        if len(token) == 3:
            op1 = token[1]
            op2 = token[2]
            op_code = check_Op(token[0], op1, op2)
        elif len(token) < 3:
            op1 = token[1]
            op2 = "0"
            op_code = token[0]

        lyst = self.get_op(op_code, op1, op2)
        for i in range(len(lyst)):
            self.byte_code.seek(self.offset)
            for j in range(len(lyst[i])):
                self.byte_code.write_byte(lyst[i][j])
            self.offset = self.offset + 4

    def get_op(self, op_code, op1, op2):
        """Gets the operands and opcode"""
        op_mem = self.isa.instructions[op_code]
        op_mem = int(op_mem).to_bytes(4, "little", signed= True)
        
        if op1 in self.sym_table:
            op1_mem = self.sym_table[op1]
            op1_mem = int(op1_mem).to_bytes(4, "little", signed= True)
        elif op1.lstrip('-').isnumeric():
            op1_mem = int(op1).to_bytes(4, "little", signed= True)
        elif op1 in self.isa.registers:
            op1 = self.isa.registers[op1]
            op1_mem = int(op1).to_bytes(4, "little", signed= True)

        if  op2 in self.sym_table:
            op2_mem = self.sym_table[op2]
            op2_mem = int(op2_mem).to_bytes(4, "little", signed= True)
        elif op2.lstrip('-').isnumeric() or op2 == "0":
            op2_mem = int(op2).to_bytes(4, "little", signed= True)
        elif op2 in self.isa.registers:
            op2 = self.isa.registers[op2]
            op2_mem = int(op2).to_bytes(4, "little", signed= True)
        else: op2_mem = 0

        lyst = [op_mem, op1_mem, op2_mem]
        return lyst

def key_board_cmd(cmd):
    """parses the escape commands"""
    byt = 0
    if "n" in cmd:
        byt = ord('\n')
    if "s" in cmd:
        byt = ord(" ")
    if "t" in cmd:
        byt = ord("\t")
    if "r" in cmd:
        byt = ord("\r")
    if "0" in cmd:
        byt = ord("\0")

    return byt

def get_token(token):
    """Gets the right token based on the tokens length"""
    op = 0
    if len(token) == 4:
        op = token[3]
    elif len(token) == 3:
        op = token[2]
    elif len(token) == 2:
        op = token[1]
    return op

def check_Op(op_code, op1, op2):
    "Renames STR, LDR, STB, LDB to get the right function"
    isa = ISA()
    if op_code == "STR" and op1 in isa.registers and op2 in isa.registers:
        op_code = "STR1"
    elif op_code == "LDR" and op1 in isa.registers and op2 in isa.registers:
        op_code = "LDR1"
    elif op_code == "STB" and op1 in isa.registers and op2 in isa.registers:
        op_code = "STB1"
    elif op_code == "LDB" and op1 in isa.registers and op2 in isa.registers:
        op_code = "LDB1"
    else:
        return op_code
    return op_code
