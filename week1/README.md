# My CMEE Coursework Repository for Week1
This week's work is focusing on UNIX, Linux, Shell scripting, Git and LATEX. Just a rookie now.
Basic file organization, simple scripts that run successfully

## Repository Structure
- **code:** All R and Python scripts

- **data:** Data files for  analysis

- **results:** Output files from scripts


## code
1. **boilerplate.sh**  
This is the first shell script. It just contains a sentence "This is a shell script!".
2. **variables.sh**  
illustrates different types of shell variables.(Input feedback added)
3. **tabtocsv.sh**  
is a shell script to substitute all tabs with commas. (Input feedback added)
4. **CountLines.sh**  
counts the number of lines in a given text file.(Input feedback added)
5. **ConcatenateTwoFiles.sh**  
merges the contents of two files into a single output file. (Input feedback added)
6. **tiff2png.sh**  
converts all .tif image files in the current directory into png format automatically. (Input feedback added, using if ls *.tif to check the existence of an input) (Improved already)
7. **MyExampleScript.sh**  
includes a brief sample of the $USER environmental variable.
8. **UnixPrac1.txt**  
is a .txt file with UNIX shell commands for the 'FASTA exercise'. (Coding details are inside the file)
9. **.csv**  
contains the output of **tabtocsv.sh**
10. **csvtospace.sh**  
converts csv files into space-separated text files.  Run ./csvtospace.sh ../data/1800.csv to have an output.

## data
- `1800.csv`
- `1801.csv`
- `1802.csv`
- `1803.csv`
- `407228326.fasta`
- `407228412.fasta`
- `E.coli.fasta` 
- `UnixPrac1.txt`

## result
The .txt files are outputs of csvtospace.sh

## sandbox

## How to run
Navigate to 'code/' directory.
Most scripts can be executed from the bash terminal using:

```bash
bash script_name.sh
```

### Example Commands
```bash
bash MyExampleScript.sh
bash CountLines.sh ../data/fasta/E.coli.fasta
```

## ~~assignments~~
Just ignore it.

## Author

Ruixuan Han
rh925@ic.ac.uk
