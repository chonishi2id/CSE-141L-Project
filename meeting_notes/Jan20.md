# CSE 141L Project Meeting 1
## Date: Jan 20, 2022
**Goal: Decide what operations to support and figure out general direction of our processor**

Operations
1. Logical Shift Left 
2. Logical Shift Right
3. AND operator
4. ORR operator
5. Load
6. Store
7. Branch (look more into this)
8. Comparators (probably just greater than or equal to) ==> can implement with add op like in ALU
9. Add operator

With 9 instructions, we can have a 3 bit encoding for each instruction.

Program 1 Notes:  
-XOR can be expressed in terms of AND/OR

Program 2 Notes:  
-Is printing to console/output an instruction?  
-Idea: replace two-bit error with immediate value to show an error was detected

Program 3 Notes:  
-Need comparison operator because we need to compare all 5-bit groupings to the 5-bit pattern  
-Increment (add)

To think about more:  
-How many bits do we want to allow immediate value to have => max number we can support  
-Find a clever way to represent immediates, probably need at least up to 256

Brainstorming overall goals for ISA:  
-Maybe two instruction types: register only and with immediates  
-Think of which of the design archetypes is best-suited (load/store)  
-Start with load/store architecture since it is used in modern architecture and is a good reference 
