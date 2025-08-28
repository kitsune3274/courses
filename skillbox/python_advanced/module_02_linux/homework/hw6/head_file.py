"""
Реализуйте endpoint, который показывает превью файла, принимая на вход два параметра: SIZE (int) и RELATIVE_PATH —
и возвращая первые SIZE символов файла по указанному в RELATIVE_PATH пути.

Endpoint должен вернуть страницу с двумя строками.
В первой строке будет содержаться информация о файле: его абсолютный путь и размер файла в символах,
а во второй строке — первые SIZE символов из файла:

<abs_path> <result_size><br>
<result_text>

где abs_path — написанный жирным абсолютный путь до файла;
result_text — первые SIZE символов файла;
result_size — длина result_text в символах.

Перенос строки осуществляется с помощью HTML-тега <br>.

Пример:

/head_file/8/docs/simple.txt
/home/user/module_2/docs/simple.txt 8
hello wo

/head_file/12/docs/simple.txt
/home/user/module_2/docs/simple.txt 12
hello world!
"""

from flask import Flask
import os

app = Flask(__name__)

@app.route("/head_file/<int:size>/<path:relative_path>")
def head_file(size: int, relative_path: str):
    return get_text_within_user_number(size, relative_path)


def get_text_within_user_number(r_size: int, f_path: str) -> str:
    """
    Подсчитывает размер переданного файла (если он существует),
    считывает r_size количество текста
    Parameters:
         r_size: int
            количество символов, которое нужно считать
        f_path: str
            имя файла
    Returns:
        строка с абсолютным путем, считанное количество символов и считанный текст
    Raises:
        FileNotFoundError:
            файл с переданным именем не найден
    """
    try:
        path = os.path.abspath(f_path)
        with open(f_path, 'r') as file:
            text_r_size = file.read(r_size)
            size = len(text_r_size)
        result = '{abs_file_path} {file_size}<br>{symbols_read}'.format(
            abs_file_path = path,
            file_size = size,
            symbols_read = text_r_size
        )
        return result
    except FileNotFoundError:
        return 'Файл не найден'

if __name__ == '__main__':
    app.run(debug=True)
