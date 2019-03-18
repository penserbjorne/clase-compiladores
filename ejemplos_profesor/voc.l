%{
#include<stdio.h>
%}
c[^aeiou]
%option noyywrap
%option yylineno
%%
{c}*a+{c}*e+{c}*i+{c}*o+{c}*u+{c}* {printf("\nPalabra reconocida: %s",yytext);}
.* {printf("\nPalabra no reconocida: %s",yytext);}

%%

main(int argc, char *argv[]){
if(argc>1)
yyin=fopen(argv[1],"r");
else
printf("ERROR");
yylex();
}
