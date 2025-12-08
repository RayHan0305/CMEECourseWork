# My CMEE Coursework Repository For Week4-Biological Computing in R
Integrated analysis workflows, reproducible outputs, clear reporting

## Repository Structure
- **code:** All R and Python scripts

- **data:** Data files for  analysis

- **results:** Output files from scripts

## code
1. **PP_Regress.R**  
The practical on regression

2. **GPDD_Data.R**  
Practical for map package

3. **DataWrang.R**  
Exemplifies methods to explore data, and transfers from wide to long format.

4. **DataWrangTidy.R**  
Exemplifies data exploration and switching from wide to long format using the packages 'tidyr' and 'dplyr'.

5. **SQLinR.R**  
SQL database operations in R. Shows how to use SQL queries within R environment

6. **PP_Dists.R**  
Plots Distribution of Predator, Prey Mass, and Predator/Prey mass by feeding interaction in three charts. Saves charts to pdf, as well as csv file containing mean, median log predator and prey mass, and the predator-prey size ratio by feeding type.

7. **Girko.R**  
Plots a simulaion of Girko's law and saves to pdf in results directory

8. **MyBars.R**  
Plots histogram with annotations. Saves results to results directory

9. **LV1.py**  
Lotka-Volterra model of consumer-resource population dynamics

10. **profileme.py**  
Code profiling examples. Demonstrates how to identify performance bottlenecks

11. **profileme2.py**  
Advanced profiling techniques. Compares different optimization approaches

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
python3 script_name.py
```
### Example Commands

```bash
python3 LV1.py
```

## Author

Ruixuan Han
rh925@ic.ac.uk
