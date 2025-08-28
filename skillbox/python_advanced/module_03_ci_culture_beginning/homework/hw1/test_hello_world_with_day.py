import unittest
from datetime import datetime
from freezegun import freeze_time

from hello_word_with_day import app

def get_current_day():
    greetings = (
        'Хорошего понедельника',
        'Хорошего вторника',
        'Хорошей среды',
        'Хорошего четверга',
        'Хорошей пятницы',
        'Хорошей субботы',
        'Хорошего воскресенья'
    )
    return greetings[datetime.today().weekday()]

class TestTaskOne(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        app.config['DEBUG'] = False
        self.app = app.test_client()
        self.base_url = '/hello-world/'

    def test_can_get_correct_max_number_in_series_of_two(self):
        username = 'username'
        response = self.app.get(self.base_url + username)
        response_text = response.data.decode()
        self.assertTrue(username in response_text)

    # вдобавок и тестирование дня недели - четверг
    def test_correct_current_weekday(self):
        weekday = get_current_day()
        username = "Хорошего четверга"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-21')
    def test_monday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-22')
    def test_tuesday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-23')
    def test_wednesday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-25')
    def test_friday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-26')
    def test_saturday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

    @freeze_time('2025-07-27')
    def test_sunday(self):
        weekday = get_current_day()
        username = "Павел"
        response = self.app.get(self.base_url + username)
        expected_result = f'Привет, {username}. {weekday}!'
        response_test = response.data.decode()
        self.assertEqual(expected_result, response_test)

if __name__ == "__main__":
    unittest.main()