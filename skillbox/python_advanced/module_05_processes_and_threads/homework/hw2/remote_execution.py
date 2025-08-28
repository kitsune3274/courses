"""
Напишите эндпоинт, который принимает на вход код на Python (строка)
и тайм-аут в секундах (положительное число не больше 30).
Пользователю возвращается результат работы программы, а если время, отведённое на выполнение кода, истекло,
то процесс завершается, после чего отправляется сообщение о том, что исполнение кода не уложилось в данное время.
"""

from flask import Flask
from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField
from subprocess import run, CalledProcessError, TimeoutExpired
app = Flask(__name__)


class CodeForm(FlaskForm):
    code = StringField()
    timeout = IntegerField()


def run_python_code_in_subproccess(code: str, timeout: int):
    """
    Выполнение переданного кода на Python в параметре code
    Parameters:
        code: str
            переданный код на питон (сам код или .py файл)
        timeout: str
            время (в секундах), через которое прекращается выполнение программы в code
    Returns:
        результат выполнение программы
    Raises:
        TimeoutExpired
            если время выполнения программы превысило timeout
    """
    if not code:
        return "There's no input."
    if timeout > 30 or timeout < 0:
        return 'Input time-out must be between 0 and 30'

    try:
        if code.endswith('.py'):
            proc = run(['python', code], timeout=timeout, capture_output=True, text=True)
        else:
            proc = run(['python', '-c', code], timeout=timeout, capture_output=True, text=True)
        if proc.stderr:
            return proc.stderr
        elif proc.stdout:
            return proc.stdout
    except CalledProcessError as e:
        return e.stderr
    except TimeoutExpired:
        return 'Time-out expired'

@app.route('/run_code', methods=['POST'])
def run_code():
    form = CodeForm()

    if form.validate_on_submit():
        code, timeout = form.code.data, form.timeout.data
        return f'Result:\n{run_python_code_in_subproccess(code, timeout)}'

    return f'Invalid input, {form.errors}', 400


if __name__ == '__main__':
    app.config["WTF_CSRF_ENABLED"] = False
    app.run(debug=True)
