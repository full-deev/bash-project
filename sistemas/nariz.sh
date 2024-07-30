#!/bin/bash

# Palabra oculta
palabra="programacion"
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

