/* Autor: Aguilar Enriquez Paul Sebastian , Descripcion: Un analizador lexico que verifica si las palabras de un archivo contienen las 5 vocales del abecedario. */
//#include <stdio.h>
//#include <stdlib.h>

//#define MAXFILENAME 256

void cleanBuffer(){
    while(getchar() != '\n');
}

int main()
{
    char* fileName;
    FILE* file;
    char opt;
    char c;
    int contVocals;

    // Alojamos memoria para leer un string
    fileName = (char*)malloc(sizeof(char*));

    // Leemos un string hasta que haya un salto de linea
    printf("Ingresa el nombre del archivo: ");
    scanf("%[^\n]s", fileName);

    // Tratamos de abrir el archivo
    file = fopen(fileName, "r");
    if(!file){
        // Si no se pudo abrir damos opcion a crearlo
        printf("No se encontro el archivo %s\n", fileName);
        printf("Desea crearlo? S/N: ");
        cleanBuffer();
        scanf("%c", &opt);
        if(opt == 's' || opt == 'S'){
            file = fopen(fileName, "w");
            if(!file){
                printf("No creo el archivo %s", fileName);
            }else{
                printf("Se creo el archivo %s", fileName);
                fclose(file);
            }
        }
        free(fileName);
        free(file);
        return 0;
    }

    // Comenzamos a leer caracter por caracter
    contVocals = 0;
    c = fgetc(file);
    while(!feof(file)){
        printf("%c", c);
        c = fgetc(file);

        // Vamos validando la existencia de las vocales
        switch(contVocals){
            case 0:
                if(c == 'a' || c == 'A'){
                    contVocals = 1;
                }
            break;
            case 1:
                if(c == 'e' || c == 'E'){
                    contVocals = 2;
                }
            break;
            case 2:
                if(c == 'i' || c == 'I'){
                    contVocals = 3;
                }
            break;
            case 3:
                if(c == 'o' || c == 'O'){
                    contVocals = 4;
                }
            break;
            case 4:
                if(c == 'u' || c == 'U'){
                    contVocals = 5;
                }
            break;
        }

        // Validamos el salto de linea
        if(c == '\n'){
            if(contVocals == 5){
                printf("\tContiene las 5 vocales");
            }else{
                printf("\tNo contiene las 5 vocales");
            }
            contVocals = 0;
        }
    }
    fclose(file);

    free(fileName);
    free(file);
    return 0;
}
