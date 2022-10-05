#!/bin/sh
#Compilame version 1.0

if [ -z "$1" ]
then
	echo "
Ojo, tenes que pasar un archivo como primer parametro para que el programa funcione.
Ejemplo: compilame.sh hola_mundo.asm
"
	exit 2 #Paso 2 como error porque el usuario no paso los archivos necesarios
fi


if [ ! -f "$1" ]
then
	echo "
${1} no existe
	"
	exit 2 #Paso 2 como error porque el usuario no paso un archivo existente
fi


if [ ".asm" != $(echo -n $1 | tail -c 4) ] && [ ".s" != $(echo -n $1 | tail -c 2) ]
then
	echo '''
Tenes que pasarme un archivo ".asm" o ".s"
	'''
	exit 2 #Paso 2 como error porque el usuario no paso un archivo existente
fi

echo "Compilo el archivo asembly a objeto"
echo ""
nasm $1 -f elf64 #Comando de compilacion de assembly a codigo objeto via nasm

sinExtension=${1%.*} #Creo una variable del archivo a compilar sin la extension para facilitar los comandos que le siguen

echo "Compilo de codigo objeto a binario"
echo ""
gcc ${sinExtension}.o -o ${sinExtension}.out -no-pie
