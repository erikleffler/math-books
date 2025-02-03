dim QQ
dim ZZ

kk = QQ
R = kk[x]
loadPackage "LocalRings"
R = (kk[x])_(ideal x)
dim R
Spec R
sheaf (Spec R)

isWellDefined R
degree R
