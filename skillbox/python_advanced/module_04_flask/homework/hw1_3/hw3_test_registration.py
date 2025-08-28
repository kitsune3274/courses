"""
Для каждого поля и валидатора в эндпоинте /registration напишите юнит-тест,
который проверит корректность работы валидатора. Таким образом, нужно проверить, что существуют наборы данных,
которые проходят валидацию, и такие, которые валидацию не проходят.
"""
import unittest
from hw1_registration import app

class TestTasks(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        app.config['DEBUG'] = False
        app.config["WTF_CSRF_ENABLED"] = False
        self.app = app.test_client()
        self.base_url = '/registration'

    fields = {
        'email': '123@mail.ru',
        'phone': 7_900_000_001,
        'name': 'artem',
        'address': 'moscow',
        'index': 123456,
        'comment': 'abc'
    }

    def test_path_registration(self):
        """
        проверка корректности пути
        """
        response = self.app.post(self.base_url, data=self.fields)
        self.assertEqual(response.request.path, '/registration')

    def test_correct_registration(self):
        """
        проверка успешной регистрации
        """
        response = self.app.post(self.base_url, data=self.fields)
        response_text = response.data.decode()
        expected_test = 'Successfully registered user 123@mail.ru with phone +77900000001'
        self.assertEqual(response_text, expected_test)

    def test_incorrect_email(self):
        """
        проверка неверно введенных данных в email
        >пустая строка (необходимость любых данных)
        >число (необходимы буквы/символы)
        >неправильный email (не по стандартному шаблону))
        """
        incorrect_emails = ('', 123, 'abc.com')
        for item in incorrect_emails:
            with self.subTest(item=item):
                email = {'email': item}
                self.fields.update(email)
                response = self.app.post(self.base_url, data=self.fields)
                response_text = response.data.decode()
                self.assertIn('Invalid', response_text)

    def test_incorrect_phone(self):
        """
        проверка неправильно введенных данных в телефон:
        >пустая строка (необходимость любых данных)
        >символы(буквы итд) (необходимость ввода чисел)
        >количество символом больше максимального
        > -//- минимального
        """
        incorrect_phone = ('', 'abc', '99999999999', 999)
        for item in incorrect_phone:
            with self.subTest(item=item):
                phone = {'phone': item}
                self.fields.update(phone)
                response = self.app.post(self.base_url, data=self.fields)
                response_text = response.data.decode()
                self.assertIn('Invalid', response_text)

    def test_incorrect_name(self):
        """
        проверка неправильно введенных данных в имя:
        >пустая строка (необходимость любых данных)
        """
        self.fields.update({'name': ''})
        response = self.app.post(self.base_url, data=self.fields)
        response_text = response.data.decode()
        self.assertIn('Invalid', response_text)

    def test_incorrect_address(self):
        """
        проверка неправильно введенных данных в адрес:
        >пустая строка (необходимость любых данных)
        """
        self.fields.update({'address': ''})
        response = self.app.post(self.base_url, data=self.fields)
        response_text = response.data.decode()
        self.assertIn('Invalid', response_text)

    def test_incorrect_index(self):
        """
        проверка неправильно введенных данных в индекс:
        >пустая строка (необходимость любых данных)
        >символы/буквы (необходимость ввода чисел)
        """
        incorrect_indexes = ('', 'abc')
        for item in incorrect_indexes:
            with self.subTest(item=item):
                index = {'index': item}
                self.fields.update(index)
                response = self.app.post(self.base_url, data=self.fields)
                response_text = response.data.decode()
                self.assertIn('Invalid', response_text)

    def test_correct_response_with_comment(self):
        """
        проверка корректность вывода с комментарием (комментарий - необязателен, и может быть любой строкой/итд)

        """
        comments = ('', 'abc', 123)
        for item in comments:
            with self.subTest(item=item):
                self.fields.update({'comment': item})
                response = self.app.post(self.base_url, data=self.fields)
                response_text = response.data.decode()
                self.assertIn("Successfully registered", response_text)


    def test_correct_registration_with_new_number_length(self):
        response = self.app.post(self.base_url, data=self.fields)
        response_text = response.data.decode()
        expected_text = f'Successfully registered user 123@mail.ru with phone +77900000001'
        self.assertEqual(response_text, expected_text)


if __name__ == "__main__":
    unittest.main()
