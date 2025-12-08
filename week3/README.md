# My CMEE Coursework Repository For Week3-Biological Computing in R
Data processing workflows, documentation habits, input validation

## Repository Structure
- **code:** All R and Python scripts

- **data:** Data files for  analysis

- **results:** Output files from scripts

## code
1. **.Rhistory**  
It stores the commands that i typed in the R console which lets R remember what i have done in the previous session.

2. **basic_io.R**  
It is a simple script to illustrate R input-output. Using the data 'trees.csv'. It will create the file 'MyData.csv'

3. **.RData**  
It contains all the data loaded and created in R, including outputs of statistical analyses and other things.

4. **MyResults.Rout**  
THis file contains all the output.

5. **control_flow.R**  
sample codes of 'if statements', 'for loops', 'while loops'

6. **break.R**  
Sample codes of 'break' out of a loop 

7. **next.R**  
This code checks if a number is odd using the "modulo" operation and prints it if it is. (skip to next iteration of a loop)

8. **boilerplate.R**  
Sample codes of R functions

9. **TreeHeight.R**  
The function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula.
After modifing the script during Practicals, it can calculates all the tree heights in the dataset. The output file is "TreeHits.csv"

10. **Vectorize1.R**  
A sample script that illustrates how the vectorization makes writing code more concise.

11. **preallocate.R**  
loops that resizes a vector repeatedly makes R re-allocate memory repeatedly, which makes it slow.

12. **apply1.R**  
Samples of *apply family of functions. It vectorizes codes.

13. **apply2.R**  
Including a function called SomeOperation that do some calculations.

14. **sample.R**  
Sample script of vectorization involving lapply and sapply.

15. **Florida.R**  
Practical example for Florida task

16. **Florida_Report.tex**  
Latex file for Florida task

17. **MyFirstJupyterNB.ipynb**  
A test sample of jupyter notebook

18. **plotLin.R**  
Exemplifies using ggplot to annotate and manipulate plots


## data
- `EcolArchives-E089-51-D1.csv`
- `PoundHillData.csv`
- `PoundHillMetaData.csv`
- `GenomeSIze.csv`
- `trees.csv`
- `GPDDFiltered.RData`
- `KeyWestAnnualMeanTemperature.RData` 
- `Results.txt`

## results
All results from the scripts will be saved in the `results` folder.

## How to run
Navigate to 'code/' directory.
Most scripts can be executed from the bash terminal using:

```bash
Rscript script_name.R
```

### Example Commands

```bash
Rscript DataWrang.R
```

## Author

Ruixuan Han
rh925@ic.ac.uk
