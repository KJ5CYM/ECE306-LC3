# ECE306-LC3
LC3 (Little Computer 3) assembly programs that I created for "Introduction to Computing" with Dr. Yale N. Patt 

## LAB 1
##### comparison.bin
a machine code program that compares two numbers, X and Y. X is stored in memory location x3100 and that Y is stored in memory location x3101. The program compares X and Y, and if X > Y, store a -1 at memory location x3102; if X = Y, store a 0 at memory location x3102; and, if X < Y, store a 1 at memory location x3102. 
##### bsr.bin
a machine code program that finds the first “1” in a bit vector from the least significant bit to the most significant bit. Assumes that a bit vector B is stored in memory location x3100. Stores the index of the first “1” in memory location x3101.
##### See LAB1_TESTS directory for more information about how the programs performed for various tests. 
### Total score for this lab: 97%
## LAB 2
##### sort.asm
a program in LC-3 assembly language to sort an array NUMBERS of 2’s complement integers. Assumes that the base address of NUMBERS is stored in memory location x3200 and the number of elements n in the array is stored in memory location x3201. Each memory location contains a single 2's complement integer. That is, each memory location contains a single element of the array. Sorts the array of 2's complement integers in descending order (largest-to-smallest) and stores the result back in memory starting at the base address of the array.
##### See LAB2_TESTS directory for more information about how the program performed for various tests. 
### Total score for this lab: 44%
## LAB 3
##### merge.asm
a program in LC-3 assembly language that takes as input two linked lists stored in memory -- each list contains employees names -- and combines the lists into one sorted list of names. A pointer to the first element of this new list will be stored in location x4002.
##### See LAB3_TESTS directory for more information about how the program performed for various tests. 
### Total score for this lab: 86%
