echo (( ( RANDOM % 2 )  + 1 )) > /var/www/html/goodbad.txt
exec "$@"
