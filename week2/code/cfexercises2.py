##################

def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('Hello')
        print(' ')

hello_1(12)

###################

def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('Hello_21')
        elif j % 4 == 3:
            print('Hello_22')
        print(' ')

hello_2(12)

###################

def hello_3(x, y):
    for i in range(x, y):
        print('Hello_3')
    print(' ')

hello_3(3, 17)

###################

def hello_4(x):
    while x != 15:
        print('Hello_4')
        x = x + 3
    print(' ')

hello_4(0)

###################

def hello_5(x):
    while x <100:
        if x == 31:
            for k in range(7):
                print('Hello_51')
        elif x ==18:
            print('Hello_52')
        x = x + 1
    print(' ')

hello_5(12)

# While loop with RREAK

def hello_6(x, y):
    while x: #while x is True
        print("Hello_6! " + str(y))
        y += 1 #increment y by 1
        if y == 6:
            break
    print(' ')

hello_6(True, 0)

###################

x = [i for i in range(10)]
print(x)

###################

x = []
for i in range(10):
    x.append(i)
print(x)

###################

x = [i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)

###################

x = ["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)): # explicit loop
    x[i] = x[i].lower()
print(x)

###################

x =["LIST","COMPREHENSIONS","ARE","COOL"]
x_new = []
for i in x: # implicit loop
    x_new.append(i.lower())
print(x_new)

###################

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = []
for row in matrix:
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)

###################

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)

###################

words = ["These", "are", "some", "words"]

first_letters = set()
for w in words:
    first_letters.add(w[0])

print(first_letters)

type(first_letters)

###################

words = ["These", "are", "some", "words"]

first_letters = {w[0] for w in words} # note the curly brackets

print(first_letters)

type(first_letters)

###################