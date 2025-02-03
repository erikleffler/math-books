-- Ch3.1

S = ZZ[x, y, z]
X = Spec S
f = x

-- Part(1)
e = {
	x + y + z,
	x*y + y*z + x*z,
	x*y*z
}

elementaryBasis = ideal e
saturate(elementaryBasis, f)

-- Part(2)
p = {
	x + y + z,	
	x^2 + y^2 + z^2,	
	x^3 + y^3 + z^3	
}
ideal(1_S) == saturate(ideal p, f)

-- Part(2.2)
kk = ZZ/55
S = kk[x, y, z]
X = Spec S
f = x

p = {
	x + y + z,	
	x^2 + y^2 + z^2,	
	x^3 + y^3 + z^3	
}
ideal(1_S) == saturate(ideal p, f)

clearAll

S = QQ[x, y, z, a..j, MonomialOrder => Eliminate 2];

F = a*x^3+b*x^2*y+c*x^2*z+d*x*y^2+e*x*y*z+f*x*z^2+g*y^3+h*y^2*z+i*y*z^2+j*z^3;
partials = submatrix(jacobian F, {0,1,2}, {0})

singularities = ideal(F) + ideal(partials)
elimDiscr = time ideal selectInSubring(1,gens gb singularities);
elimDiscr = substitute(elimDiscr, {z => 1});
#gens elimDiscr
(res elimDiscr).dd_1
