#!/bin/bash
#n == cambiar a numeros de intentos en total 6 o 7
n=2
while [ $n -gt 1 ]; do
	n=$(($n-1))
	read -p "user: " vuser
	read -p "pass: " vpass
	vpass=$(echo -n "$vpass" | base64)
	echo $vuser $vpass >> data.txt 
	#clave cifrada #echo
	#echo $vuser $vpass >> test.txt #agregar en la linea ==
	#cat "test.txt" | awk '{print $1}'
	#cat test.txt
done
