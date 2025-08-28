import logging.config
import sys

class LevelFileHandler(logging.Handler):

    def __init__(self, file_name, mode="a"):
        super().__init__()
        self.file_name = file_name
        self.mode = mode

    def emit(self, record: logging.LogRecord) -> None:
        message = self.format(record)

        if record.levelname == "DEBUG":
            self.file_name = "calc_debug.log"
        elif record.levelname == "ERROR":
            self.file_name = "calc_error.log"

        with open(self.file_name, mode=self.mode) as file:
            file.write(message + "\n")

def get_logger(name):
    logging.config.dictConfig(dict_config)
    logger = logging.getLogger(f"module_logger.{name}")
    return logger

dict_config = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "base": {
            "format": "%(levelname)s | %(name)s | %(asctime)s | %(lineno)d | %(message)s"
        }
    },
    "handlers" : {
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "base"
        },
        "file":{
            "()": LevelFileHandler,
            "level": "DEBUG",
            "formatter": "base",
            "file_name": "logfile.log",
            "mode": "a"
        }
    },
    "loggers": {
        "module_logger": {
            "level": "DEBUG",
            "handlers": ["file", "console"],
        #   "propagate": False
        }
    },
    # "filters": {},
    # "root": {} # == "": {}
}
