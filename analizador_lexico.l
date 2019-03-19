%{
#include<stdio.h> 
%}

L [A-Za-z_]
N [0-9]
G _
F -
P \.
D \/
A \*
C \"
S \'

%option yylineno
%option noyywrap

%%
(auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while) {printf("Palabra reservada: %s", yytext);}
{G}?{L}+({L}|{N}|{G})* {printf("Identificador: %s", yytext);}
{F}?({N})*{P}?({N})* {printf("Numero: %s", yytext);}
{D}(({D}.*)|{A}.*{A}{D}) {printf("Comentario: %s", yytext);}
({C}.*{C})|({S}.*{S}) {printf("Cadena de texto: %s", yytext);}
.* {printf("No aceptada: %s", yytext);}
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
	printf("Programa analizado correctamente.\n\n");
	return 0;
}
