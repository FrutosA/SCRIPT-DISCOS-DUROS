REM Creado por WAPORI y gestionado por Andrés Frutos.


			REM CREACION DEL MENU:

:MENU_START
@echo off
cls
set INPUT=false
set "MENU_OPTION="
set "OPTION1_INPUT="
set "OPTION2_INPUT="
set "OPTION3_INPUT="
set "OPTION4_INPUT="
set "OPTION5_INPUT="

echo +===============================================+
echo . OPCIONES DE DISCOS                         .
echo +===============================================+
echo .                                               
echo .  1) ESCANEO GENERAL DE LA UNIDAD PRINCIPAL             
echo .  2) EXAMINAR UNIDAD ESPECIFICA             
echo .  3) ANALIZAR Y REPARAR TODOS LOS DISCOS DEL SISTEMA     
echo .  4) COMPROBAR ESPACIO DE DISCO ESPECIFICO
echo .  5) SOLICITAR INFORMACION DISCO ESPECIFICO                    
echo .  6) SALIR
echo .                                          
echo +===============================================+
set /p MENU_OPTION="OPTION: "

IF %MENU_OPTION%==1 GOTO OPTION1
IF %MENU_OPTION%==2 GOTO OPTION2
IF %MENU_OPTION%==3 GOTO OPTION3
IF %MENU_OPTION%==4 GOTO OPTION4
IF %MENU_OPTION%==5 GOTO OPTION5
IF %MENU_OPTION%==6 GOTO OPTION6
IF %INPUT%==false GOTO DEFAULT

			REM OPCIÓN NUMERO 1
:OPTION1
set INPUT=true

sfc /scannow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth

timeout 2 > NUL
GOTO MENU_START

			REM OPCIÓN NUMERO 2

:OPTION2
set INPUT=true


set /p MIUNIDAD="Seleciona la letra de la unidad a examinar(C D E F G ...):"
chkdsk %MIUNIDAD%: /F

timeout 20 > NUL
GOTO MENU_START

			REM OPCIÓN NUMERO 3

:OPTION3
set INPUT=true

echo Analizando todas las unidades de disco disponibles...

for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo Unidad %%d: detectada
        chkdsk %%d: /F
    )
)

timeout 20 > NUL
GOTO MENU_START

			REM OPCIÓN NUMERO 4

:OPTION4
set INPUT=true

set /p EDISCO="SELECCIONE LA LETRA DEL DISCO A COMPROBAR (C D E F G ...): "
dir %EDISCO%:

timeout 20 > NUL
GOTO MENU_START

			REM OPCIÓN NUMERO 5

:OPTION5
set INPUT=true


set /p INFODISCO="Ingrese la letra de la unidad (C D E F G ...) "
wmic logicaldisk where "DeviceID='%INFODISCO%:'" get caption,description,filesystem,freespace,size,volumename 


timeout 20 > NUL
GOTO MENU_START

			REM OPCIÓN NUMERO 6

:OPTION6
set INPUT=true
echo Gracias y adios.
timeout 2 > NUL
exit /b

:DEFAULT
echo Opcion invalida, escrive un numero entre el 1 y el 6
timeout 2 > NUL
GOTO MENU_START