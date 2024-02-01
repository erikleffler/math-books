reset()

R = PolynomialRing(QQ, ["x", "y"])
x, y = R.gens()

def lower_deg(F):
	print("lower_deg, F: ", F)
	es = F.exponents()
	if es == []:
		return 0
	return min(es)


def intersection_mul_y_axis_origin(F):
	print("intersection_mul_y_axis_origin, F: ", F)
	return lower_deg(F.subs(y = 0).univariate_polynomial())

def y_power_divisor(F):
	print("y_power_divisor, F: ", F)
	return lower_deg(F.subs(x = 1).univariate_polynomial())


def intersection_multiplicity_origin(F, G):

	print("F: ", F, "G: ", G)

	p = { x: 0, y: 0 }

	common = F.gcd(G)

	if common not in QQ and common.subs(p) == 0:
		return -1

	if F.subs(p) != 0 or G.subs(p) != 0:
		return 0

	x_terms_F = F.subs(y = 0)
	c_F = 0 if x_terms_F == 0 else x_terms_F.lc()
	if c_F == 0:
		return intersection_mul_y_axis_origin(G) + \
			intersection_multiplicity_origin(F / y, G)

	x_terms_G = G.subs(y = 0)
	c_G = 0 if x_terms_G == 0 else x_terms_G.lc()
	if c_G == 0:
		return intersection_mul_y_axis_origin(F) + \
			intersection_multiplicity_origin(F, G / y)

	x_deg_F = x_terms_F.degree(x)
	x_deg_G = x_terms_G.degree(x)

	if x_deg_F < x_deg_G:
		F, G = G, F
		x_deg_F, x_deg_G = x_deg_G, x_deg_F

	F_prime = F - x^(x_deg_F - x_deg_G) * (c_F / c_G) * G
	return intersection_multiplicity_origin(F_prime, G)
	

	
	

