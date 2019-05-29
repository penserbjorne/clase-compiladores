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
  int ival;
  float fval;
  char sval[1024];
};

%token <sval> RESERVADA IDENTIFICADOR COMENTARIO CADENA
%token <fval> NUMERO
%token <ival> TAND TOR TEQUAL TCEQ TCNE TCLT TCLE TCGT TCGE TLPAREN TRPAREN
%token <ival> TLBRACE TRBRACE TDOT TDOBLEDOT TCOMMA TDOTCOMMA TPLUS TMINUS TMUL TDIV

%start inicio

%%

inicio: exp_comentario | exp_fun | exp_if | exp_switch | /*vacio*/;

exp_comentario: COMENTARIO inicio{
    printf("SINTACTICO -> COMENTARIO -> %s\n", $1);
  };

exp_fun: exp_fun2 TLPAREN exp_fun4 TRPAREN TDOTCOMMA inicio {
    printf("SINTACTICO -> FUNCION \n");
  };

exp_fun2: exp_fun5;

exp_fun3: exp_fun5;

exp_fun4: exp_fun2
  | exp_fun3 exp_fun4
  ;

exp_fun5: RESERVADA IDENTIFICADOR;

exp_if: RESERVADA TLPAREN exp_if2 TRPAREN exp_if5 exp_if6 inicio {
    printf("SINTACTICO -> IF \n");
  };

exp_if2: exp_if3
  | TLPAREN exp_if2 TRPAREN;

exp_if3: exp_if3 exp_if4 exp_if3
  | IDENTIFICADOR
  | NUMERO
  | exp_if3;

exp_if4: TCGT | TCLT | TCGE | TCLE | TCNE | TCEQ | TAND | TOR ;

exp_if5: TLBRACE TRBRACE
  | exp_if3 TDOTCOMMA
  | TDOTCOMMA
  | exp_if;

exp_if6: RESERVADA exp_if5
  | /* vacio */;

exp_switch:
  exp_s1 TLPAREN IDENTIFICADOR TRPAREN TLBRACE exp_s2 TDOBLEDOT exp_s3 exp_s4 TRBRACE inicio {
    printf("SINTACTICO -> SWITCH \n");
  };

exp_s1: RESERVADA;

exp_s2: exp_s2 TDOBLEDOT exp_s4 exp_s2
  | RESERVADA NUMERO
  ;

exp_s3: RESERVADA TDOBLEDOT | /* vacio */;

exp_s4: RESERVADA TDOTCOMMA | /* vacio */;

exp_while: RESERVADA exp_w2 inicio {
    printf("SINTACTICO -> WHILE \n");
  }

exp_w2: TLPAREN exp_w2 TRPAREN
  | exp_w2 exp_if4 exp_w2
  | IDENTIFICADOR
  | NUMERO
  ;
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
  //yyparse();
  exit(-1);
}
