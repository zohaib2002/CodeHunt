#include <stdio.h>

main() {
	char str[7] = "Vslghu";
	
	int i=0;
	
	printf("Workshop ");
	
	for (i; i<6; i++) {
		printf("%c", str[i] - 3);
	}
}