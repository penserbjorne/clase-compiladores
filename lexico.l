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

#define GUARDAR_TOKEN strcpy(yylval.sval, yytext)
#define GUARDAR_TOKEN2(t) (yylval.ival = t)
#define GUARDAR_TOKEN3(t) (yylval.fval = t)
#define IMPRIMIR_TOKEN (printf("LEXICO -> TOKEN -> %s\n", yytext))

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
"&&" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TAND); }
"||" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TOR); }
"=" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TEQUAL); }
"==" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCEQ); }
"!=" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCNE); }
"<" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCLT); }
"<=" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCLE); }
">" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCGT); }
">=" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCGE); }
"(" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TLPAREN); }
")" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TRPAREN); }
"{" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TLBRACE); }
"}" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TRBRACE); }
"." { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TDOT); }
"," { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TCOMMA); }
";" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TDOTCOMMA); }
":" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TDOBLEDOT); }
"+" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TPLUS); }
"+" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TPLUS); }
"-" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TMINUS); }
"*" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TMUL); }
"/" { IMPRIMIR_TOKEN; return GUARDAR_TOKEN2(TDIV); }

(auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while) {
		printf("LEXICO -> RESERVADA -> %s\n", yytext);
		GUARDAR_TOKEN;
		return RESERVADA;
	}

{G}?{L}+({L}|{N}|{G})* {
		printf("LEXICO -> IDENTIFICADOR -> %s\n", yytext);
		GUARDAR_TOKEN;
		return IDENTIFICADOR;
	}

{F}?({N})*{P}?({N})* {
		printf("LEXICO -> NUMERO -> %s\n", yytext);
		GUARDAR_TOKEN3(atof(yytext));
		return NUMERO;
	}

{D}(({D}.*)|{A}.*{A}{D}) {
		printf("LEXICO -> COMENTARIO -> %s\n", yytext);
		GUARDAR_TOKEN;
		return COMENTARIO;
	}

({C}.*{C})|({S}.*{S}) {
		printf("LEXICO -> CADENA -> %s\n", yytext);
		GUARDAR_TOKEN;
		return CADENA;
	}

{B} {/* ignora final de linea */;}

{W} {/* ignora espacios en blanco */;}

. {
		printf("\tLEXICO -> ERROR -> NO ACEPTADO el simbolo \"%s\" en la linea %i\n", yytext, yylineno);
		yyterminate();
	}
%%
