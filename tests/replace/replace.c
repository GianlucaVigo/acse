int a[10], b, i;

b = 24;
i = 0;

// a array initilization
while(i < 10) {
        a[i] = i + 1;
        i = i + 1;
}

i = 0;

replace(a, b-17, 5); // a = {1, 2, 3, 4, 5, 6, 5, 8, 9, 10}

while(i < 10) {
	write(a[i]);
	i = i + 1;
}

i = 0;

replace(a, 5, b/2); // a = {1, 2, 3, 4, 12, 6, 12, 8, 9, 10}

while(i < 10) {
        write(a[i]);
        i = i + 1;
}

i = 0;

replace(a, (-b)*10, -24+b); // a = {1, 2, 3, 4, 5, 6, 5, 8, 9, 10}

while(i < 10) {
        write(a[i]);
        i = i + 1;
}

i = 0;
