import logging
from logging import getLogger
from typing import Union, Callable
from operator import sub, mul, truediv, add

logger = getLogger("utils")
logger.setLevel("ERROR")

logger_handler = logging.StreamHandler()
logger.addHandler(logger_handler)


OPERATORS = {
    '+': add,
    '-': sub,
    '*': mul,
    '/': truediv,
}

Numeric = Union[int, float]


def string_to_operator(value: str) -> Callable[[Numeric, Numeric], Numeric]:
    """
    Convert string to arithmetic function
    :param value: basic arithmetic function
    """
    if not isinstance(value, str):
        logger.error(f"wrong operator type {value}")
        # print("wrong operator type", value)
        raise ValueError("wrong operator type")

    if value not in OPERATORS:
        logger.error(f"wrong operator type {value}")
        # print("wrong operator value", value)
        raise ValueError("wrong operator value")

    return OPERATORS[value]
