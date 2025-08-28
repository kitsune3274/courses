from dict_config import dict_config
import logging.config

logging.config.dictConfig(dict_config)
logger = logging.getLogger("appLogger")

logger.debug("DEBUG message")
logger.info("INFO message")
logger.warning("WARNING message")
logger.error("ERROR message")