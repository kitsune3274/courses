import inspect
import unittest

from remote_execution import app

class TestTask(unittest.TestCase):

    @classmethod
    def setUp(cls):
        app.config['TESTING'] = True
        app.config['DEBUG'] = False
        cls.app = app.test_client()
        app.config["WTF_CSRF_ENABLED"] = False
        cls.base_url = '/run_code'

        input_values = {
            'code' : 'print("Hello world")',
            'timeout' : 5
        }

        cls.input_values = input_values

    def test_correct_url(self):
        """
        проверка корректности пути
        """
        response = self.app.post(self.base_url, data=self.input_values)
        self.assertEqual(response.request.path, '/run_code')

    def test_correct_run_code(self):
        """
        проверка выполнения кода на python
        """
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        expected_text = f'Result:\nHello world\n'
        self.assertEqual(response_text, expected_text)

    def test_correct_run_code_from_py(self):
        """
        проверка выполнения .py файла
        """
        self.input_values.update({'code': 'goodcode.py'})
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        expected_text = f'Result:\nHello world 0\n'
        self.assertIn(expected_text, response_text)

    def test_empty_code_field(self):
        """
        проверка передачи пустого поля code
        """
        self.input_values.update({'code': ""})
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        expected_text = f"Result:\nThere's no input."
        self.assertEqual(response_text, expected_text)

    def test_incorrect_timeout(self):
        """
        проверка если timeout не число
        """
        self.input_values.update({'timeout': 'а'})
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        self.assertIn('Invalid', response_text)

    def test_out_of_range_timeout(self):
        """
        выход за границы timeout (from 0 to 30)
        """
        out_of_range = (-1, 55)
        for item in out_of_range:
            with self.subTest(item=item):
                self.input_values.update({'timeout': item})
                response = self.app.post(self.base_url, data=self.input_values)
                response_text = response.data.decode()
                expected_text = f"Result:\nInput time-out must be between 0 and 30"
                self.assertEqual(response_text,expected_text)

    def test_called_time_out_exception(self):
        """
        проверка если код выполняется дольше, чем timeout
        """
        self.input_values.update({'code': 'longcode.py'})
        print(f'Testing: wait {self.input_values['timeout']} sec')
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        expected_text = f"Result:\nTime-out expired"
        self.assertEqual(response_text, expected_text)

    def test_incorrect_py_file_name(self):
        """
        проверка если не существует/нет доступа к файлу .py
        """
        self.input_values.update({'code': 'task.py'})
        response = self.app.post(self.base_url, data=self.input_values)
        response_text = response.data.decode()
        self.assertIn('[Errno 2]', response_text)

    @classmethod
    def tearDown(cls):
        del cls.input_values

if __name__ == "__main__":
    unittest.main()
