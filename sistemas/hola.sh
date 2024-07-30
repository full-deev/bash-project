#!bin/bash/

#read -p "usuario: " user
#read -s -p "contraseña: " password

while IFS= read -r line; do 
    if [[ $line == $user ]] then
	    echo bienvenido, @$user!
	    #echo $password
	    # Aquí puedes realizar la acción deseada
	    # # ...
    else
	    echo No se encontro $user
    fi
done < data.txt
