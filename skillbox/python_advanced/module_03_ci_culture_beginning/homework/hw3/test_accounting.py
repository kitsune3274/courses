import unittest

from accounting import storage, app, calculate_year, calculate_month


class TestUnit(unittest.TestCase):
    def setUp(self):
        storage.update(
            {1997:
                    {2: {25: 1, 22: 1, 'total_month': 2},
                     3:{30: 1,'total_month': 1},
                     'total_year': 3
                    },
             1999:
                    {1:{11: 1, 12: 1, 'total_month': 2},
                     12:{22: 1,'total_month': 1},
                     'total_year': 3
                    },
             2099:
                 {1: {30: 2, 23: 2, 'total_month': 4},
                  9: {11: 5, 22: 10, 'total_month': 15},
                  'total_year': 19
                 }
            }
        )
        app.config['TESTING'] = True
        app.config['DEBUG'] = False
        self.app = app.test_client()
        self.url_add = '/add/'
        self.url_calculate = '/calculate/'

    def test_add_1(self):
        date = '10090912'
        number = 12
        tuple_d_n = (date, number)
        url = self.url_add + '/'.join(str(i) for i in tuple_d_n)
        response = self.app.get(url)
        # response_text = response.data.decode()
        # result = 'Данные добавлены'
        # self.assertEqual(result, response_text)
        self.assertEqual(storage[1009][9][12], 12)

    def test_add_2(self):
        date = '10110720'
        number = 20
        tuple_date_number = (date, number)
        url = self.url_add + '/'.join(str(i) for i in tuple_date_number)
        self.app.get(url)
        self.assertEqual(storage[1011][7][20], 20)

    def test_add_3(self):
        date = '20110221'
        number = 99999
        tuple_date_number = (date, number)
        url = self.url_add + '/'.join(str(i) for i in tuple_date_number)
        self.app.get(url)
        self.assertEqual(storage[2011][2][21], 99999)

    def test_calculate_year_1(self):
        year = 1999
        url = self.url_calculate + str(year)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_year(year)
        result = "Траты за 1999 год: 3"
        self.assertEqual(result, response_text)

    def test_calculate_year_2(self):
        year = 1997
        url = self.url_calculate + str(year)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_year(year)
        result = "Траты за 1997 год: 3"
        self.assertEqual(result, response_text)

    def test_calculate_year_3(self):
        year = 2099
        url = self.url_calculate + str(year)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_year(year)
        result = "Траты за 2099 год: 19"
        self.assertEqual(result, response_text)

    def test_calculate_month_1(self):
        year = 1999
        month = 12
        tuple_year_month = (year, month)
        url = self.url_calculate + "/".join(str(i) for i in tuple_year_month)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_month(year, month)
        result = "Траты за 12 месяц 1999 года: 1"
        self.assertEqual(result, response_text)

    def test_calculate_month_2(self):
        year = 1997
        month = 3
        tuple_year_month = (year, month)
        url = self.url_calculate + "/".join(str(i) for i in tuple_year_month)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_month(year, month)
        result = "Траты за 3 месяц 1997 года: 1"
        self.assertEqual(result, response_text)

    def test_calculate_month_3(self):
        year = 2099
        month = 9
        tuple_year_month = (year, month)
        url = self.url_calculate + "/".join(str(i) for i in tuple_year_month)
        response = self.app.get(url)
        response_text = response.data.decode()
        calculate_month(year, month)
        result = "Траты за 9 месяц 2099 года: 15"
        self.assertEqual(result, response_text)

    # если в accounting.py убрать try: .. except: .. в функции save_info
    # тогда поймаем ошибку, иначе вместе с try: .. except ..
    # этот тест не будет пройден
    def test_add_raises_exception(self):
        url = self.url_add + '1a110233/30'
        with self.assertRaises(ValueError):
            self.app.get(url)

    def test_calculate_with_empty(self):
        url = self.url_calculate + '9999'
        response = self.app.get(url)
        response_text = response.data.decode()
        self.assertEqual('Нету данных на этот год', response_text)

if __name__ == "__main__":
    unittest.main()


