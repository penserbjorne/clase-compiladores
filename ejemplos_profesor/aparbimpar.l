%{
#include<stdio.h> 
%}
A [ab]
%option yylineno
%option noyywrap
%%
{A}+ {valida(yytext);}
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
int i,p=0,im=0;
for(i=0; i<strlen(cad);i++){
if(cad[i]=='a')
p++;
else
im++;
			    }
if(im % 2 != 0 && p % 2 == 0)
printf("cadena valida");
else
printf("no valida");
			}

