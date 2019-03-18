%{
#include<stdio.h>
%}
%option yylineno
%option noyywrap
%%
(a|b)*a(a|b)(a|b) {valida(yytext);}
.* {printf("Cadena no valida");}
%%
void valida(char cad[]);
main(int argc, char *argv[])
{
if(argc>1)
yyin=fopen(argv[1],"r");
else{
printf("No se pudo abrir el archivo");
exit(0);
}
yylex();
}

void valida(char cad[]){
printf("cadena valida");
			}

