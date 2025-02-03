

-- Ex 3
clearAll;

-- (a) & (b)

R = QQ[x, y, MonomialOrder=>Lex]
fs = {
	y * x^3 + x^2,
	y^3 * x^2 + y^2,
	y*x^4 + x^2 + y^2
}
I = ideal fs

(flatten entries gens gb I) / print;

-- (c) & (d)
fTildes = {
	x^2,
	y^2,
	x^2 + y^2
}
cs = {
	y,
	y^3,
	y
}
I = ideal (fTildes | cs)

(flatten entries gens gb I) / print;

-- Ex 4
R = QQ[x, y, z, MonomialOrder=>Lex]
fs = {
	x^2 + y^2 + z^2 + 2,
	3 * x^2 + 4 * y^2 + 4 * z^2 + 5
}

I = ideal fs

(flatten entries gens gb I) / print;
