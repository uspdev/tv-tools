import unittest
import datetime


from TV_autopower import dia_util, fica_desligado


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

    def test_fica_desligado(self):
        NO_POWER_ON = [
            (1, 2),
            (3, 4),
            (5, 6),
        ]
        um_fevereiro = datetime.date(2019, 2, 1)
        tres_abril = datetime.date(2019, 4, 3)
        oito_julho = datetime.date(2019, 7, 8)

        self.assertTrue(fica_desligado(um_fevereiro, NO_POWER_ON))
        self.assertTrue(fica_desligado(tres_abril, NO_POWER_ON))
        self.assertFalse(fica_desligado(oito_julho, NO_POWER_ON))




if __name__ == '__main__':
    unittest.main()
