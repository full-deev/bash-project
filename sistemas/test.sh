#!/bin/bash

n=4
while [ $n -gt 2 ]; do
	n=$(($n-1))
	read -p "user: " vuser
	read -p "pass: " vpass
	echo $vuser -n $vpass | base64 >> test.txt #clave cifrada #echo
	#echo $vuser $vpa >> test.txt #agregar en la linea ==
	cat "test.txt" | awk '{print $1}'
	cat test.txt
	
done
