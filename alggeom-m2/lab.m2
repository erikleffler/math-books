R := QQ[x,y,z]

curve := ideal(x^4 - y^5, x^3 - y^7)

gens gb curve
dim curve

degree curve
curve1 := saturate(curve, ideal(x))
curve = curve1

surface := ideal( x^5 + y^5 + z^5 - 1)

inters := surface + curve

dim inters
degree inters
degree radical inters

staircase = ideal leadTerm inters
T = R/staircase
basis T
coefficientRing T
use R

f = y^5*x^5-x^9-y^8+y^3*x^5
f % inters

decompose inters / degree
S = QQ[z,y,x, MonomialOrder => Eliminate 2]

ourpoints = substitute(inters, S)
G = gens gb ourpoints
ideal selectInSubring(1,G)
loadPackage "RationalPoints2"
rationalPoints(ourpoints)


M = staircase^3
numgens M
transpose gens M
degree M
S = R/M
basis S

tally (flatten entries basis S / degree)
basis(19, S)

(x + y + z)^19

C = res M
C.dd_1


set flatten entries gens M - set flatten entries C.dd_1

C.dd_2


A = {{1, 1, 1, 1}, 
	{1, 5,10,25}}

R = QQ[p,n,d,q, Degrees => transpose A]

degree (p^4 * n^8 * d^10 * q^3)

h = basis({25, 219}, R)

rank source basis({100, 1000}, R)

S = QQ[x, y, d, p, n, q, MonomialOrder => Lex, MonomialSize => 16]
I = ideal(p - x * y, n - x * y^5, d - x * y^10, q - x * y^25)

transpose gens gb I

S' = S / I

x^100 * y^1000

kk = QQ --ZZ/32749

ringP3 = kk[x_0..x_3]
ringP1 = kk[s, t]

cubicMap = map(ringP1, ringP3, {s^3, s^2 * t, s * t^2, t^3})
idealCubic = kernel cubicMap

idealCubic2 = monomialCurveIdeal(ringP3,{1,2,3})


M = matrix {{x_0, x_1, x_2}, {x_1, x_2, x_3}}
minors(2, M)

degree idealCubic
dim idealCubic

f = vars ringP3 
OmegaP3 = kernel f
g=generators OmegaP3

presentation OmegaP3

G = res coker f
G.dd

source G.dd_2
degrees target G.dd_2

betti G

m = matrix{{x_0^3, x_1^2, x_2,x_3},{x_1^3,x_2^2,x_3,0}}
I = minors(2, m)

F = res(ringP3^1/I)
betti F
F.dd


OmegaP3Res = kernel(f ** (ringP3^1/idealCubic))
delta1 = jacobian idealCubic
delta2 = delta1 // gens OmegaP3Res
gens OmegaP3Res

delta = map(OmegaP3Res, module idealCubic, delta2)
OmegaCubic = prune coker delta

prune HH^0((sheaf OmegaCubic)(>=0))


loadPackage "LocalRings"

ringP4 = kk[x_0..x_4]

m0 = ideal(x_0, x_1, x_2, x_4)
ringP40 = ringP4_m0

idealX = ideal(x_1 + x_4, x_2 + x_4)
idealL1 = ideal(x_1, x_2)
idealL2 = ideal(x_3, x_4)
idealY = intersect(idealL1, idealL2)


moduleOX = ringP4^1 / module idealX
moduleOY = ringP4^1 / module idealY

length (moduleOX ** moduleOY)

degree(idealX + idealY)

load "mystery.m2"

kk = QQ
ringP3 = kk[x_0..x_3];
idealX = mystery ringP3

X = variety idealX

dim X

idealXtop = top idealX

integralClosure idealX == idealX

codim singularLocus idealX
