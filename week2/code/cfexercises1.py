import sys

def foo_1(x = 10):
    return x ** 0.5

def foo_2(x = 10, y = 5):
    if x > y:
        return x
    return y

def foo_3(x = 3, y = 2, z = 1):
    if x > y:
        x, y = y, x
    if x > z:
        x, z = z, x
    if y > z:
        y, z = z, y
    return [x, y, z]

def foo_4(x = 10):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x = 5):
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x = 10):
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def amin(argv):
    print("foo_1():", foo_1(10))
    print("foo_2():", foo_2())
    print("foo_3():", foo_3())
    print("foo_4():", foo_4())
    print("foo_5():", foo_5())
    print("foo_6():", foo_6())
    return 0

if (__name__ == "__main__"):
    status = amin(sys.argv)
    sys.exit(status)