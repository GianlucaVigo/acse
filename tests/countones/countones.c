int a, b;
a = 123456;

b = count_ones(a) + 100;
write(b); // b = 106

b = count_ones(a - 64 + 255);
write(b); // b = 13

b = count_ones(-1);
write(b); // b = 32

write(count_ones(-16));
write(count_ones(19));
