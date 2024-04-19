clearAll

unorderedPairs = l -> flatten ((0..<#l) / (i -> (toList (i..<#l) / (j -> (l_i, l_j)))))
degreeTwoMonomials = l -> unorderedPairs l / times

dualConic = f -> (
	R := ring f;
	baseR := baseRing R;
	Rq := R/ideal(f);

	-- extract cofficeints of quadratic forms of 
	-- partial derivatives % ideal(f) into a matrix
	g := flatten entries sub(jacobian f, Rq);
	gg := degreeTwoMonomials g;
	mons := degreeTwoMonomials gens R;
	monsQ := mons / (r -> r_Rq);
	ggCoeffs := gg / (x -> coefficients(x, Monomials=>monsQ)) / last;
	M := sub(fold((v1, v2) -> v1 | v2, ggCoeffs), baseR);

	-- Recast that matrix as a map from the free module baseR^6,
	-- to the quotient module baseR^6 modulo the relations 
	-- induced by f
	fCoeffsVec := last coefficients(f, Monomials=>mons);
	fCoeffsVecInBaseR := sub(fCoeffsVec, baseR);
	M := map(coker fCoeffsVecInBaseR, baseR^6, M);

	-- The kernel of M will be the baseR-linear dependecies among the partial derivative 
	k := ker M;
	cs := (entries k_0) / (c -> sub(c, R));
	sum apply(mons, cs, times)
)

Rgeneric = QQ[a,b,c,d,e,r]
R = Rgeneric[x_0 .. x_2]

f = a * x_0^2 + b * x_0 * x_1 + c * x_0 * x_2 + d * x_1^2 + e * x_1 * x_2 + r * x_2^2
F = dualConic f

<< "f: " << f << endl << endl;
<< "F: " << F << endl << endl;
<< "dualConic F: " << dualConic F << endl << endl;
<< "F(jacboian f) % f: " << F(toSequence flatten entries jacobian f) % f << endl;
<< "f(jacboian F) % F: " << f(toSequence flatten entries jacobian F) % F << endl;
