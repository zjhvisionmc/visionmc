/* TBSDEM1 - an ANSI C triangle example */

#include <stdio.h>
#include "tbsdem2.h"
#include "tbsdem3.h"
#include <stdio.h>
/*add something for test git!*/
int main()
{ int i,j,k,n,match;
  printf("\n input number of triangles \n");
  scanf("%d",&n);
  while (n>0)
    {  n--;
       printf("\n input 3 integers \n");
       scanf("%d %d %d", &i,&j,&k);
/*LDRA_assert*/
/*
     i>0 && j> 0 && k>0
*/
/*LDRA_end*/
       if(n==4) {datanoma(0)};
       if(n==999) {knots()};
       equalsides(i,j,k,&match);
       printtype(i,j,k,match);
    }
}
