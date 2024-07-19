archivo="datos.txt"

function login (){
	echo 
	cat $archivo | awk '{print $0}'
	if [ $vuser == "milo" ] && [ $vpass == "1408" ]; then
		echo bienvenido, @$vuser
	
	else
		echo datos no son correcto
		read -p "¿Deseas registrarse?(s/n)" op
		if [ "s" == $op ] ; then
			register
		else
			exit 1
		fi
	fi
	

}

function register(){
	read -p "crea tu usuario: " vuser	
	read -s -p "crea tu clave: " vpass
	echo $vpass >> p.txt
	echo $vuser >> u.txt
	echo 
	cat u.txt
	cat p.txt
}

function menu (){
	echo ¡bienvenidos al juego del AHORC*DO!
	echo
	echo "1-> Login"
	echo "2.> Register"
	echo "3-> Jugar invitado"
	echo "4-> Salir"
	sleep 1
	
 	read -p "ingresa el número del menú: " op
	if [ $op == 1 ]; then
		read -p "ingresa tu usuario: " vuser
		
		read -s -p "ingresa la clave: " vpass
		
		login
	elif [ $op == 2 ]; then
		register
	elif [ $op == 3 ]; then
		juego
	elif [ $op == 4 ]; then
		exit 1
	fi
}

menu
