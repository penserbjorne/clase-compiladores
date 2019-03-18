%{
#include<stdio.h>
%}
con [bcdfghjklmnpqrstvwxyz]
va [a]
ve [e]
vi [i]
vo [o]
vu [u]
%option yylineno
%option noyywrap
%%
{con}*{va}+{con}*{ve}+{con}*{vi}+{con}*{vo}+{con}*{vu}+{con}* {printf("\n%s es una palabra valida",yytext);}
.* {printf("\nPalabra no reconocida: %s",yytext);}

%%

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
