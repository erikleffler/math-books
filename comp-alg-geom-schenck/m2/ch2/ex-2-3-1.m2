clearAll

z = matrix {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}
phi = matrix {{1, 0, -1}, {-1, 1, 0}, {0, -1, 1}}
h = HH chainComplex {z, phi, z}
<< h
