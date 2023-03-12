#include <stdio.h>

main() {
	int i=0, j=0;
	
	for (j; j<10; j++) 
		if (j >= 3 && i++);
	
	printf("Flag Hoisting Ground ");
	printf("Tree no. %d", 250 + i);
}
