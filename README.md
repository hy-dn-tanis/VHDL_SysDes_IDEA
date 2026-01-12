# VHDL IDEA Encryption Implementation

## Overview

This project implements the **IDEA (International Data Encryption Algorithm)** encryption cipher in VHDL for hardware synthesis. IDEA is a symmetric-key block cipher that operates on 64-bit plaintext blocks using a 128-bit key.

Direct: Direct brute force implementation of the IDEA algorithm - exceeds available resources on the FPGA
RCS1: Implements scheduling to reuse same modules, saves resource usage - can be flashed into an FPGA
RCS2: Implements dataflow & controller modules to limit resource usage even further - uses only approximately 5% of FPGA resources
