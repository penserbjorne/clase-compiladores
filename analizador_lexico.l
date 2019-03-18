%{
#include<stdio.h> 
%}



%option yylineno
%option noyywrap

%%

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
