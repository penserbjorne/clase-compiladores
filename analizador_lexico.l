%{
#include<stdio.h> 
%}



%option yylineno
%option noyywrap

%%

%%

int main(int argc, char *argv[]){
	if(argc > 0){
		yyin = fopen(argv[0],"r");
	}else{
		printf("\tNo se pudo abrir el archivo %s\n", argv[0]);
		exit(0);
	}
	yylex();
}
