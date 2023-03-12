#include <stdio.h>

main() {
	char str[29] = "Behind PFD Department Cooler";
	
	int i=0;
	
	for (i; i<28; i++) {
	  
	  if (i >=7 && i < 10)
		  printf("%c", str[i] - 3);
		else
		  printf("%c", str[i]);
	}
}