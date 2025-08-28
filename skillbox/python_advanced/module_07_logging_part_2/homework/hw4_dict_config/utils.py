
from typing import Union, Callable
from operator import sub, mul, truediv, add
import logging.config
from logger_config import dict_config

logging.config.dictConfig(dict_config)

logger = logging.getLogger("module_logger.utils")
logger.setLevel("DEBUG")

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
        logger.error("wrong operator type", value)
        raise ValueError("wrong operator type")

    if value not in OPERATORS:
        logger.error("wrong operator value", value)
        raise ValueError("wrong operator value")

    return OPERATORS[value]
