clearAll

-- First part, find characteristic polynomial
baseR = QQ
R = baseR[a_0 .. a_5]

k = frac R
PR = k[x]

b = ((gens k) / (g -> g_(PR)))

A = matrix {
	{2 * b_0, b_1, b_2}, 
	{b_1, 2 * b_3, b_4}, 
	{b_2, b_4, 2 * b_5}
}

pA = det (A - diagonalMatrix toList(3:x))

-- pAzero is the polynomial that generates the ideal of the variety of points in PP^5 which
-- correspond to singular projective planar conics
pAzero = pA 
pAzero = substitute (pAzero, frac(baseR[a_1..a_5])[a_0])

-- We want to find random points in the variety of pAzero. By inspecting the polynomial,
-- we see that any 5 variables in the coordinate ring on the variety are algebraically independent,
-- and since any of a_0, a_3, a_5 only exist with degree 1 in pAzero, we can pick any of these,
-- say a_0, and let it be determined by the remaining 5 variables. I.e, we will pick a_1..a_5 at
-- random, and then use them to find a_0 such that a_0 .. a_5 lies in V(ideal(pAzero)).

-- Extract cofficients of pAzero as a linear polynomial c1 a_0 + c_0 in baseR[a_1..a_5][a_0]
(c1, c0) = toSequence (entries (coefficients pAzero)_1 / (i -> substitute(i_0, baseR[a_1..a_5])))

-- Function to determine a_0 from the other coordinates
zeroCoord = (A1, A2, A3, A4, A5) -> (-c0(A1, A2, A3, A4, A5))/(c1(A1, A2, A3, A4, A5))

randRationals = {Bound=>(2^32 - 1)} >> o -> nInts -> toList (0 ..< nInts) / (i -> random(-o.Bound, o.Bound) / random(-o.Bound, o.Bound))

randPointsOnPAZero = nPoints -> (0 ..< nPoints) / (i -> (
	oneThroughFive := randRationals(5);
	zero := zeroCoord toSequence oneThroughFive;
	{zero} | oneThroughFive 
))

newR = baseR[x, y, z]

pp5ToConic = p -> (
	ideal(
		p_0 * x^2  +
		p_1 * x * y +
		p_2 * x * z +
		p_3 * y^2 +
		p_4 * y * z +
		p_5 * z^2
	)
);

singularPoints = randPointsOnPAZero 10

dims = singularPoints / pp5ToConic / singularLocus / dim

<< endl << "points from variety where we expect singularities: " << endl << endl;

pAzero = substitute(pAzero, R)

for i in 0 ..< #singularPoints do
	<< "point: " << singularPoints_i << ", singularity locus dim: " << dims_i << ", pAzero(point): " << pAzero toSequence singularPoints_i << endl;


randPoints = (0 ..< 20) / (i -> randRationals(6))
dims = randPoints / pp5ToConic / singularLocus / dim

<< endl << "generic points where we expect no singularities:" << endl << endl;

for i in 0 ..< #randPoints do
	<< "point: " << randPoints_i << ", singularity locus dim: " << dims_i << ", pAzero(point): " << pAzero toSequence randPoints_i << endl;
