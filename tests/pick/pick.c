int a[10], i, c;

i = 0;

while(i < 10){
  a[i] = i+1;
  i = i+1;
}

c = pick(a, 123456) * 1024;

write(c);

c = pick(a, c);

write(c);

write(pick(a, c - 7168));
