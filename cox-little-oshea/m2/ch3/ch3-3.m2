


-- Ex 6
clearAll;

R = QQ[u, v]
fs = {
	u*v,
	u^2,
	v^2
}

gens R | toList(s_0 .. s_(#fs - 1))
elimGens = toList(s_0 .. s_(#fs - 1))
allGens = gens R | elimGens
RElim = QQ[allGens, MonomialOrder=>{(#allGens):1}]
fElims = (0..<#fs) / (i -> (elimGens_i)_RElim - sub(fs_i, RElim))
(flatten entries gens gb ideal fElims)/ print
(flatten entries gens gb ideal fElims)/ print @@ tex
selectInSubring(#gens R, gens gb ideal fElims)

-- Ex 7
clearAll;

R = QQ[u, v]
fs = {
	u*v,
	u*v^2,
	u^2
}

gens R | toList(s_0 .. s_(#fs - 1))
elimGens = toList(s_0 .. s_(#fs - 1))
allGens = gens R | elimGens
RElim = QQ[allGens, MonomialOrder=>{(#allGens):1}]
fElims = (0..<#fs) / (i -> (elimGens_i)_RElim - sub(fs_i, RElim))
(flatten entries gens gb ideal fElims)/ print
(flatten entries gens gb ideal fElims)/ print @@ tex
selectInSubring(#gens R, gens gb ideal fElims)

-- Ex 8
clearAll;

R = QQ[u, v]
fs = {
	3*u + 3*u*v^2 - u^3,
	3*v + 3*u^2*v - v^3,
	3*u^2 - 3*v^2
}

gens R | toList(s_0 .. s_(#fs - 1))
elimGens = toList(s_0 .. s_(#fs - 1))
allGens = gens R | elimGens
RElim = QQ[allGens, MonomialOrder=>{(#allGens):1}]
fElims = (0..<#fs) / (i -> (elimGens_i)_RElim - sub(fs_i, RElim))
(flatten entries gens gb ideal fElims)/ print @@ toString
(flatten entries gens gb ideal fElims)/ print @@ tex
#gens R
selectInSubring(#gens R, gens gb ideal fElims)

gensI1 = flatten entries selectInSubring(1, gens gb ideal fElims)
coeffR1 = QQ[elimGens][v]
coeffsI1 = gensI1 / (f -> leadCoefficient sub(f, coeffR1))
coeffsI1_{1..<#coeffsI1} / print @@ tex

gensI0 = toList(set(flatten entries gens gb ideal fElims) - set(gensI1))
coeffR0 = QQ[elimGens | {v}][u]
coeffsI0 = gensI0 / (f -> leadCoefficient sub(f, coeffR0))
coeffsI0_{1..<#coeffsI0} / print @@ tex

-- Ex 9
clearAll;

R = QQ[u, v]
fs = {
	u*v,
	v,
	u^2
}

gens R | toList(s_0 .. s_(#fs - 1))
elimGens = toList(s_0 .. s_(#fs - 1))
allGens = gens R | elimGens
RElim = QQ[allGens, MonomialOrder=>Eliminate (#gens R)]
fElims = (0..<#fs) / (i -> (elimGens_i)_RElim - sub(fs_i, RElim))
grob = gens gb ideal fElims
(flatten entries grob)/ print

-- Ex 10
clearAll;

R = QQ[t]
fs = {
	t^2,
	t^3 - t,
	t^7 - t^3 + 5
}

gens R | toList(s_0 .. s_(#fs - 1))
elimGens = toList(s_0 .. s_(#fs - 1))
allGens = gens R | elimGens
RElim = QQ[allGens, MonomialOrder=>Eliminate (#gens R)]
fElims = (0..<#fs) / (i -> (elimGens_i)_RElim - sub(fs_i, RElim))
grob = gens gb ideal fElims
(flatten entries grob)/ print
ideal selectInSubring(1, grob)

-- (b)
clearAll;

RElim = QQ[t, y, x_1, x_2, MonomialOrder => Eliminate 2]
fElims = {
	(1 + t^2) * x_1 - 1 + t^2,
	(1 + t^2) * x_2 - 2 * t,
	1 - (1 + t^2) * y
}
grob = gens gb ideal fElims
(flatten entries grob)/ print

-- Ex 15
clearAll;

symbR = QQ[w, a, b, c, d, e, f]
RElim = symbR[t, T, x, y, MonomialOrder => {4 : 1}]
fElims = {
	((1 - t^2) + 2 * t * (1 - t) * w + t^2) * x - (1 - t^2) * a - 2 * t * (1 - t) * w * b - t^2 * c,
	((1 - t^2) + 2 * t * (1 - t) * w + t^2) * y - (1 - t^2) * d - 2 * t * (1 - t) * w * e - t^2 * f,
	1 - T * ((1 - t^2) + 2 * t * (1 - t) * w + t^2)
}

grob = gens gb ideal fElims
R = symbR[x, y]
elimGens = flatten entries selectInSubring(2, grob) / (f -> sub(f, R))
elimGens / (f -> sub(f, w=>0))
elimGens / exponents


