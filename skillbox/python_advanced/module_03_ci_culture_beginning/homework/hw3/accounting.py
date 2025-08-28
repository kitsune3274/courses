"""
Реализуйте приложение для учёта финансов, умеющее запоминать, сколько денег было потрачено за день,
а также показывать затраты за отдельный месяц и за целый год.

В программе должно быть три endpoints:

/add/<date>/<int:number> — сохранение информации о совершённой в рублях трате за какой-то день;
/calculate/<int:year> — получение суммарных трат за указанный год;
/calculate/<int:year>/<int:month> — получение суммарных трат за указанные год и месяц.

Дата для /add/ передаётся в формате YYYYMMDD, где YYYY — год, MM — месяц (от 1 до 12), DD — число (от 01 до 31).
Гарантируется, что переданная дата имеет такой формат и она корректна (никаких 31 февраля).
"""
from tabnanny import check

from flask import Flask
app = Flask(__name__)

@app.route('/add/<date>/<int:number>')
def add(date, number):
    return save_info(date, number)

@app.route('/calculate/<int:year>')
def calculate_year(year: int):
    return get_sum_from_year(year)

@app.route('/calculate/<int:year>/<int:month>')
def calculate_month(year: int, month: int):
    return get_sum_from_month(year, month)

class OutOfRange(Exception):
    pass

storage: dict = {}

def check_month_day(month: int, day: int) -> bool:
    """
    Проверка не выходит ли указанный день за рамки месяца
    Parameters:
        month: int
            проверяемый месяц
        day: int
            проверяемое количество дней
    Returns:
        True - все удачно, False - вышло за границы дней месяца
    Raises:
        OutOfRange
            ошибка, вызываемая при выходе за границы дней месяца
    """
    try:
        month_max_day = {1: 31, 2: 29, 3: 31,
                     4: 30, 5: 31, 6: 30,
                     7: 31, 8: 31, 9: 30,
                     10: 31, 11: 30, 12: 31}
        if day > month_max_day.get(month):
            raise ValueError
        else:
            return True
    except ValueError:
        return False

def save_info(date: str, number: int) -> str:
    """
    Установление/добавление значений по заданному ключу в словарь storage, а также добавление
    в отдельный ключ общее количество затрат за год/месяц
    Parameters:
        date: str
            входная дата (YYYYMMDD формат)
        number: int
            количество затрат в этот день
    Returns:
        в случае успеха - строка с подтверждением
    Raises:
        ValueError:
            в случае если в дате оказалось не число - вывод ошибки
    """
    # try:
    year, month, day = int(date[:4]), int(date[4:6]), int(date[6:8])
    # except ValueError:
    #     return "Передано не число в дне/месяце/году"

    if not check_month_day(month, day):
        return 'Полученное число дней больше чем есть в этом месяце'

    storage.setdefault(year, {}).setdefault(month, {}).setdefault(day, 0)
    storage.setdefault(year, {}).setdefault(month, {}).setdefault('total_month', 0)
    storage.setdefault(year, {}).setdefault('total_year', 0)

    add_info_to_dict(year, month, day, number)

    return "Данные добавлены"

def add_info_to_dict(year: int, month: int, day: int, number: int):
    """
    Сохраняет полученное число в определенный день
    и подсчет и добавление в словарь полного количества средств потраченных за год
    и подсчет и добавление в полного количества средств потраченных за месяц
    Parameters:
        year: int
            год
        month: int
            месяц
        day: int
            день
        number: int
            число, которое добавляем в указанный день
    """
    storage[year][month][day] = number

    storage[year][month]['total_month'] = sum(
        value for key, value in storage[year][month].items() if not key == 'total_month')

    temp = 0
    for key, value in storage[year].items():
        if not key == 'total_year':
            temp += sum(value1 for key1, value1 in storage[year][key].items() if key1 == 'total_month')
        storage[year]['total_year'] = temp


def get_sum_from_year(year: int) -> str:
    """
    Вывод трат за год
    Parameters:
        year: int
            год, за который нужно вывести сумму затрат
    Returns:
        строка с результатом
    Raises:
        KeyError
            если обратились к ключу (году), который еще не добавлен
    """
    try:

        return "Траты за {year} год: {expenses}".format(
            year = year,
            expenses = storage[year]['total_year']
        )
    except KeyError:
        return 'Нету данных на этот год'

def get_sum_from_month(year: int, month: int) -> str:
    """
    Вывод трат за определенный месяц
    Parameters:
        year: int
            указанный год
        month: int
            месяц, за который нужно вывести сумм затрат
    Returns:
        строка с результатом
    Raises:
        KeyError
            если обратились к ключу (году), который еще не добавлен
    """
    try:

        return "Траты за {month} месяц {year} года: {expenses}".format(
            month=month,
            year=year,
            expenses=storage[year][month]['total_month']
        )
    except KeyError:
        return 'Нету данных на этот месяц'

if __name__ == "__main__":
    app.run(debug=True)

