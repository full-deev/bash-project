#!/bin/bash
archivo="data.txt"

login (){
	read -p "ingresa usuario: " user
	read -s -p "ingresa password: " pass
	pass=$(echo $pass | base64)
	#echo $pass
	if grep -q "$user" "$archivo" | grep -q "$user" "$archivo" ; then
		if grep -q "$pass" "$archivo" | grep -q "$pass" "$archivo" ; then
			echo bienvenido, @$user
			#palabra 
			#jugar
			#funcion juego 		
		else
			echo "contraseña incorrecta"
			menu
		fi
	else
		echo  "usuario $user no encontrado"
		read -p "¿Deseas registrarse?(s/n) " op
		if [ "s" == $op ] ; then
			register
		else
			echo Gracias por usar el programa.
			exit 1
		fi
	fi
}

register (){
	read -p "crea tu usuario: " user	
	read -s -p "crea tu clave: " pass
	#echo $vpass >> p.txt
	#echo $vuser >> u.txt
	pass=$(echo $pass | base64)
	echo $user"|"$pass >> $archivo
	echo
}

chao () {
	echo "Vuelve pronto . . . "
	sleep 1 
	exit 
}

palabra (){
	echo -e "\nTipo de dificultad\n1-> normal\n2-> experto"
	read -p "elije un nivel: " nivel
	if [ $nivel == "1" ]; then
		usar="facil.txt"
	elif [ $nivel == "2" ]; then
		usar="dificil.txt"
	fi
	palabra=$(awk '{for (i=1;i<=NF;i++) print $i}' $usar | shuf -n 1)
	#palabra=$(tr ' ' ' \n' < $usar | shuf -n 1)
	echo $palabra
	#oculta=$(echo $palabra | sed 's/./_/g')
	#echo $oculta
	echo " "
}

#-------------------------------------------------------
#!/bin/bash

# Palabra oculta
palabra="programacion"
echo $palabra
# Convertir la palabra en guiones
oculta=$(echo "$palabra" | sed 's/./-/g')

# Función para actualizar la palabra oculta
actualizar_oculta() {
    local letra=$1
    for ((i=0; i<${#palabra}; i++)); do
        if [[ "${palabra:$i:1}" == "$letra" ]]; then
            oculta="${oculta:0:$i}$letra${oculta:$(($i + 1))}"
        fi
    done
}

# Bucle para pedir letras al usuario
while [[ "$oculta" != "$palabra" ]]; do
    echo "Palabra: $oculta"
    read -p "Ingresa una letra: " letra
    if [[ "$palabra" =~ "$letra" ]]; then
        actualizar_oculta "$letra"
    else
        echo "La letra '$letra' no está en la palabra."
    fi
done

echo "¡Felicidades! Adivinaste la palabra: $palabra"

# Inicializar variables
#echo "¡Has perdido! La palabra era: $palabra"

menu (){
	echo -e "¡bienvenidos al juego del AHORC*DO!\n"
	echo "1-> Login"
	echo "2.> Register"
	echo "3-> Jugar invitado"
	echo "4-> Salir"
	#sleep 1
	
 	read -p "ingresa el número del menú: " op
	if [ $op == 1 ]; then
		login
	elif [ $op == 2 ]; then
		register
	elif [ $op == 3 ]; then
		#dibujar
		completa
		#random 
	elif [ $op == 4 ]; then
		chao
	fi
}
#completa
#menu

