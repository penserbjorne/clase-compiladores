/*
  Aguilar Enriquez Paul Sebastian 415028130
  Berdejo Arvizu Oscar 312232188
  Urcid García Amín 310337555
*/

%{
#include <stdlib.h>
#include <stdio.h>

// Cosas que bison necesita saber de flex
extern FILE *yyin;
extern int yylineno;
extern char *yytext;
extern int yylex();
extern int yyparse();

void yyerror(const char *s);
%}

%union {
  //int ival;
  float fval;
  char sval[50];
};

%token <sval> RESERVADA
%token <sval> IDENTIFICADOR
%token <fval> NUMERO
%token <sval> COMENTARIO
%token <sval> CADENA

%%

entrada: /* vacio */
  | exp { printf("SINTACTICO -> exp\n");}
  ;

exp: NUMERO { printf("SINTACTICO -> %f\n", $1); };

%%

int main(int argc, char *argv[]){
	if(argc > 0){
		yyin = fopen(argv[1],"r");
		printf("Se abrio el archivo %s\n\n", argv[1]);
	}else{
		printf("No se pudo abrir el archivo %s\n\n", argv[1]);
		exit(-1);
	}

  yyparse();
	printf("\nAnalisis terminado.\n\n");
	return 0;
}

void yyerror(const char *s){
  printf("\tSINTACTICO -> ERROR -> %s en simbolo \"%s\" en la linea %i\n", s, yytext, yylineno);
  yyparse();
  //exit(-1);
}
