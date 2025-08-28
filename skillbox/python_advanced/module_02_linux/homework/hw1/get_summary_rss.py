"""
С помощью команды ps можно посмотреть список запущенных процессов.
С флагами aux эта команда выведет информацию обо всех процессах, запущенных в системе.

Запустите эту команду и сохраните выданный результат в файл:

$ ps aux > output_file.txt

Столбец RSS показывает информацию о потребляемой памяти в байтах.

Напишите функцию get_summary_rss, которая на вход принимает путь до файла с результатом выполнения команды ps aux,
а возвращает суммарный объём потребляемой памяти в человекочитаемом формате.
Это означает, что ответ надо перевести в байты, килобайты, мегабайты и так далее.
"""

import subprocess
import os

def run_command_to_create_file() -> None:
    """
    Выполнение команды в подсистеме Linux (вывод информации обо всех процессах,
    запущенных в системе
    """
    try:
        subprocess.run('ps aux > output_file.txt',
                       shell=True, capture_output=True, text=True, check=True)
    except subprocess.CalledProcessError as error:
        print('Ошибка выполнения программы: {error_command}'.format(
            error_command=error
            )
        )

def get_file_path() -> str:
    """
    Получение пути до файла, полученного при выполнении команды
    в функции run_command_to_create_file
    Returns:
        Путь до файла outpus_file.txt
    """
    return os.path.abspath('output_file.txt')

def get_summary_rss(ps_output_file_path: str) -> str:
    """
    Суммирование всех значений столбца RSS (информация о потребляемой памяти в байтах)
    Parameters:
        ps_output_file_path: str
            путь до файла
    Returns:
        сумма всех значений столбца RSS
    """
    with open(ps_output_file_path, "r") as file:
        lines = file.readlines()[1:]
        summ = 0
        for line in lines:
            line = line.split()
            rss_info = line[5]
            summ += int(rss_info)
    result = convert_rss_size(summ)
    return result

def convert_rss_size(size: int) -> str:
    size_types = ['B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']
    if size < 0:
        return 'Размер меньше нуля'
    for size_type in size_types:
        if size < 1024:
            return 'Результат: {size:.1f} {size_type}'.format(
                size=size,
                size_type=size_type
            )
        size /= 1024
    else:
        return 'Результат : {size:.1f} {size_type}'.format(
            size=size,
            size_type=size_type
        )

def test_sizes() -> None:
    sizes = [-1, 0, 1024, 1024**2, 1024**3, 1024**4, 1024**5,
             1024**6, 1024**7, 1024**8, 1024**9, 1024**10, 1024**11]
    for size in sizes:
        print(convert_rss_size(size))



if __name__ == '__main__':
    run_command_to_create_file()
    path: str = get_file_path()
    summary_rss: str = get_summary_rss(path)
    print(summary_rss)
    # Проверка различных размеров
    # test_sizes()
