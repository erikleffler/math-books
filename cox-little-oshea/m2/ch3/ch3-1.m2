

-- Ex 2
clearAll;

Rxy = QQ[x, y, MonomialOrder=>Lex]
Ryx = QQ[y, x, MonomialOrder=>Lex]
fs = {
	x^2 + 2*y^2 - 3,
	x^2 + x*y + y^2 - 3
}
I = ideal fs

-- (a)
"With monomial order x>y:";
(flatten entries gens gb (sub(I, Rxy))) / print @@ tex;

print "With monomial order y>x:";
(flatten entries gens gb (sub(I, Ryx))) / print @@ tex;

-- (b), verification only
minimalPrimes I


-- Ex 3
clearAll;

Rxy = QQ[x, y, MonomialOrder=>Lex]
Ryx = QQ[y, x, MonomialOrder=>Lex]
fs = {
	x^2 + 2*y^2 - 2,
	x^2 + x*y + y^2 - 2
}
I = ideal fs

-- (a)
"With monomial order x>y:";
(flatten entries gens gb (sub(I, Rxy))) / print @@ tex;

print "With monomial order y>x:";
(flatten entries gens gb (sub(I, Ryx))) / print @@ tex;

factor (flatten entries gens gb (sub(I, Ryx)))_0

-- verification
minimalPrimes I


-- Ex 4
clearAll;

R = QQ[x, y, z, MonomialOrder=>Lex]

fs = {
	x^2 + y^2 + z^2 - 4,
	x^2 + 2*y^2 - 5,
	x*z - 1
}
I = ideal fs

-- (a)
(flatten entries gens gb R) / print;
(flatten entries gens gb R) / print @@ tex;

-- verification
minimalPrimes I

-- Ex 7
clearAll;

RLex = QQ[t, x, y, z, MonomialOrder=>Lex]
RElimT = QQ[t, x, y, z, MonomialOrder=>Eliminate 1]

fs = {
	t^2 + x^2 + y^2 + z^2,
	t^2 + 2*x^2 -x * y - z^2,
	t + y^3 - z^3
}
I = ideal fs

-- (a)
"With lex monomial order";
(flatten entries gens gb (sub(I, RLex))) / print;
(flatten entries gens gb (sub(I, RLex))) / print @@ tex;
"With grevlex monomial order";
(flatten entries gens gb (sub(I, RElimT))) / print;
(flatten entries gens gb (sub(I, RElimT))) / print @@ tex;

-- Ex 10
clearAll;

R = QQ[x, y, z, MonomialOrder=>Lex]

fs = {
	x^10 - y * x^5 + 1,
	x^2 - z * x + 1
}
I = ideal fs

(flatten entries gens gb I) / print;
