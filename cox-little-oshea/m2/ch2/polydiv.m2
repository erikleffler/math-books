load "logger.m2"

noLogger = newLogger LogLevelNoLog
infoLogger = newLogger LogLevelInfo

reduce = {Log=>noLogger} >> o -> (gs, f) -> (
	logger := o.Log;
	enterCountedFunction(logger, "reduce", (gs, f));

	-- TODO Maybe implement the div on our own
	prevR := f;
	while true do (
		r := fold((r, g) -> r % g, prevR, gs) ;

		if r == prevR then (
			exitFunctionRet(logger, "reduce", toString r);
			return r;
		);

		prevR = r;
	);
);

S = {Log=>noLogger} >> o -> (f1, f2) -> (
	logger := o.Log;
	enterCountedFunction(logger, "S", (f1, f2));

	R := ring f1;
	lm1 := leadTerm f1;	
	lm2 := leadTerm f2;	
	lcm12 := lcm(lm1, lm2);
	sPoly := sub(((lcm12 * f1) / leadTerm f1) - ((lcm12 * f2) / leadTerm f2), R);

	exitFunctionRet(logger, "S", toString sPoly);
	sPoly
);

sPolyRemainders = {Log=>noLogger} >> o -> (gs, f) -> (
	logger := o.Log;
	enterCountedFunction(logger, "sPolyRemainders", (gs, f));

	R := ring f;

	sPolys = delete(0_R, gs / (g -> S(g, f, Log=>logger)));
	remainders = delete(0_R, sPolys / (s -> reduce(gs, s, Log=>logger)));

	exitFunctionRet(logger, "sPolyRemainders", toString remainders);
	remainders
);

isGb = {Log=>noLogger} >> o -> gs -> (
	logger := o.Log;
	enterCountedFunction(logger, "isGb", (1:gs));

	for i in 0..<#gs do (
		for j in (i + 1)..<#gs do (
			s := S(gs_i, gs_j, Log=>logger);
			if s != 0 and reduce(gs, s, Log=>logger) != 0 then (
				exitFunctionRet(logger, "isGb", toString false);
				return false;
			);
		);
	);
	exitFunctionRet(logger, "isGb", toString true);
	true
);

makeMonic = f -> (
	f / (leadCoefficient f)
)

reduceGb = {Log=>noLogger} >> o -> gs -> (
	logger := o.Log;
	enterCountedFunction(logger, "reduceGb", (1:gs));

	i := 0;
	while i < #gs do (
		g := gs_i;
		others := drop(gs, {i, i});
		gReduced = reduce(others, g);
		if gReduced == 0 then (
			gs = others;
		) else (
			gs = replace(i, gReduced, gs);
			i = i + 1;
		);
	);

	gs = gs / makeMonic;

	exitFunctionRet(logger, "reduceGb", toString gs);
	gs
);

naiveGb = {Log=>noLogger} >> o -> gs -> (
	logger := o.Log;
	enterCountedFunction(logger, "naiveGb", (1:gs));

	unchecked := gs;
	while(#unchecked > 0) do (
		f := unchecked#-1;
		unchecked = drop(unchecked, -1);
		sprs := sPolyRemainders(gs, f, Log=>logger);
		gs = gs | sprs;
		unchecked = unchecked | sprs;
	);

	gs = reduceGb(gs, Log=>logger);
	exitFunctionRet(logger, "naiveGb", toString gs);
	gs
);

linDep = {Log=>noLogger} >> o -> (m, i, j, lms, unchecked) -> (
	logger := o.Log;
	enterCountedFunction(logger, "linDep", (m, i, j, lms, unchecked));

	R := ring m;

	for l in 0..<#lms do (
		if l == i or l == j or m % lms_l != 0_R then continue;

		il = if i < l then (i, l) else (l, i);
		jl = if j < l then (j, l) else (l, j);

		if all(unchecked, (km -> (km != il) and (km != jl))) then (

			exitFunctionRet(logger, "linDep", toString true);
			return true;
		);
	);
	exitFunctionRet(logger, "linDep", toString false);
	false
);

fasterGb = {Log=>noLogger} >> o -> gs -> (
	logger := o.Log;
	enterCountedFunction(logger, "fasterGb", (1:gs));

	R := ring gs_0;

	lms := gs / leadMonomial;
	unchecked := flatten for i in 0..<#gs list for j in (i + 1)..<#gs list (i, j);

	while #unchecked > 0 do (
		(i, j) := last unchecked;
		unchecked = drop(unchecked, -1);	

		lcmij := lcm(lms_i, lms_j);

		if lcmij == lms_i * lms_j then continue;

		if linDep(lcmij, i, j, lms, unchecked, Log=>logger) then continue;

		s := S(gs_i, gs_j, Log=>logger);
		
		if s == 0_R then continue;

		r := reduce(gs, s, Log=>logger);

		logInfo(logger, "r: " | toString r);

		if r == 0_R then continue;

		r = makeMonic r;
		unchecked = unchecked | toList ((0..<#gs) / (k -> (k, #gs)));
		gs = append(gs, r);
		lms = append(lms, leadMonomial r);

		logInfo(logger, "new gs: " | toString gs);
	);

	gs = reduceGb(gs, Log=>logger);

	exitFunctionRet(logger, "fasterGb", toString gs);
	gs
);


R = QQ[x,y,z, MonomialOrder=>GRevLex]

-- linDep(Log=> newLogger LogLevelInfo,
-- 	{x^3*y^2 + z, x*y^2 - y, x^2*y + y*z},
-- )


x*y*z^5 % x*y*z^4 == 0
linDep(x*y*z^5,2,4,{x^4*y, x^2*y*z, z^5, x*y*z^4, x*y*z^3},{(0,1), (0,2), (0,3), (0,4), (1,4)})




fs1 = {
	3 * x^3,
	x*y + x^2*y + z*y,
	z^2
}

fs2 = {
	13 * x^4*y + 5 * z,
	x*y + x^2*y*z + z^2*y,
	z^5
}

fs3 = {
	13 * x^4*y + 5 * z,
	x^2*y*z + z^2*y,
	z^5
}

fs4 = {
	x^4*y + 5 * z*y^2 - 1,
	2*x^5*y + 5*z^3*y,
	z^3 + z^2 + 1
}
time greals = (sort flatten entries gens gb ideal fs4) / makeMonic
logger = newLogger LogLevelInfo
time gs = sort fasterGb(fs4, Log=>logger)
greals == gs
print gs
--gs = sort fasterGb(fs4, Log=>(newLogger LogLevelNoLog))
