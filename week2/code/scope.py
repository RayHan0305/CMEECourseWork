_a_global = 10

def a_function():
    _a_local = 4

    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_globl is", _a_global)

a_function()

print("OUtside the function, the vaue of _a_global is", _a_global)
print("############################")
############################

a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("INside the function, the value _a_local is", _a_local)

a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)
print("############################")
############################

def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)

print("############################")
############################

_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)