#!/bin/sh

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


