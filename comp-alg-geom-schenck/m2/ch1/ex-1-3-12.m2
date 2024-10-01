clearAll

R = QQ[x, y, z]

I = ideal(y^2 + y*z, x^2 - x*z, x^2 - z^2)

Q_0 = ideal(y + z, x - z)
Q_1 = ideal(y, x - z)
Q_2 = ideal(x*z, x^2, z^2, y^2 + y*z)

J = intersect(Q_0, Q_1, Q_2)

<< I == J << endl

<< primaryDecomposition I << endl
<< primaryDecomposition J << endl
