#include <stdio.h>

#define get_sp(var) asm ("mov %0, r13" : "=r" (var))

int main()
{
	register unsigned long int sp2;

	get_sp(sp2);
	printf("sp = %lu\n", sp2);
}

