#include <stdio.h>

main() {
	char str[4] = "WQS";
	
	int i=0;
	
	for (i; i<3; i++) {
		printf("%c", str[i] - 3);
	}
	
	printf(" Suggestion Box");
}