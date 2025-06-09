# Floating-Point Adder/Subtractor (VHDL, IEEE-754)

This project implements a floating-point arithmetic unit capable of performing addition and subtraction on 32-bit numbers, based on the IEEE-754 single-precision standard. The design is written in VHDL and structured for simulation and synthesis using Xilinx Vivado.

---

## ⚙️ Features

- Supports 32-bit IEEE-754 single-precision floating-point format
- Performs **addition and subtraction** operations
- Handles:
  - Operand alignment
  - Arithmetic (add/sub)
  - Normalization
  - Rounding
  - Overflow/underflow detection
  - Sign, exponent, and mantissa extraction and recombination
- Modular design (separate components for each stage)

---

## 🧪 How It Works

### Input:
Two 32-bit floating-point numbers (A and B) + operation selector (add/sub)

### Process:
1. Extract sign, exponent, and mantissa from inputs
2. Align exponents
3. Perform addition or subtraction
4. Normalize result
5. Apply rounding
6. Reconstruct final IEEE-754 output

### Output:
One 32-bit IEEE-754 compliant result

---

## 📄 IEEE-754 Reference

This project uses the IEEE-754 single-precision layout:
- **1 bit**: sign  
- **8 bits**: exponent  
- **23 bits**: mantissa

---
