#! /bin/bash

# Eliminamos archivos generados previamente
rm -rf *.o *.yy.c
rm -rf .analizador_lexico.l.swp

# Construimos
lex -o analizador_lexico.yy.c analizador_lexico.l
gcc analizador_lexico.yy.c -o analizador_lexico.o
#./analizador_lexico.o prueba.c
./analizador_lexico.o prueba.txt

