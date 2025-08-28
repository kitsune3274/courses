import unittest
from redirect import Redirect

class TestRedirect(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.stdout_text = 'Hello stdout'
        cls.stderr_text = 'Hello stderr'

    def test_correct_stdout_redirect(self):
        """
        проверка перехвата потока print
        """
        with open('test_correct_stdout.txt', 'w') as f:
            with Redirect(stdout=f):
                print(self.stdout_text)
        with open('test_correct_stdout.txt', 'r') as f:
            stdout = f.read()
        self.assertTrue(self.stdout_text in stdout)

    def test_correct_stderr_redirect(self):
        """
        Проверка перехвата потока исключения
        """
        with open('test_correct_stderr.txt', 'w') as f:
            with Redirect(stderr=f):
                raise Exception(self.stderr_text)
        with open('test_correct_stderr.txt', 'r') as f:
            stderr = f.read()
        self.assertTrue(self.stderr_text in stderr)

    def test_correct_both_stdout_stderr_redirect(self):
        """
        Проверка перехвата обоих потоков
        """
        with open('test_correct_stdout_both.txt', 'w') as f1, open('test_correct_stderr_both.txt', 'w') as f2:
            with Redirect(f1, f2):
                print(self.stdout_text)
                raise Exception(self.stderr_text)
        with open('test_correct_stdout_both.txt', 'r') as f1, open('test_correct_stderr_both.txt', 'r') as f2:
            stdout = f1.read()
            stderr = f2.read()

        self.assertTrue(self.stdout_text in stdout)
        self.assertTrue(self.stderr_text in stderr)

    def test_correct_stdout_stderr_not_present(self):
        """
        Тест ложится, но файлы test_correct_stdout_both_not и test_correct_stderr_both_not
        не перехватывают потоки
        """
        with open('test_correct_stdout_both_not.txt', 'w') as f1, open('test_correct_stderr_both_not.txt', 'w') as f2:
            with Redirect():
                print(self.stdout_text)
                raise Exception(self.stderr_text)
        with open('test_correct_stderr_both_not.txt', 'r') as f1, open('test_correct_stderr_both_not.txt', 'r') as f2:
            stdout = f1.read()
            stderr = f2.read()

        self.assertFalse(self.stdout_text in stdout)
        self.assertFalse(self.stderr_text in stderr)

    @classmethod
    def tearDownClass(cls):
        del cls.stderr_text
        del cls.stdout_text



if __name__ == '__main__':
    unittest.main()
    # with open('test_results.txt', 'a') as test_file_stream:
    #     runner = unittest.TextTestRunner(stream=test_file_stream)
    #     unittest.main(testRunner=runner)
