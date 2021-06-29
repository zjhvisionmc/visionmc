/* TBSDEM2 - an ANSI C triangle example */

void equalsides(int i,int j,int k,int *match)
{
       *match = 0;
       if( i==j) ++ *match;
       if( i==k) {++ *match;++ *match;};
       if( k==j) {++ *match;++ *match;++ *match;};
}

void printtype(int i,int j,int k,int match)
{
       if( match == 0 ) goto l1;
       else
       if( match == 1 ) goto l2;
       else
       if( match == 2 ) goto l3;
       else
       if( match == 3 ) goto l4;
       goto equil;
l1:    if(i+j<=k) goto nota;
       if(j+k<=i) goto nota;
       if(i+k<=j) goto nota; else goto scalene;
l2:    if(i+j<=k ) goto l1; else goto isos;
l3:    if(i+k<=j ) goto nota; else goto isos;
l4:    if(j+k<=i ) goto nota;else goto isos;
equil:       printf(" equilateral");
       goto end;
isos:       printf(" isosceles");

       goto end;
nota:        printf(" not a triangle");
       goto end;
scalene:    printf(" scalene");
end:;
}


