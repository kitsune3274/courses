"""
1. Сконфигурируйте логгер программы из темы 4 так, чтобы он:

* писал логи в файл stderr.txt;
* не писал дату, но писал время в формате HH:MM:SS,
  где HH — часы, MM — минуты, SS — секунды с ведущими нулями.
  Например, 16:00:09;
* выводил логи уровня INFO и выше.

2. К нам пришли сотрудники отдела безопасности и сказали, что, согласно новым стандартам безопасности,
хорошим паролем считается такой пароль, который не содержит в себе слов английского языка,
так что нужно доработать программу из предыдущей задачи.

Напишите функцию is_strong_password, которая принимает на вход пароль в виде строки,
а возвращает булево значение, которое показывает, является ли пароль хорошим по новым стандартам безопасности.
"""


import getpass
import hashlib
import logging
# Если возникает ошибка LookUpError, то нужно запустить download_nltk_data.py
import nltk
nltk.download('words')
from nltk.corpus import words

logger = logging.getLogger("password_checker")


def is_strong_password(password: str) -> bool:
    """
    Проверка пароля по новым стандартам (хороший пароль = нет английский слов в пароле)
    Parameters:
         password: str
            проверяемый пароль
    Returns:
        True - пароль слабый
        False - пароль хороший
    """
    english_words = set(w.lower() for w in words.words())
    # вариант без nltk
    # with open("/usr/share/dict/words") as file:
    #     english_words = [word.strip().lower() for word in file.readlines()]
    cleaned_text = password.lower()

    all_variants = []
    # получаем все найденные варианты слов, состоящие из минимум 4 букв
    for i in range(len(cleaned_text) - 1):
        for j in range(i + 4, len(cleaned_text) + 1):
            all_variants.append(cleaned_text[i:j])

    # нужно для подсчета количества найденных слов, если 0, то в logger.ERROR
    words_found = 0

    # цикл по всем словам, если такое слово на англ есть, то в logger.INFO, иначе пропускаем
    for word in all_variants:
        if word in english_words:
            logger.info(f'{word} found in {cleaned_text}')
            words_found += 1

    if words_found == 0:
        logger.error("Не найдено никаких слов.")
        return False

    return True


def input_and_check_password() -> bool:
    logger.debug("Начало input_and_check_password")
    password: str = getpass.getpass()

    if not password:
        logger.warning("Вы ввели пустой пароль.")
        return False
    elif is_strong_password(password):
        logger.warning("Вы ввели слишком слабый пароль")
        return False
    else:
        logger.info("Пароль хороший по новым стандартам.")


    try:
        hasher = hashlib.md5()

        hasher.update(password.encode("latin-1"))

        if hasher.hexdigest() == "098f6bcd4621d373cade4e832627b4f6":
            return True
    except ValueError as ex:
        logger.exception("Вы ввели некорректный символ ", exc_info=ex)

    return False


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, filename="stderr.txt",
                        format='%(asctime)s %(levelname)-8s %(name)-15s %(message)s',
                        datefmt='%H:%M:%S')
    logger.info("Вы пытаетесь аутентифицироваться в Skillbox")
    count_number: int = 3
    logger.info(f"У вас есть {count_number} попыток")

    while count_number > 0:
        if input_and_check_password():
            exit(0)
        count_number -= 1

    logger.error("Пользователь трижды ввёл не правильный пароль!")
    exit(1)
