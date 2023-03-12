#include <stdio.h>

main () {
	char str1[] = "Red Light";
	char str2[] = "Green Light";
	char str3[] = "Binary";
	
	str1[3] = '\0';
	str2[5] = '\0';
	str3[3] = '\0';
	
	printf("Canteen %s %s %s %s", str1, str3, str2, str3);
}
