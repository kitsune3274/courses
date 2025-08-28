"""
Реализуйте endpoint /hello-world/<имя>, который возвращает строку «Привет, <имя>. Хорошей пятницы!».
Вместо хорошей пятницы endpoint должен уметь желать хорошего дня недели в целом, на русском языке.

Пример запроса, сделанного в субботу:

/hello-world/Саша  →  Привет, Саша. Хорошей субботы!
"""

from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route('/hello-world/<string:user_name>')
def hello_world(user_name: str):
    return get_greetings_and_date(user_name)

def get_greetings_and_date(user_name: str) -> str:
    """
    Получение текущего дня недели и вывод строки в виде
    'Привет {имя}. Хорошего(-ей) {день_недели}!'
    Parameters:
        user_name: str
            полученное имя
    Returns:
        строка 'Привет {имя}. Хорошего(-ей) {день_недели}!'
    """
    weekday = datetime.today().weekday()
    # weekday_names = ['понедельник', 'вторник','среда',
    #                  'четверг','пятница','суббота',
    #                  'воскресенье']
    # 112
    weekday_names = {0:'понедельник', 1:'вторник', 2:'среда',
                     3:'четверг', 4:'пятница', 5:'суббота',
                     6:'воскресенье'}
    # 96
    if weekday in [0, 1, 3]:
        result = "Хорошего " + weekday_names[weekday] + 'а'
    elif weekday in [2, 4, 5]:
        result = "Хорошей " + weekday_names[weekday][:-1] + 'ы'

    else:
        result = "Хорошего " + weekday_names[weekday][:-1] + 'я'
    return "Привет {name}. {result}!".format(
        name = user_name,
        result = result
    )

if __name__ == '__main__':
    app.run(debug=True)