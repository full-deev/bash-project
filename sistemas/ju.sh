#!/bin/bash

# Palabra a adivinar
PALABRA="openai"

# Inicializar la palabra oculta con guiones
ocultar=$(echo $PALABRA | sed 's/./_/g')

# Número de intentos permitidos
INTENTOS=6
# Letras adivinadas incorrectamente
INCORRECTAS=""

# Función para dibujar el estado actual del ahorcado
dibuja_ahorcado() {
  case $1 in
    0)
      echo "
      +---+
      |   |
          |
          |
          |
          |
    ========="
      ;;
    1)
      echo "
      +---+
      |   |
      O   |
          |
          |
          |
    ========="
      ;;
    2)
      echo "
      +---+
      |   |
      O   |
      |   |
          |
          |
    ========="
      ;;
    3)
      echo "
      +---+
      |   |
      O   |
     /|   |
          |
          |
    ========="
      ;;
    4)
      echo "
      +---+
      |   |
      O   |
     /|\\  |
          |
          |
    ========="
      ;;
    5)
      echo "
      +---+
      |   |
      O   |
     /|\\  |
     /    |
          |
    ========="
      ;;
    6)
      echo "
      +---+
      |   |
      O   |
     /|\\  |
     / \\  |
          |
    ========="
      ;;
  esac
}

# Función para comprobar si la palabra está completa
#OCULTAR  --- echo "sebastian" | sed 's/./_/g' --- 
completa() {
  [[ $OCULTA == *"_"* ]] && return 1 || return 0
}

# Juego principal
while [[ $INTENTOS -gt 0 ]]; do
  dibuja_ahorcado $((6 - INTENTOS))
  echo "Palabra: $OCULTA"
  echo "Letras incorrectas: $INCORRECTAS"
  read -p "Adivina una letra: " LETRA

  if [[ $PALABRA == *"$LETRA"* ]]; then
    for i in $(seq 0 $((${#PALABRA} - 1))); do
      if [[ ${PALABRA:$i:1} == $LETRA ]]; then
        OCULTA="${OCULTA:0:$i}$LETRA${OCULTA:$(($i + 1))}"
      fi
    done
  else
    INCORRECTAS+="$LETRA "
    INTENTOS=$(($INTENTOS - 1))
  fi

  completa && break
done

if completa; then
  echo "¡Felicidades! Adivinaste la palabra: $PALABRA"
else
  dibuja_ahorcado 6
  echo "¡Perdiste! La palabra era: $PALABRA"
fi
