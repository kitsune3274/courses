"""
Реализуйте endpoint, начинающийся с /max_number, в который можно передать список чисел, разделённых слешем /.
Endpoint должен вернуть текст «Максимальное переданное число {number}»,
где number — выделенное курсивом наибольшее из переданных чисел.

Примеры:

/max_number/10/2/9/1
Максимальное число: 10

/max_number/1/1/1/1/1/1/1/2
Максимальное число: 2

"""
from flask import Flask

app = Flask(__name__)

@app.route('/max_number/<path:numbers>')
def max_number(numbers: str):
    return get_max_number(numbers)

def get_max_number(str_of_numbers: str):
    """
    Нахождение максимального числа
    Parameters:
         str_of_numbers: str
            переданная строка в url вида '1/2/3/4/1/2'
    Returns:
        строка с максимальным числом
    Raises:
        ValueError:
            если передано не число, то выводится эта ошибка
    """
    temp = ''
    try:
        result = list(str_of_numbers.replace('/', " ").split())
        for index, item in enumerate(result):
            temp = result[index]
            result[index] = int(item)
        return 'Максимальное число в списке: {max}'.format(
            max = max(result)
        )
    except ValueError:
        return "В строке есть не число: {char}".format(
            char=temp
        )

if __name__ == "__main__":
    app.run(debug=True)
