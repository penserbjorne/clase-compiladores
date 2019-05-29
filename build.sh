#! /bin/bash

# Eliminamos archivos generados previamente
rm -rf *.o *.yy.c *.tab.c *.tab.h
rm -rf .lexico.l.swp

# Construimos
bison -d sintactico.y
flex -o lexico.yy.c lexico.l
gcc lexico.yy.c sintactico.tab.c -o analizador.o
#./analizador.o prueba.txt
./analizador.o prueba.c
