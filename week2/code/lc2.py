# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
rain_100 = [(month, rain_amount) for (month, rain_amount) in rainfall if rain_amount > 100]
print("Months and rainfall values when the amount of rain was greater than 100 mm:", rain_100)
print("---------------------------------")

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
rain_50 = [month for (month, rain_amount) in rainfall if rain_amount < 50]
print("Months values when the amount of rain was less than 50 mm:", rain_50)
print("---------------------------------")
# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 
rain_100_loops = []
rain_50_loops = []
for month, rain_amount in rainfall:
    if rain_amount > 100:
        rain_100_loops.append((month,rain_amount))
    elif rain_amount < 50:
        rain_50_loops.append(month)
print("Months and rainfall values when the amount of rain was greater than 100 mm:", rain_100_loops,
      "Months values when the amount of rain was less than 50 mm:", rain_50_loops)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

