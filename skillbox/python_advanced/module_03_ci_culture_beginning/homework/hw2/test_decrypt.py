import unittest

from decrypt import decrypt

class TestDecrypt(unittest.TestCase):
    def test_with_only_one_dot(self):
        one_dot = {
            'абра-кадабра.' : 'абра-кадабра',
            '.' : ''
        }
        for key in one_dot.keys():
            with self.subTest():
                expected_result = one_dot[key]
                response_result = decrypt(key)
                self.assertEqual(expected_result, response_result)

    def test_with_only_two_dots(self):
        two_dots = {
            'абраа..-кадабра' : 'абра-кадабра',
            'абра--..кадабра' : 'абра-кадабра'
        }
        for key in two_dots.keys():
            with self.subTest():
                expected_result = two_dots[key]
                response_result = decrypt(key)
                self.assertEqual(expected_result, response_result)

    def test_with_only_several_dots(self):
        several_dots = {
            'абраа..-.кадабра' : 'абра-кадабра',
            'абрау...-кадабра' : 'абра-кадабра',
            'абра........' : '',
            'абр......a.' : 'a',
            '1..2.3' : '23',
            '1.......................' : ''
        }
        for key in several_dots.keys():
            with self.subTest():
                expected_result = several_dots[key]
                response_result = decrypt(key)
                self.assertEqual(expected_result, response_result)

if __name__ == "__main__":
    unittest.main()