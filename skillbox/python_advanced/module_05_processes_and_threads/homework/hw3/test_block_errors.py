import unittest
from block_errors import BlockErrors

class TestTask(unittest.TestCase):

    @classmethod
    def setUp(cls):
        pass

    def test_successful_run(self):
        """
        проверка корректного выполнения кода
        """
        with BlockErrors({FileNotFoundError}):
            f = open('abc.txt', 'r')

    def test_incorrect_run(self):
        """
        проверка если получили любое исключение (BlockErrors пуста)
        """
        try:
            with BlockErrors({}):
                f = open('abc.txt', 'r')
        except Exception:
            pass


    def test_raises_other_error(self):
        """
        проверка если получили иное исключение
        """
        with self.assertRaises(TypeError):
            with BlockErrors({ZeroDivisionError}):
                a = 1 / '0'
            print('OK')

    def test_inner_block_outer_block_exceptions(self):
        """
        проверка если выкидывается неожиданный тип исключения и он прокидывается выше (пропускается(?))
        """
        with self.assertRaises(FileNotFoundError):
            with BlockErrors({}):
                with BlockErrors({TypeError}):
                    f = open('abc.txt', 'r')
                print("Inner block")
            print('Outer Block')

    @classmethod
    def tearDown(cls):
        pass

if __name__ == "__main__":
    unittest.main()

