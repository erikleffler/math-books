import sage.all
from sage.rings.rational_field import QQ
from sage.rings.polynomial.polynomial_ring_constructor import PolynomialRing



def ex2_17(): 
    R = PolynomialRing(QQ, ["x_1", "x_2", "x_3"])
    x1, x2, x3 = R.gens()

    f1 = x1 - x2 * x3
    f2 = x1 * x3 - x2 ** 2
    
    J = R * [f1, f2]

    for Q in J.primary_decomposition():
        print(Q.radical().gens())

ex2_17()


