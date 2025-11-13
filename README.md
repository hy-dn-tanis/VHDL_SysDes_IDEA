# VHDL IDEA Encryption Implementation

## Overview

This project implements the **IDEA (International Data Encryption Algorithm)** encryption cipher in VHDL for hardware synthesis. IDEA is a symmetric-key block cipher that operates on 64-bit plaintext blocks using a 128-bit key.

## Description

The IDEA algorithm is a powerful encryption scheme that uses a combination of three algebraic operations:
- Bitwise XOR (⊕)
- Addition modulo 2^16 (⊞)
- Multiplication modulo 2^16 + 1 (⊙)

This VHDL implementation provides a hardware-based solution suitable for FPGA deployment, particularly targeting Xilinx devices.

## Architecture

### Main Entity: `idea.vhd`

The top-level module that implements the complete IDEA encryption process.

**Inputs:**
- `KEY`: 128-bit encryption key
- `X_1`, `X_2`, `X_3`, `X_4`: Four 16-bit input blocks (64-bit plaintext total)

**Outputs:**
- `Y_1`, `Y_2`, `Y_3`, `Y_4`: Four 16-bit output blocks (64-bit ciphertext total)

The design uses a structural architecture consisting of 8 encryption rounds followed by an output transformation.

### Core Modules

#### 1. **addop.vhd** - Addition Operation
Performs modulo 2^16 addition on two 16-bit inputs.
- Inputs: `IN1`, `IN2` (16-bit vectors)
- Output: `OUT_SUM` (16-bit vector)

#### 2. **mulop.vhd** - Multiplication Operation
Implements modulo (2^16 + 1) multiplication with special handling for zero values:
- Zero is treated as 2^16 in the multiplication
- Inputs: `I_1`, `I_2` (16-bit vectors)
- Output: `O_1` (16-bit vector)

#### 3. **xorop.vhd** - XOR Operation
Performs bitwise XOR operation on two 16-bit inputs.
- Inputs: `IN1`, `IN2` (16-bit vectors)
- Output: `OUT1` (16-bit vector)

#### 4. **round.vhd** - IDEA Round Function
Implements one complete round of the IDEA algorithm, combining multiplication, addition, and XOR operations according to the IDEA specification.
- Inputs: `X1`-`X4` (data blocks), `Z1`-`Z6` (subkeys)
- Outputs: `Y1`-`Y4` (transformed data blocks)

#### 5. **trafo.vhd** - Output Transformation
Performs the final output transformation after the 8 encryption rounds.
- Inputs: `X1`-`X4` (data blocks), `Z1`-`Z4` (final subkeys)
- Outputs: `Y1`-`Y4` (final ciphertext blocks)

## Project Structure

```
.
├── README.md           # This file
├── idea.vhd           # Top-level IDEA entity
├── round.vhd          # Round function implementation
├── trafo.vhd          # Output transformation
├── addop.vhd          # Addition operation
├── mulop.vhd          # Multiplication operation
├── xorop.vhd          # XOR operation
├── tb_addop.vhd       # Testbench for addition
├── tb_mulop.vhd       # Testbench for multiplication
├── tb_round.vhd       # Testbench for round function
├── tb_trafo.vhd       # Testbench for transformation
├── tb_xorop.vhd       # Testbench for XOR
├── idea.xise          # Xilinx ISE project file
└── idea.gise          # Xilinx project settings
```

## Usage

### Prerequisites

- Xilinx ISE Design Suite (for synthesis and simulation)
- VHDL simulator (e.g., ModelSim, GHDL, or ISE ISim)

### Simulation

1. Open the project in Xilinx ISE using `idea.xise`
2. Use the provided testbenches to verify individual modules:
   - `tb_addop.vhd` - Test addition operation
   - `tb_mulop.vhd` - Test multiplication operation
   - `tb_xorop.vhd` - Test XOR operation
   - `tb_round.vhd` - Test round function
   - `tb_trafo.vhd` - Test output transformation

### Synthesis

1. Open the project in Xilinx ISE
2. Select the target FPGA device
3. Run synthesis, implementation, and generate bitstream
4. Program the FPGA with the generated bitstream

## Technical Details

- **Data Width**: 64 bits (4 × 16-bit blocks)
- **Key Length**: 128 bits
- **Number of Rounds**: 8
- **Technology**: Designed for Xilinx FPGA implementation
- **Architecture**: Structural (component-based design)

## Algorithm Notes

The IDEA algorithm operates through 8.5 rounds:
- **8 Rounds**: Each uses 6 subkeys derived from the main 128-bit key
- **Final Half-Round**: Output transformation using 4 additional subkeys

Each round performs:
1. Multiplication and addition with subkeys
2. XOR operations between intermediate results
3. Additional multiplication and addition for mixing
4. XOR operations to produce round outputs

## References

- IDEA Algorithm: [Wikipedia - IDEA](https://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm)
- Original Paper: X. Lai and J. Massey, "A Proposal for a New Block Encryption Standard," 1990

## License

This project is provided for educational purposes.