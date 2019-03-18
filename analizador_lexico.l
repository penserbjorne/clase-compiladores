%{
#include<stdio.h> 
%}

/* Palabras reservadas */

/* Identificadores */
L=[az-AZ]
G=_
N=[0-9]

/* Numeros */
F= -
P= .

/* Comentarios */
D= /
A= *

/* Cadenas de texto */
C="
S='

%option yylineno
%option noyywrap

%%
(L|G)(L*|G*|N*)* {printf("Identificador: %s",yytext);}
(FN+|N+)(F?(N*))? {printf("Numero: %s",yytext);}
D(D+L*|A+L*A+(L*A*)*D) {printf("Comentario: %s",yytext);}
(CL*C|SL*S) {printf("Cadena de texto: %s",yytext);}
.* {printf("No aceptada: %s",yytext);}
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
