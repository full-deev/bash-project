#!/bin/bash

archivo="data.txt"

dibujar_ahorcado() {
    case $1 in
        0) echo -e "\n\n\n\n\n\n";;
        1) echo -e "\n\n\n\n\n_____";;
        2) echo -e "\n |\n |\n |\n |\n_|____";;
        3) echo -e "_____\n |\n |\n |\n |\n_|____";;
        4) echo -e "_____\n |   |\n |\n |\n |\n_|____";;
        5) echo -e "_____\n |   |\n |   O\n |\n |\n_|____";;
        6) echo -e "_____\n |   |\n |   O\n |   |\n |\n_|____";;
        7) echo -e "_____\n |   |\n |   O\n |  /|\n |\n_|____";;
        8) echo -e "_____\n |   |\n |   O\n |  /|\ \n |\n_|____";;
        9) echo -e "_____\n |   |\n |   O\n |  /|\ \n |  / \n_|____";;
        10) echo -e "_____\n |   |\n |   O\n |  /|\ \n |  / \ \n_|____";;
    esac 
}

saludo() {
    echo -e "\nBienvenido, @$user al juego del Ahorcado"
    echo "Intenta adivinar la palabra secreta letra por letra."
    echo "Tienes un máximo de 10 intentos para adivinar la palabra."
    echo "Buena suerte!"
}

jugar() {
    palabra_oculta=$(echo $palabra | sed 's/./_/g')
    intentos=0
    letras_usadas=""
    errores=0

    while [ $intentos -lt 10 ]; do
        echo "Palabra: $palabra_oculta"
        echo "Letras usadas: $letras_usadas"
        echo "Errores: $errores/10"
        dibujar_ahorcado $intentos

        read -p "Ingresa una letra: " letra

        if [[ $letras_usadas == *"$letra"* ]]; then
            echo "Ya has usado esa letra. $letra"
            continue
        fi

        letras_usadas+="$letra, "

        if [[ $palabra == *"$letra"* ]]; then
            nuevo_palabra_oculta=""
            for ((i=0; i<${#palabra}; i++)); do
                if [ "${palabra:$i:1}" == "$letra" ]; then
                    nuevo_palabra_oculta="${nuevo_palabra_oculta}$letra"
                else
                    nuevo_palabra_oculta="${nuevo_palabra_oculta}${palabra_oculta:$i:1}"
                fi
            done
            palabra_oculta=$nuevo_palabra_oculta
        else
            intentos=$((intentos + 1))
            errores=$((errores + 1))
        fi

        if [ "$palabra_oculta" == "$palabra" ]; then
            echo "¡Felicidades! @$user ganasteee la palabra es: $palabra"
            break
        fi
    done

    if [ $intentos -eq 10 ]; then
        echo "Errores: $errores/10"
        dibujar_ahorcado $intentos
        echo "¡ @$user has perdido! La palabra era: $palabra, suerte para la otra"
    fi
}

login() {
    read -p "ingresa usuario: " user
    read -s -p "ingresa password: " pass
    pass=$(echo $pass | base64)
    echo
    if grep -q "$user" "$archivo"; then
        if grep -q "$pass" "$archivo"; then
	    saludo $user
	    nivel
	    palabra
	    jugar
        else
            echo -e "\ncontraseña incorrecta\\n"
            menu
        fi
    else
        echo "usuario $user no encontrado"
        read -p "¿Deseas registrarse?(s/n) " op
        if [ "s" == "$op" ]; then
            register
        else
            chao
        fi
    fi
}

register() {
    read -p "crea tu usuario: " user
    read -s -p "crea tu clave: " pass
    echo
    pass=$(echo $pass | base64)
    echo "$user|$pass" >> $archivo
    echo "Usuario registrado con éxito."
    menu
}

chao() {
    echo "Vuelve pronto . . . "
    sleep 1
    exit
}

nivel() {
    echo -e "\nTipo de dificultad\n1-> normal\n2-> experto"
    read -p "elije un nivel: " nivel
    if [ "$nivel" == "1" ]; then
        usar="facil.txt"
    elif [ "$nivel" == "2" ]; then
        usar="dificil.txt"
    fi
}

palabra() {
    palabra=$(awk '{for (i=1;i<=NF;i++) print $i}' $usar | shuf -n 1 | tr -d '\r')
    echo $palabra # Ayuda para verificar que palabra es -- eliminar --
}

menu() {
    echo -e "¡bienvenidos al juego del AHORC*DO!\n"
    echo "1-> Login"
    echo "2-> Register"
    echo "3-> Jugar invitado"
    echo "4-> Salir"
    read -p "ingresa el número del menú: " op
    if [ "$op" == "1" ]; then
        login
    elif [ "$op" == "2" ]; then
        register
    elif [ "$op" == "3" ]; then
    	saludo
        nivel
        palabra
        jugar
    elif [ "$op" == "4" ]; then
        chao
    fi
}

menu
