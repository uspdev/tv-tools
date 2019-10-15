import unittest
import datetime


from TV_autopower import dia_util


class TestAutopower(unittest.TestCase):

    def test_dia_util(self):
        segunda = datetime.date(2019, 10, 14)
        terca = datetime.date(2019, 10, 15)
        quarta = datetime.date(2019, 10, 16)

        self.assertTrue(dia_util(segunda))
        self.assertTrue(dia_util(terca))
        self.assertTrue(dia_util(quarta))

    def test_fim_de_semana(self):
        sabado = datetime.date(2019, 10, 20)
        domingo = datetime.date(2019, 10, 19)

        self.assertFalse(dia_util(sabado))
        self.assertFalse(dia_util(domingo))




if __name__ == '__main__':
    unittest.main()
