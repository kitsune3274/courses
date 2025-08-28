import unittest

from person import Person

class TestTaskFour(unittest.TestCase):
    def setUp(self):
        self.person = Person("Павел", 1990, 'Владивосток')

    def test_get_current_age(self):
        self.assertEqual(self.person.get_age(), 35)

    def test_get_name(self):
        self.assertEqual(self.person.get_name(), 'Павел')

    def test_set_name(self):
        self.person.set_name('Кирилл')
        self.assertEqual(self.person.get_name(), 'Кирилл')

    def test_get_address(self):
        self.assertEqual(self.person.get_address(), "Владивосток")

    def test_set_address(self):
        self.person.set_address('Омск')
        self.assertEqual(self.person.get_address(), "Омск")

    def test_is_homeless_false(self):
        self.assertFalse(self.person.is_homeless())

    def test_is_homeless_true(self):
        self.person.set_address('')
        self.assertTrue(self.person.is_homeless())

if __name__ == "__main__":
    unittest.main()