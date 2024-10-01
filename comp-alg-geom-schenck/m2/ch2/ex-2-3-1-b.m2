clearAll

-- We begin by writing some functions that
-- help us generate a random chain complex over R

randomLinearMapWithImageInKernel = (im, targetDimension) -> (
	sourceModule := ambient im;
	targetModule = R^targetDimension;

	quotientMap = inducedMap(sourceModule/im, sourceModule);

	-- random needs free modules as arugment...
	mapFromQuotient = random(targetModule, sourceModule);
	-- ...thus we need to cast to a map from sourceModule/im
	-- so we can compose with quotientMap
	mapFromQuotient = map(targetModule, sourceModule/im, mapFromQuotient); 

	finalMap = mapFromQuotient * quotientMap;
	assert(isSubset(im, ker finalMap));

	finalMap
)
	
randomChainComplex = (R, dimVector) -> (
	prevImage = R^0;
	chainComplex reverse for d in dimVector list (	
		m := randomLinearMapWithImageInKernel(prevImage, d);
		prevImage = image m;
		m
	)
)

R = ZZ/3 -- small field makes it so we more often generate degenerate maps

dimVector = {3,4,3,4,3,4,3,4,3,4,3,4}

rcc = randomChainComplex(R, dimVector)
h = HH rcc -- compute homology

vDims = {0} | dimVector | {0}
hDims = (0 ..< #h) / (i -> rank h_i)
<< "hDims: " << hDims << endl
<< "vDims: " << vDims << endl

alternatingSum = seq -> sum \\ toList (0 ..< #seq) / (i -> (-1)^i * seq_i)

hSum = alternatingSum hDims
vSum = alternatingSum vDims

<< "hSum: " << hSum << endl
<< "vSum: " << vSum << endl
