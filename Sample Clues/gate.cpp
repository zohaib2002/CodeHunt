#include <stdio.h>

main() {
	char str[21] = "Welcome to JDWH Exam";
	
	int i=0;
	
	for (i; i<20; i++) {
	  
	  if (i >=11 && i <15 )
		  printf("%c", str[i] - 3);
		else
		  printf("%c", str[i]);
	}
}