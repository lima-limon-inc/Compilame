# Compilame
## Que hace?
Mini mini Shell script que lo podes correr 1 sola vez y logra:

- Compilar tu codigo assembly a objeto (usando [nasm](https://es.wikipedia.org/wiki/Netwide_Assembler))
- Compilarlo a un ejecutable (usando [gcc](https://gcc.gnu.org/))
- Ejecutarlo

## Que necesito?

- nasm
- gcc

## Como descargarlo?
Recomiendo tener algun directorio llamado "Scripts" en el directorio home (el directorio donde "arranca" el shell, tambien abreviado como "~"). Para el resto de la guia voy a usar la direccion `~/Scripts` como ejemplo. Si te guardas el archivo en algun otro lado reemplaza
### Paso 1: Descargar archivo de Github
#### Manera 1: La vieja confiable: Ctrl+C; Ctrl+V
Create un directorio "Compilame" en tu directorio de Scripts. Si seguiste lo recomendado podes ejecutar el siguiente comando:
```
mkdir ~/Scripts/Compilame
```
Una vez creada el directorio, simplemente copia y pega el archivo testear.sh del directorio de Github ahi dentro. Despues copialo y pegalo en lo(s) directorios que vos necesites. Tambien podes usar links simbolicos
**Advertencia**: Si lo haces de esta manera no vas a poder actualizar facilmente con [git](https://es.wikipedia.org/wiki/Git)
#### Manera 2: Usando git clone (recomendado)
**Advertencia**: Para este metodo necesitas tener [git](https://es.wikipedia.org/wiki/Git) instalado en tu computadora. Pero no hace falta que sepas usarlo; solo necesitas correr **2** comandos.

Anda al directorio de scripts. Si seguiste la guia podes ejecutar el siguiente comando:
```
cd ~/Scripts
```
Una vez ahi dentro ejecuta el siguiete comando:
```
git clone https://github.com/lima-limon-inc/Compilame.git
```
Eso deberia crear un directorio TesterAlgo2 en tu directorio Scripts/.
Una vez hecho eso, entra al directorio TesterAlgo2

Lo que tiene de bueno este metodo es que podes actualizar el programa facilmente:
1. Anda al directorio donde tenes el programa (`cd ~/Scripts/TesterAlgo2`)
2. Corre el siguiente comando:
```
git pull
```
Este comando actualiza el programa si hubo alguna actualizacion en Github

### Paso 2: Hacer el archivo ejecutable
Una vez descargado tenes que correr:
```
chmod u+x compilame.sh
```
- chmod: Comando de Linux/UNIX que le cambia los permisos a un archivo
- u: **U**suario, lo que le sigue solo va a aplicar al usuario y a ningun otro grupo
- +x: Añade permiso de ejecucion
- compilame.sh: El archivo al que queremos aplicarle todo lo de arriba

Para testear que quedo todo bien pueden correr
```
ls -l
```
Y deberia verse algo asi:
> -rwx------ 1 usuario grupo peso fecha testear.sh

Tiene que tener una "x" en la 4ta posicion del primer campo. Si ademas tienen "x" en alguna otra posicion, tambien deberia funcionar

### Paso 3:
Listo \\:D/
Lo unico que necesitas hacer es copiar el archivo testear.sh en el directorio donde tengas tus archivos para testear y ya esta.
Con este metodo los comandos van a empezar con `./compilame.sh`

### Paso 4: Hacer el archivo ejecutable sin necesidad de copiarlo en todos lados (recomendado, aunque no obligatorio)
Podes hacer que el programa sea accesible desde cualquier lado de tu computadora si necesidad de copiar y pegar el archivo.
Simplemente tenes que añadir el directorio donde tenes el programa al PATH.

**Advertencia**: Si tu sistema usa alguna otra shell como la Z shell (este es el caso en las Macs) entonces vas a tener que modificar el archivo rc (run commands) de tu shell. Si tenes un archivo `~/.bashrc` entonces tu sistema usa la shell de bash y no tenes de que preocuparte (si el comando `cat ~/.bashrc` no te tira error, significa que tu sistema usa la bash shell y que podes seguir sin problema)

1. Tenes que editar el archivo (`~/.bashrc`) usando tu editor de texto preferido.
2. Una vez abierto, añadi al final del archivo (sin romper/tocar lo que ya esta escrito ahi) las siguientes lineas. **Advertencia**: Si usaste algun otro directorio en el Paso 1, reemplazala como corresponda
```
# Modificaciones del PATH
export PATH="${PATH}:$HOME/Scripts/Compilame/:$PATH" #Programa para Organizacion del Computador
```
3. Guarda y cerra el archivo
4. En la terminal corre el siguiente comando:
```
source ~/.bashrc
```
5. Listo, si todo funciono bien, podes usar el comando `compilame.sh`(sin el ./) en cualquier lado

## Como usarlo?
Muy facil! Una vez copies el archivo en el directorio con tus programas simplemente corre `./compilame.sh archivo.asm` (si hicite el Paso 4 podes usar directamente `compilame.sh archivo.asm` y no hace falta que copies el archivo)

## TODO
Cosas que quedan por hacer
- [ ] Tener flags para que el programa sea silencioso
- [ ] Tal vez le vamos a tener que pasar argumentos a los archivos, se puede usar una flag o chequer si $2,$3, etc son usados y pasarselo al programa assembly
