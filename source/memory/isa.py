"""Instruction set module"""
class ISA():
    """Instruction set class"""
    def __init__(self):
        """init method"""
        self.instructions = {
            "JMP" : 1,
            "JMR" : 2,
            "BNZ" : 3,
            "BGT" : 4,
            "BLT" : 5,
            "BRZ" : 6,
            "MOV" : 7,
            "LDA" : 8,
            "STR" : 9,
            "LDR" : 10,
            "STB" : 11,
            "LDB" : 12,
            "ADD" : 13,
            "ADI" : 14,
            "SUB" : 15,
            "MUL" : 16,
            "DIV" : 17,
            "AND" : 18,
            "OR"  : 19,
            "CMP" : 20,
            "TRP" : 21,
            "STR1": 22,
            "LDR1": 23,
            "STB1": 24,
            "LDB1": 25,
            "CMPI": 32,
            "MOVI": 31,
            "MULI": 33,
            "DIVI": 34,
        }

        self.registers = {
            "R0" : 0,
            "R1" : 1,
            "R2" : 2,
            "R3" : 3,
            "R4" : 4,
            "R5" : 5,
            "R6" : 6,
            "R7" : 7,
            "R8" : 8,
            "R9" : 9,
            "R10" : 10,
            "R11" : 11,
            "R12" : 12,
            "R13" : 13,
            "R14" : 14,
            "R15" : 15,
            "PC"  : 16,
            "SL"  : 17,
            "SB"  : 18,
            "SP"  : 19,
            "FP"  : 20,
        }

        self.reg = get_regs()
        self.rev_inst = {}
        self.rev_regs = {}

        for key in self.instructions:
            self.rev_inst[self.instructions[key]] = key
        for key in self.registers:
            self.rev_regs[self.registers[key]] = key

def get_regs():
    registers = [0] * 21
    return registers
