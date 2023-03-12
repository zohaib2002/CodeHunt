List<Map> clues = [

/*  {
    'code':
'''
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
''',

    'solution': 'Behind MCA Department Cooler',
    'cluster': 'Electrical',
    'id':  65409
  },*/

  {
    'code':
'''
#include <stdio.h>

main () {
  char str1[][20] = {
    "Drainage besides",
    "Wire Duct",
    "Notice Board"
  };
  
  char str2[][20] = {
    "EN 0/5",
    "C 1/6",
    "EN 1/8"
    
  };
  
printf("%s %s", 0[str1], (0==1)[str2]);

}
''',

    'solution': 'Drainage besides EN 0/5',
    'cluster': 'Electrical',
    'id':  65270
  },

/*  {
    'code':
'''
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
''',

    'solution': 'Welcome to GATE Exam',
    'cluster': 'IT/Mechanical',
    'id':  53133
  },*/

  {
    'code':
'''
#include <stdio.h>

main() {
  int i=0;
  
  printf("Lift ");
  if (i=2) 
    printf("Floor 1");
  else if (i=0)
    printf("Floor 0");
  else
    printf("Floor 3");
}
''',

    'solution': 'Lift Floor 1',
    'cluster': 'IT/Mechanical',
    'id':  96549
  },

  {
    'code':
'''
#include <stdio.h>

main () {
  char str1[] = "Red Light";
  char str2[] = "Green Light";
  char str3[] = "Binary";
  
  str1[3] = '\\0';
  str2[5] = '\\0';
  str3[3] = '\\0';
  
  printf("Canteen %s %s %s %s", str1, str3, str2, str3);
}
''',

    'solution': 'Canteen Red Bin Green Bin',
    'cluster': 'Canteen',
    'id':  41630
  },

  {
    'code':
'''
#include <stdio.h>
#define w 83 
#define x 69 
#define y 76 
#define z 84

// These variable store ASCII values

main() {
  char text[] = {
    w, 'P', x, x, 'D', ' ',
    y, 'I', 'M', 'I', z
  };
  
  printf("%s %d", text, 10);
}
''',

    'solution': 'SPEED LIMIT 10',
    'cluster': 'Canteen',
    'id':  58078
  },

  /*{
    'code':
'''
#include <stdio.h>

main() {
  char str[7] = "Vslghu";
  
  int i=0;
  
  printf("Workshop ");
  
  for (i; i<6; i++) {
    printf("%c", str[i] - 3);
  }
}
''',

    'solution': 'Workshop Spider',
    'cluster': 'Workshop',
    'id':  85543
  },*/

  {
    'code':
'''
#include <stdio.h>

main() {
  char str[4] = "WQS";
  
  int i=0;
  
  for (i; i<3; i++) {
    printf("%c", str[i] - 3);
  }
  
  printf(" Suggestion Box");
}
''',

    'solution': 'TNP Suggestion Box',
    'cluster': 'Electrical',
    'id':  92805
  },

  {
    'code':
'''
#include <stdio.h>

main() {
  int i=0, j=0;
  
  for (j; j<10; j++) 
    if (j >= 3 && i++);
  
  printf("Flag Hoisting Ground ");
  printf("Tree no. %d", 250 + i);
}
''',

    'solution': 'Flag Hoisting Ground Tree no. 257',
    'cluster': 'Electrical',
    'id':  44266
  },

  {
    'code':
'''
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
''',

    'solution': 'Wire Duct EN 0/5',
    'cluster': 'Electrical',
    'id':  17548
  },

  //Final Clue

  {
    'code':
'''
#include <stdio.h>

main () {
  char str1[] = "I can";
  char str2[] = "borrow";
  char str3[] = "rupees sixteen";
  char str4[] = "from the counter";
  
  char str[20];
  
  printf("%s%s %s", str1+1, str3+10, str4+8);
}
''',

    'solution': 'canteen counter',
    'cluster': 'Canteen',
    'id':  96584
  },


];