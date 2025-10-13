# !/usr/bin/env python3
# Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from another script/program/module!')
print("THis module's name is:" + __name__)