/*
	Aguilar Enriquez Paul Sebastian 415028130
	Berdejo Arvizu Oscar 312232188
	Urcid García Amín 310337555
*/

/*** Sección de definición ***/
%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "sintactico.tab.h" // Para obtener los tokens de bison

%}

/* Le indicamos a flex que solo lea un archivo de entrada */
%option yylineno
%option noyywrap

/*** Sección de reglas ***/

L [A-Za-z_]
N [0-9]
G _
F -
P \.
D \/
A \*
C \"
S \'
B \n
W [ \t]+

%%
(auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while) {
		printf("LEXICO -> PALABRA RESERVADA -> %s\n", yytext);
		strcpy(yylval.sval, yytext);
		return RESERVADA;
	}

{G}?{L}+({L}|{N}|{G})* {
		printf("LEXICO -> IDENTIFICADOR -> %s\n", yytext);
		strcpy(yylval.sval, yytext);
		return IDENTIFICADOR;
	}

{F}?({N})*{P}?({N})* {
		printf("LEXICO -> NUMERO -> %s\n", yytext);
		yylval.fval = atof(yytext);
		return NUMERO;
	}

{D}(({D}.*)|{A}.*{A}{D}) {
		printf("LEXICO -> COMENTARIO -> %s\n", yytext);
		strcpy(yylval.sval, yytext);
		return COMENTARIO;
	}

({C}.*{C})|({S}.*{S}) {
		printf("LEXICO -> CADENA -> %s\n", yytext);
		strcpy(yylval.sval, yytext);
		return CADENA;
	}

{B} {/* ignore end of line */;}

{W} {/* ignore whitespace */;}

.* {
		printf("LEXICO -> NO ACEPTADA -> %s\n", yytext);
		printf("\tLEXICO -> ERROR -> en simbolo \"%s\" en la linea %i\n", yytext, yylineno);
		yyterminate();
	}
%%
