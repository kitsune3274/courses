"""
У нас есть кнопочный телефон (например, знаменитая Nokia 3310), и мы хотим,
чтобы пользователь мог проще отправлять СМС. Реализуем своего собственного клавиатурного помощника.

Каждой цифре телефона соответствует набор букв:
* 2 — a, b, c;
* 3 — d, e, f;
* 4 — g, h, i;
* 5 — j, k, l;
* 6 — m, n, o;
* 7 — p, q, r, s;
* 8 — t, u, v;
* 9 — w, x, y, z.

Пользователь нажимает на клавиши, например 22736368, после чего на экране печатается basement.

Напишите функцию my_t9, которая принимает на вход строку, состоящую из цифр 2–9,
и возвращает список слов английского языка, которые можно получить из этой последовательности цифр.
"""
import re
from typing import List

T9_DATA = {
    2: "abc",
    3: "def",
    4: "ghi",
    5: "jkl",
    6: "mno",
    7: "pqrs",
    8: "tuv",
    9: "wxyz"
}

with open("/usr/share/dict/words") as file:
    WORDS_LIST = [word.strip() for word in file.readlines()]


def my_t9(input_numbers: str) -> List[str]:
    """
    Преобразование строки, состоящей из цифр от 2 до 9, во все возможные слова
    Parameters:
        input_numbers: str
            список цифр
    Returns:
        список возможных слов
    """
    if not input_numbers:
        return []

    if "1" in input_numbers:
        print("В строке должны находится цифры от 2 до 9")
        return []

    letters = map(lambda c: "[" + T9_DATA[int(c)] + "]", input_numbers)
    regex = "^" + "".join(letters) + "$"
    return [w.strip() for w in WORDS_LIST if re.search(regex, w, re.IGNORECASE)]

    # для этого нужно T9_DATA в виде Dict(int, list), где lit вида ["a", "b", "c"], но времени занимает больше
    # def generate_combinations(digits, current_word):
    #     if not digits:
    #         return [current_word] if current_word in WORDS_LIST else []
    #     digit = int(digits[0])
    #     possibilities = T9_DATA[digit]
    #     results = []
    #     for char in possibilities:
    #         results.extend(generate_combinations(digits[1:], current_word + char))
    #     return results
    #
    # input_numbers = input_numbers.strip()
    # if not input_numbers:
    #     return []
    #
    # return [word for word in generate_combinations(input_numbers, "") if word in WORDS_LIST]


if __name__ == '__main__':
    numbers: str = input("Введите набор букв: ")
    words: List[str] = my_t9(numbers)
    print(*words, sep='\n')
