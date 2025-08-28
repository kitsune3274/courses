"""
Довольно неудобно использовать встроенный валидатор NumberRange для ограничения числа по его длине.
Создадим свой для поля phone. Создайте валидатор обоими способами.
Валидатор должен принимать на вход параметры min и max — минимальная и максимальная длина,
а также опциональный параметр message (см. рекомендации к предыдущему заданию).
"""
from typing import Optional
from flask_wtf import FlaskForm
from wtforms import Field
from wtforms.validators import ValidationError


def number_length(min: int, max: int, message: Optional[str] = None):
    """
    Проверяет корректность длины входящий данных
    Parameters:
        min: int
            минимальная длина
        max: int
            максимальная длина
        message: Optional[str] = None
            сообщение об ошибке (опциональное)
    Raises:
        ValidationError()
            выводит ошибку валидации с сообщением message
    """
    if not message:
        message = f"Неккоректный ввод телефона, минимальное количество символов {min}, максимальное - {max}"

    def _length(form: FlaskForm, field: Field):
        data = field.data
        if len(str(data)) > max or len(str(data)) < min:
            raise ValidationError(message)

    return _length



class NumberLength:
    """
    При вызове класс проверяет корректность длины входящих данных
    Attributes:
        min: int
            минимальная длина
        max: int
            максимальная длина
        message: Optional[str] = None
            сообщение об ошибке (опциональное)
    """
    def __init__(self, min: int, max: int, message: Optional[str] = None):
        self.min = min
        self.max = max
        if not message:
            message = f"Неккоректный ввод телефона, минимальное количество символов {min}, максимальное - {max}"
        self.message = message

    def __call__(self, form: FlaskForm, field: Field ):
        data = field.data
        if len(str(data)) > self.max or len(str(data)) < self.min:
            raise ValidationError(self.message)


