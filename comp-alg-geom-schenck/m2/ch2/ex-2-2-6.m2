clearAll

N = 10
R = QQ[x_1..x_N]

I = n -> ideal(apply(1..n, i -> x_i^(i + 1)))


for i from 1 to 5 do
	print numerator(reduceHilbert(hilbertSeries(R / I(i))))
