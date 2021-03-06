#!/bin/bash
while true
do
   cat <<- EOF
   Instalación de servicios
1   Instalación LAMPP.
2   Instalación de servidor DNS (bind9)
3   Instalación de servidor DHCP
4   Instalación de servidor ftp (ProFTPD)
5   Instalación completa
6   Comprobar servicios
7   Salir
EOF
    read respuesta
    
    case $respuesta in
        1) echo "Instalaremos Apache2, MySQL y PHP"

            sudo apt install apache2 libapache2-mod-php php7.0-mbstring php-gettext mysql-server mysql-client libmysqlclient-dev;
            echo "Recuerda modificar los permisos de /var/www/html"
            ;;
        2) sudo apt install bind9;
        ;;
        3) echo "En progreso" ;;
        4) echo "En progreso" ;;
        5) echo "En progreso" ;;
        6) echo "En progreso" ;;
        7) echo "Adios";;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
