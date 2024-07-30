#!/bin/bash

# Lista de palabras para el juego
declare -a palabras=("gato" "perro" "elefante" "jirafa" "tigre")

# Selecciona una palabra aleatoria
palabra_secreta=${palabras[$RANDOM % ${#palabras[@]}]}

# Inicializa las variables
intentos=0
max_intentos=6
palabra_actual=""

# Función para mostrar la palabra actual
mostrar_palabra() {
    for letra in $(echo "$palabra_secreta" | grep -o .); do
        if [[ "$palabra_actual" == *"$letra"* ]]; then
            echo -n "$letra "
        else
            echo -n "_ "
        fi
    done
    echo
}

# Bucle principal
while [[ $intentos -lt $max_intentos ]]; do
    echo "Palabra actual:"
    mostrar_palabra

    read -p "Ingresa una letra: " letra

    if [[ "$palabra_secreta" == *"$letra"* ]]; then
        palabra_actual+="$letra"
    else
        intentos=$((intentos + 1))
        echo "¡Incorrecto! Intentos restantes: $((max_intentos - intentos))"
    fi

    if [[ "$palabra_actual" == "$palabra_secreta" ]]; then
        echo "¡Felicidades! Has adivinado la palabra: $palabra_secreta"
        exit 0
    fi
done

echo "¡Agotaste tus intentos! La palabra era: $palabra_secreta"
exit 1
