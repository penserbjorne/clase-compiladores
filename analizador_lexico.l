%{
#include<stdio.h> 
%}

/* Identificadores */
L=[abcdefghijklmnopqrstuvwxyz]
G=_
N=[0123456789]


%option yylineno
%option noyywrap

%%
(L|G)(L*|G*|N*)*  {printf("\nPalabra reconocida: %s",yytext);}
.* {printf("\nPalabra no reconocida: %s",yytext);}
%%

int main(int argc, char *argv[]){
	if(argc > 0){
		yyin = fopen(argv[1],"r");
		printf("Se abrio el archivo %s\n\n", argv[1]);
	}else{
		printf("No se pudo abrir el archivo %s\n\n", argv[1]);
		exit(0);
	}
	yylex();
}
