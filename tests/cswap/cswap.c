int a, b;

a = 10;

cswap(a, 10, 11, b); // compare successful
		     // a == 11, b == 10
write(a); // 11
write(b); // 10

cswap(a, 12, 15*2, b); // compare failed
                       // a == 11, b == 11

write(a); // 11
write(b); // 11
