/*
Aguilar Enriquez Paul Sebastian 415028130
Berdejo Arvizu Oscar 312232188
Urcid García Amín 310337555
*/

/*** Seccion de definicion ***/
%{

#include <stdlib.h>
#include <stdio.h>
#include "sintactico.tab.h" // Para obtener los tokens de bison
//#define YYSTYPE double
//extern YYSTYPE yylval;

%}

/* Le indicamos a flex que solo lea un archivo de entrada */
%option yylineno
%option noyywrap

/*** Seccion de reglas ***/

L [A-Za-z_]
N [0-9]
G _
F -
P \.
D \/
A \*
C \"
S \'


%%
(auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while) {
		printf("Palabra reservada: %s", yytext);
		return RESERVADA;
	}

{G}?{L}+({L}|{N}|{G})* {
		printf("Identificador: %s", yytext);
		return IDENTIFICADOR;
	}

{F}?({N})*{P}?({N})* {
		printf("Numero: %s", yytext);
		//yylval = atoi(yytext);
		return NUMERO;
	}

{D}(({D}.*)|{A}.*{A}{D}) {
		printf("Comentario: %s", yytext);
		return COMENTARIO;
	}

({C}.*{C})|({S}.*{S}) {
		printf("Cadena de texto: %s", yytext);
		return CADENA;
	}

.* {
	printf("No aceptada: %s", yytext);
	}
%%
