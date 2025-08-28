import datetime
import random
import os
from flask import Flask

app = Flask(__name__)


@app.route('/hello_world')
def hello_world():
    return 'Hello World!'

cars: list = ['Chevrolet', 'Renault', 'Ford', 'Lada']

@app.route('/cars')
def print_all_cars():
    return ",".join(cars)

cat = ['корниш-рекс', 'русская голубая', 'шотландская вислоухая', 'мейн-кун', 'манчкин']

@app.route('/cats')
def print_all_cats():
    return random.choice(cat)



@app.route('/get_time/now')
def current_time():
    user_curr_time = datetime.datetime.now()
    return 'Точное время: {curr_time}'.format(
        curr_time=user_curr_time
    )



@app.route('/get_time/future')
def future_time():
    user_future_time = datetime.datetime.now() + datetime.timedelta(hours=1)
    return 'Точное время через час будет: {fut_time}'.format(
        fut_time=user_future_time
    )


class FileIsEmpty(Exception):
    pass

def get_word():
    try:
        with open("war_and_peace.txt", "r") as file:
            text = file.read()
            words_from_text = text.split()
        return words_from_text
    except FileNotFoundError:
        return "Файл не найден"

words = get_word()

def random_word():
    if words == "Файл не найден":
        return words
    try:
        if words:
            return random.choice(words)
        else:
            raise FileIsEmpty
    except FileIsEmpty:
        return "Файл пуст."

@app.route('/get_random_word')
def get_random_word():
    return random_word()


@app.route('/counter')
def counter():
    counter.visits += 1
    return str(counter.visits)

counter.visits = 0


if __name__ == '__main__':
    app.run(debug=True)
