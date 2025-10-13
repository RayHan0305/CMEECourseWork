birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 
birds_latin_names = set([separate[0] for separate in birds])
birds_common_names = set([separate[1] for separate in birds])
birds_mean_body_masses = set([separate[2] for separate in birds])
print("Latin names:", birds_latin_names)
print("Common names:", birds_common_names)
print("Mean body massses:", birds_mean_body_masses)
print("----------------------------------------------")
# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
birds_latin_names_loops = set()
birds_common_names_loops = set()
birds_mean_body_masses_loops = set()
for separate in birds:
    birds_latin_names_loops.add(separate[0])
    birds_common_names_loops.add(separate[1])
    birds_mean_body_masses_loops.add(separate[2])
print("Latin names (loops):", birds_latin_names_loops)
print("Common names (loops):", birds_common_names_loops)
print("Mean body massses (loops):", birds_mean_body_masses_loops)
print("----------------------------------------------")

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 