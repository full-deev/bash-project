#!/bin/bash

# Archivo con las palabras
WORD_FILE="easy.txt"

# Función para elegir una palabra aleatoria
choose_word() {
    local word_list="$1"
    shuf -n 1 "$word_list"
}

# Función para verificar si una letra está en la palabra
check_letter() {
    local word="$1"
    local letter="$2"
    echo "$word" | grep -q "$letter"
}

# Función principal del juego
play_game() {
    local word
    local guessed_word=""
    local attempts=7

    # Elegir una palabra aleatoria
    word=$(choose_word "$WORD_FILE")

    while [ "$attempts" -gt 0 ]; do
        echo "Palabra actual: $guessed_word"
        echo "Intentos restantes: $attempts"
        read -p "Ingresa una letra: " letter

        if check_letter "$word" "$letter"; then
            guessed_word+="$letter"
        else
            attempts=$((attempts - 1))
        fi

        if [ "$guessed_word" = "$word" ]; then
            echo "¡Felicidades! Has adivinado la palabra: $word"
            break
        fi
    done

    if [ "$attempts" -eq 0 ]; then
        echo "¡Perdiste! La palabra era: $word"
    fi
}

# Menú principal
while true; do
    echo "1. Iniciar sesión"
    echo "2. Jugar como invitado"
    echo "3. Salir"
    read -p "Elige una opción: " choice

    case "$choice" in
        1)
            read -p "Usuario: " username
            read -s -p "Contraseña: " password
            # Verificar usuario y contraseña (implementa tu lógica aquí)
            echo "Inicio de sesión exitoso para $username"
            play_game
            ;;
        2)
            play_game
            ;;
        3)
            echo "¡Hasta luego!"
            exit
            ;;
        *)
            echo "Opción inválida. Inténtalo de nuevo."
            ;;
    esac
done
