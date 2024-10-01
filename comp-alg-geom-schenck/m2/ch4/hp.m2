-- Computes the hilbert polynomial using the algorithm of section 4.2 


Qi := QQ[i];

hp = I -> (
	initials := first entries leadTerm gb I;
	hpMons initials
)

hpMons = mons -> (
	mon := first mons;
	remainingMons := drop(mons, 1);
	if remainingMons == {} then (
		hpHomPrincipal mon
	) else (
		remainingMonsQuotient := remainingMons / (m -> sub(m / gcd(m, mon), R));
		remainingMonsHp := hpMons remainingMons;
		remainingMonsHpQuotient := hpMons remainingMonsQuotient;
		deg := first degree mon;
		remainingMonsHp - remainingMonsHpQuotient(i - deg)
	)
)

hpHomPrincipal = mon -> (
	h := hpFree (ring mon);
	deg := first degree mon;
	h - h(i - deg)
)

hpFree = R -> (
	n := (#gens R) - 1;
	(1/n!) * fold((acc, j) -> (acc * (j + i)), 1, 1..n)
)
