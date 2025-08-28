"""
Напишите GET-эндпоинт /ps, который принимает на вход аргументы командной строки,
а возвращает результат работы команды ps с этими аргументами.
Входные значения эндпоинт должен принимать в виде списка через аргумент arg.

Например, для исполнения команды ps aux запрос будет следующим:

/ps?arg=a&arg=u&arg=x
"""
import subprocess
from subprocess import CalledProcessError

from flask import Flask, request, render_template


app = Flask(__name__)


@app.route("/ps", methods=["GET"])
def ps():
    """
    Получение списка аргументов и выполнение программы ps с входящими аргументами
    Returns:
        результат выполнения программы или ее ошибка
    """
    args = request.args.getlist('args')
    result_list = ''.join(args)
    try:
        proc = subprocess.run(['ps ' + result_list], shell=True, capture_output=True, text=True, check=True)
        return proc.stdout
    except subprocess.CalledProcessError as e:
        return e.stderr

    # с html-template для красивого вывода данных
    # try:
    #     proc = subprocess.run(['ps ' + result_list], shell=True, check=True, capture_output=True, text=True)
    #     output = proc.stdout
    #     error = proc.stderr
    # except subprocess.CalledProcessError as e:
    #     output=""
    #     error = e.stderr
    # return render_template('command_output.html', output=output, error=error)


if __name__ == "__main__":
    app.run(debug=True)
