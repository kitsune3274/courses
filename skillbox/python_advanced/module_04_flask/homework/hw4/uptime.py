"""
Напишите GET-эндпоинт /uptime, который в ответ на запрос будет выводить строку вида f"Current uptime is {UPTIME}",
где UPTIME — uptime системы (показатель того, как долго текущая система не перезагружалась).

Сделать это можно с помощью команды uptime.
"""

from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route("/uptime", methods=['GET'])
def uptime() -> str:
    uptime_seconds = get_uptime()
    return f'Current uptime is {uptime_seconds}'

def get_uptime() -> int:
    """
    Выполняет системную команду Unix OS 'uptime', преобразует дни в часы, часы в минуты, минуты в секунды
    Returns:
         время безотказной работы системы в секундах
    """
    raw = subprocess.run(['uptime'], capture_output=True, text=True, check=True)
    line = raw.stdout.replace(',', '').split()
    days = 0
    if 'day' in line or 'days' in line:
        days = line[2]
        hours, minutes = map(int, line[4].split(':'))
    else:
        hours, minutes = map(int, line[2].split(':'))
    total_seconds = ((days * 24 + hours) * 60 + minutes) * 60
    return total_seconds

# поточнее
# import uptime
# def get_uptime() -> str:
#     return uptime.uptime() + " секунд"

if __name__ == '__main__':
    app.run(debug=True)