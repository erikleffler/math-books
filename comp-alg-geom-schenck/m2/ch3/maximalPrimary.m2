clearAll

R = Q[x,y,z]

I1 = ideal(x^2, y^2, z^2)
I2 = ideal(x - z, y)

assert(isPrimary I1)
assert(isPrimary I2)

I = intersect(I1, I2)
