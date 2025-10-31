# My CMEE Coursework Repository For Week2
This week's work is focusing on Python

## code 
1. **loops.py**  
    Simple examples of 'FOR loops' and 'WHILE loop'.

2. **MyExampleScrip.py**  
    An example script of Python scripts (x *= x)

3. **cfexercise1.py**  
    Several foo_x function. For example, foo_5 is a recursive function that calculates the factorial of x. And it can now take arguments from user and show they work.

4. **cfexercises2.py**  
More examples of loops and conditionals combined.

5. **oaks.py**  
This script compare the looping and list comprehension way for finding oak tree species names and get names in upper case

6. **scope.py**  
This script illustrates variable scope. Like global variables that make certain variables visible both inside and outside of functions

7. **basic_io1.py**  
This script shows a brief sample of opening a file for reading and close it (test.txt) etc.

8. **basic_io2.py**  
This script shows a sample of saving the elements of a list to a file (testout.txt)

9. **basic_io3.py**  
It shows a sample of saving an object for later use (storing objects) (testp.p)

10. **basic_csv.py**  
Using csv package to manipulate CSV files. (testcsv.csv). It can read a file and write a file containing only species name and Body mass from testcsv.csv

11. **boilerplate.py**  
A Sample of python programs.

12. **using_name.py**  
A script illustrates the __name__=="__main__". It force the module execute to start with control flow first passing through the main function.

13. **sysargv.py**   
A sample script of argument variable (argv) 

14. **control_flow.py**  
A script contains come functions exemplifying the use of control statements

15. **lc1.py, lc2.py, dictionary.py, tuple.py**   
Those are tasks focusing on loops, list comprehensions, dictionary and tuple

16. **test_control_flow.py**  
Same as control_flow.py but used to test the simplest testing toll doctest

17. **debugme.py**  
A sample of debugging

18. **align_seqs.py**  
This script aligns two DNA sequences such that they are as similar as possible. It can read two DNA sequences from input files and find the best alignment and output it then score to a text file. And i have inserted a breakpoint at the start of the for loop to examine the script.

19. **align_seqs_fasta.py**  
It takes fasta sequences and align them.

20. **align_seqs_better.py**  
Not written yet

21. **oaks_debugme.py**   
Fixing a missing oaks problem by using doctests and debugging breakpoint.
The bug is that the 'quercs' is missing the letter "u" !

22. **LV1.py**  
Script that used to test numpy and generating figures.

23. **test.py**  
Used to test my script to see an expected result.

24. **profileme.py**  
Illustrative program that locate the sections of your code where speed bottlenecks exist.

25. **profileme2.py**  
An alternative approach of profiling code

26. **timeitme.py**  
Timeit module is used to figure out what the best way to do something specific as part of a larger program. And it includes a approach to time the function

27. **vectorization_revisited.py**  
Example of comparing  loop-based function and a vectorized function to calculate the entrywise product of two 1D arrays of the same length.




## data
1. **fasta files**  
Those fasta files are used for the practicals in DNA sequences.

2. **testcsv.csv**  
The input file of align_seq.py, including two row of sequences.

3. **bodymass.csv**  
Data about species and their body mass (kg)

4. **TestOaksData.csv**  
Genus and species for Oaks

5. **JustOakData.csv**  
Write oak data (Only Quercus)

## results 
1. **best_alignment.txt**  
Output of _alignseqs.py_

2. **LV_model.pdf, y1_figure.pdf, Practicals_figure.pdf**  
Output of _LV1.py_

## error
- The following error may occurs because of you are not in the right direction. For example, you need to get into /Documents/CMEECourseWork/week2/code
```
Errors:
**********
Traceback (most recent call last):
  File "/home/mhasoba/Documents/Teaching/IC_CMEE/2025-26/Coursework/StudentRepos/RuixuanHan_rh925/week2/code/basic_io2.py", line 8, in <module>
    f = open('../sandbox/testout.txt', 'w')
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: '../sandbox/testout.txt'
```

**********


