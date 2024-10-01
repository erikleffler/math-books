clearAll

R = QQ[x, y, z]
I = ideal(x^2 - x*z, y^3 - y*z^2)
<< hilbertPolynomial I << endl;
<< primaryDecomposition I << endl;
