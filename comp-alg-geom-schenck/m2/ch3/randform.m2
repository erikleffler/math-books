Resrandform=(n, degs)->(
	R=QQ[x_1..x_n];
	I = ideal random(R^degs, R^1);
	print betti res I
)
