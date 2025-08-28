"""
Ваш коллега, применив JsonAdapter из предыдущей задачи, сохранил логи работы его сайта за сутки
в файле skillbox_json_messages.log. Помогите ему собрать следующие данные:

1. Сколько было сообщений каждого уровня за сутки.
2. В какой час было больше всего логов.
3. Сколько логов уровня CRITICAL было в период с 05:00:00 по 05:20:00.
4. Сколько сообщений содержит слово dog.
5. Какое слово чаще всего встречалось в сообщениях уровня WARNING.
"""
import itertools
import logging
import re
import subprocess
from typing import Dict


def task1() -> Dict[str, int]:
    """
    1. Сколько было сообщений каждого уровня за сутки.
    @return: словарь вида {уровень: количество}
    """
    count_error_logs : Dict[str, int] = {}
    possible_levels = list(logging._levelToName.values())
    for level in possible_levels:
        b = subprocess.run(["grep", '-c', f'"level": "{level}"', 'skillbox_json_messages.log'],
                           capture_output=True, text=True)
        out = b.stdout
        count_error_logs[level] = int(out)
    return count_error_logs

def task2() -> int:
    """
    2. В какой час было больше всего логов.
    @return: час
    """
    most_logs_count = 0
    logs_hour_with_most_count = 0
    for hour in range(24):
        current_hour = str(hour) + ":0"
        all_logs_for_current_hour = subprocess.run(["grep", f'"time": "{current_hour}', 'skillbox_json_messages.log'],
                               capture_output=True, text=True)
        splitted_logs = all_logs_for_current_hour.stdout.splitlines()
        length_logs = len(splitted_logs)
        if length_logs > most_logs_count:
            most_logs_count = length_logs
            logs_hour_with_most_count = hour
    return logs_hour_with_most_count


def task3() -> int:
    """
    3. Сколько логов уровня CRITICAL было в период с 05:00:00 по 05:20:00.
    @return: количество логов


    """
    first_part_time =  subprocess.Popen(["grep", '"time": "05:0', "skillbox_json_messages.log"],
                        stdout=subprocess.PIPE, text=True)
    first_part_level = subprocess.Popen(["grep", '"level": "CRITICAL"'],
                       stdin=first_part_time.stdout, stdout=subprocess.PIPE, text=True)
    first_part_time_level = list(first_part_level.stdout)

    second_part_time = subprocess.Popen(["grep", '"time": "05:1', "skillbox_json_messages.log"],
                         stdout=subprocess.PIPE, text=True)
    second_part_level = subprocess.Popen(["grep", '"level": "CRITICAL"'],
                         stdin=second_part_time.stdout, stdout=subprocess.PIPE, text=True)
    second_part_time_level = list(second_part_level.stdout)

    combined = first_part_time_level + second_part_time_level

    return len(combined)

def task4() -> int:
    """
    4. Сколько сообщений содержат слово dog.
    @return: количество сообщений
    """
    # ищется все вхождения ИМЕННО dog
    all_logs_with_dog = subprocess.Popen(["grep", " dog ", "skillbox_json_messages.log"],
                         stdout=subprocess.PIPE, text=True)
    # если ищется все вхождения слова dog (имеется в виду такие, как "dog's")
    # all_logs_with_dog = subprocess.Popen(["grep", "-wr", "dog", "skillbox_json_messages.log"],
    #                      stdout=subprocess.PIPE, text=True)
    lines = list(all_logs_with_dog.stdout)
    return len(lines)

from collections import Counter

def task5() -> str:
    """
    5. Какое слово чаще всего встречалось в сообщениях уровня WARNING.
    @return: слово
    """
    a = subprocess.Popen(["grep", '"level": "WARNING"', "skillbox_json_messages.log"],
                       stdout=subprocess.PIPE, text=True)
    lines = list(a.stdout)
    new_text = ""
    for line in lines:
        index = line.find('"message":')
        b = len('"message":')
        new_text += line[index+b:]
    new_text = new_text.replace("\n", " ")
    new_text = new_text.replace("}", "")
    words = re.findall(r'b[aA-zZ]+b', new_text)
    word_counts = Counter(words)
    most_common_word = word_counts.most_common(1)[0][0]
    # count = word_counts.most_common(1)[0][1]
    return most_common_word

if __name__ == '__main__':
    tasks = (task1, task2, task3, task4, task5)
    for i, task_fun in enumerate(tasks, 1):
        task_answer = task_fun()
        print(f'{i}. {task_answer}')
