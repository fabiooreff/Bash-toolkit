#!/bin/bash
echo "Bienvenido al configurador de red automático"
echo "Las interfaces detectadas son las siguientes"
ip a | grep "en" | awk -F: '{ print $2 }'
echo ""
echo "Los datos se han introducido en el siguiente orden:"
echo "1º interfaz, 2º red, 3º IP de la máquina, 4º puerta de enlace, 5º máscara 6º servdores DNS"
echo "7º dominio"
	interfaz=$1
	red=$2
    	ip=$3
	puerta=$4
	netmask=$5
	dnsname=$6
	search=$7
 # El parámetro -z comprueba si la variable está vacía y -n si está completa
if [ -z  $interfaz ] || [ -z $red ] || [ -z $ip ] || [ -z $netmask ] || [ -z $dnsname ] || [ -z "$search" ] || [ -z $puerta ]
    then
        echo "Debes introducir todos los parámetros"
        exit
else
    echo "Hacemos copia de seguirdad (el fichero será interfaces2)"
            cp /etc/network/interfaces /etc/network/interfaces2
	#Comprobamos si la interfaz introducida ya existe en el fichero, para no duplicarla
	interfichero=$(ip a | grep $interfaz | awk -F: '{ print $2 }')
	if [ $interfichero != $interfaz ]
		then
    echo "auto $interfaz" >> /etc/network/interfaces
    echo "iface $interfaz inet static" >> /etc/network/interfaces
    echo "address $ip" >> /etc/network/interfaces
    echo "netmask $netmask" >> /etc/network/interfaces
    echo "network $red" >> /etc/network/interfaces
    echo "gateway $puerta" >> /etc/network/interfaces
    echo "dns-nameservers $dnsname" >> /etc/network/interfaces
    echo "dns-search $search" >> /etc/network/interfaces
		else
			sed -i 's/dhcp/static/g' /etc/network/interfaces
			echo "address $ip" >> /etc/network/interfaces
			echo "netmask $netmask" >> /etc/network/interfaces
			echo "network $red" >> /etc/network/interfaces
			echo "gateway $puerta" >> /etc/network/interfaces
			echo "dns-nameservers $dnsname" >> /etc/network/interfaces
			echo "dns-search $search" >> /etc/network/interfaces
	fi

    echo "Configuración acabada"
    echo "Recuerde modificar el los ficheros hosts y resolv.conf si fuera necesario"
      service networking restart
    echo "se ha reiniciado la tarjeta de red"
        exit
 fi
