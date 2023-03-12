#include <stdio.h>

main () {
	char str[][3][20] = {
		"Drainage besides",
		"Wire Duct",
		"CISCO",
		
		"EN 1/8",
		"EN 0/5",
		"EN 2/1"
	};
	
	printf("%s %s", 2[str[0]], str[1][2]);
}
