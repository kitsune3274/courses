"""
Удобно направлять результат выполнения команды напрямую в программу с помощью конвейера (pipe):

$ ls -l | python3 get_mean_size.py

Напишите функцию get_mean_size, которая на вход принимает результат выполнения команды ls -l,
а возвращает средний размер файла в каталоге.
"""

import sys


import sys

def get_mean_size(ls_output: list) -> float:
    """
    Подсчет среднего размера файла в каталоге
    Parameters:
        ls_output: list
            список строк, полученных при помощи команды ls -l
    Returns:
        средний размер файла в каталоге
    Raises:
        ZeroDivisionError:
            если каталог пуст, то в нем нет файлов, а значит и нету никаких размеров
    """
    try:
        summ: int = 0
        count: int = 0
        for line in ls_output:
            line = line.split()
            summ += int(line[4])
            count += 1
        return summ / count
    except ZeroDivisionError:
        print("Директория пуста.")
        exit()

if __name__ == "__main__":
    data = sys.stdin.readlines()[1:]
    size = get_mean_size(data)
    print('{:.1f}'.format(size))
