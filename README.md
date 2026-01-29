# Virtual Machine Assembler & Simulator

## Overview

This project implements a Virtual Machine (VM) Assembler and Simulator, designed to model how low-level programs are assembled, executed, and managed within a simplified virtual CPU environment. The system translates assembly-like instructions into executable operations and simulates their execution step by step.

The project focuses on computer architecture fundamentals, instruction execution, and systems-level programming concepts.

---

## Project Goals

* Simulate the behavior of a simple virtual machine
* Assemble human-readable instructions into machine-interpretable operations
* Execute programs instruction-by-instruction
* Provide visibility into registers, memory, and program state
* Reinforce understanding of how CPUs and assemblers work internally

---

## Key Features

* Custom instruction set
* Assembly-style input programs
* Instruction decoding and execution engine
* Virtual registers and memory model
* Program counter–based execution flow
* Error handling for invalid instructions
* Deterministic, repeatable simulation results

---

## Technologies Used

* **Python and Standard ISA**
* **Low-level data structures**
* **Command-line interface**

---

## Project Structure

```
Virtual-Machine-Assembler-Simulator/
├── source/
│   ├── asm/
│   │   ├── proj1.asm
│   │   ├── proj2.asm
│   │   ├── proj3.asm
│   │   ├── we.asm
│   │   ├── proj1.bin
│   │   ├── proj2.bin
│   │   ├── proj3.bin
│   │   ├── symtab.csv
│   │   ├── proj1.as_exec.log
│   │   ├── proj2.as_exec.log
│   │   └── proj3.as_exec.log
│   │
│   ├── memory/
│   │   ├── __init__.py
│   │   ├── isa.py
│   │   └── Mem.py
│   │
│   ├── vm/
│   │   ├── Assembler.py
│   │   └── VirtualMachine.py
│   │
│   └── main.py
└── README.md
```

---

## How It Works

### 1. Assembly Phase

* Input assembly programs are parsed line by line
* Instructions are validated and translated into VM operations
* Labels and symbolic references are resolved

### 2. Execution Phase

* Instructions are loaded into VM memory
* The program counter advances through instructions
* Registers and memory are updated per instruction semantics
* Execution continues until program termination

---

## Example Instructions

(Instruction set may vary depending on implementation)

```
LOAD R1, 10
LOAD R2, 20
ADD  R3, R1, R2
STORE R3, 0x100
HALT
```

---

## Running the Simulator

```bash
python main.py .\asm\proj2.asm
```

The simulator loads the program, executes each instruction, and displays the resulting VM state.

---

## Output

* Register values after execution
* Memory state changes
* Program termination status
* Error messages for invalid instructions or runtime faults

---

## Limitations

* Simplified instruction set
* No pipelining or parallel execution

---

## Lessons Learned

* Translating high-level intent into low-level operations
* Designing a clean instruction execution model
* Managing program state safely and predictably
* Debugging stateful systems

