require 'bigdecimal'

a = 36.2
b = 2.9
c = BigDecimal(a.to_s)-BigDecimal(b.to_s)
d = c.to_f
p d 
