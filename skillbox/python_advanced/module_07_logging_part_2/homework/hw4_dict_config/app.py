import logging.config
import sys
from utils import string_to_operator
from logger_config import dict_config

logging.config.dictConfig(dict_config)
logger = logging.getLogger("module_logger.app")
logger.setLevel("DEBUG")


def calc(args):

    logger.debug(f"Arguments: {args}")

    num_1 = args[0]
    operator = args[1]
    num_2 = args[2]

    try:
        num_1 = float(num_1)
    except ValueError as e:
        logger.error("Error while converting number 1")
        logger.error(e)

    try:
        num_2 = float(num_2)
    except ValueError as e:
        logger.error("Error while converting number 2")
        logger.error(e)

    operator_func = string_to_operator(operator)

    result = operator_func(num_1, num_2)

    logger.debug(f"Result: {result}")
    logger.debug(f"{num_1} {operator} {num_2} = {result}")


if __name__ == '__main__':
    # calc(sys.argv[1:])
    calc('2+3')
