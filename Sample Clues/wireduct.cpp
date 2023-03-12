#include <stdio.h>

main () {
	char str1[][20] = {
		"Drainage besides",
		"Wire Duct",
		"CISCO"
	};
	
	char str2[][20] = {
		"EN 1/8",
		"EN 0/5",
		"EN 2/1"
		
	};
	
	printf("%s %s", *(str1 + 1), *(str2));
}
