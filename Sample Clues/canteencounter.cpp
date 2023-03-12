#include <stdio.h>

main () {
	char str1[] = "I can";
	char str2[] = "borrow";
	char str3[] = "rupees sixteen";
	char str4[] = "from the counter";
	
	char str[20];
	
	printf("%s%s %s", str1+1, str3+10, str4+8);
}
