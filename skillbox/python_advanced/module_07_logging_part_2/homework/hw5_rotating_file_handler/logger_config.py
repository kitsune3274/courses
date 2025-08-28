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
            "class": "logging.handlers.TimedRotatingFileHandler",
            "when": "H",
            "interval": 10,
            "backupCount": 3,
            "formatter": "base",
            "level": "INFO",
            "filename": "utils.log",
        }
    },
    "loggers": {
        "module_logger": {
            "level": "INFO",
            "handlers": ["file", "console"],
        #   "propagate": False
        }
    },
    # "filters": {},
    # "root": {} # == "": {}
}