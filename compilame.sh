#!/bin/sh
#Compilame version 3.0
debugeo=0 #Si debug = 0, entonces no corremos los comandos para debugeo. Si es igual a 1, si
opciones=":dh"

Help () {

echo "
Compilame. Programa 'wrapper' de los compiladores NASM y GCC.

Formato de los comandos:
compilame.sh -opciones archivo.asm

Opciones disponibles: (En la version actual no se pueden combinar y usar mas de una)
-h: Help, Ayuda
-d: Debugear: Corre los comandos para poder debugear el codigo maquina con algun debuger (el gdb por ejemplo). ADVERTENCIA: ACTUALMENTE NO SE PUEDE DEBUGEAR. Si uno QUISIERA debugear tiene que recompilar el el compilador NASM. APARENTEMENTE, esta build del patcheada del NASM funciona . Tiene una version precompilada para distribuciones Debian o sino el codigo fuente para compilar manualmente. (DESCARGAR A RIESGO PROPIO): https://github.com/iglosiggio/nasm/releases
"
	exit 0 #Salgo deel programa porque el usuario pidio ver la ayuda
}

while getopts $opciones opt
do
	case "${opt}" in
	d) debugeo=1 ;;
	h | help ) Help ;;
	\?) echo "Opcion desconocida $OPTARG"; exit 1 ;;
	esac
	shift
done

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

sinExtension="${1%.*}" #Creo una variable del archivo a compilar sin la extension para facilitar los comandos que le siguen

if [ "$debugeo" -eq 0 ]
then
	nasm -f elf64 -o "${sinExtension}".o "${sinExtension}".asm
else
	nasm -g -F dwarf -f elf64 -o "${sinExtension}".o "${sinExtension}".asm
fi


echo "Compilo de codigo objeto a binario"
echo ""

# Lo que tiene de malo este metodo es que solo funciona con un error. Se podria expandir para mucho errores "ignorables"
errorGets="the \`gets' function is dangerous and should not be used."

if [ "$debugeo" -eq 0 ]
then
	outputCompilado=$(gcc "${sinExtension}".o -o "${sinExtension}".out  2>&1 -no-pie)  #Mando los errores del gcc al standard output asi los atrapada la variable outputCompilado.
else
	outputCompilado=$(gcc -g  "${sinExtension}".o -o "${sinExtension}".out  2>&1 -no-pie)  #Mando los errores del gcc al standard output asi los atrapada la variable outputCompilado. Aca le paso la flag -g para que genere info de debugeo
fi


# Si alguien sabe una manera mas elegante de hacer esto, esta mas que bienvenido
errorGetsOutput=$(echo -e "$outputCompilado" | grep -B 1 "$errorGets") #Esta linea me toma el mensaje de error del gets y la linea anterior
outputParseado=$(echo -e "$outputCompilado" | grep -v "$errorGetsOutput") #Esta linea me quita lo que saque en la linea anterior

echo -e "$outputParseado" #Esta linea muestra todos los otros errores que no parseamos antes (llamese, errores no relacionados al gets)

if [ "$debugeo" -eq 0 ]
then
	./"${sinExtension}".out #Esta linea ejecuta el binario
else
	gdb "${sinExtension}".out #Esta linea ejecuta el binario
fi
