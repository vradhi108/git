#!/bin/bash

#!/bin/bash

option=$1

function create_user() {
    read -p "Username: " username
    if [ $(cat /etc/passwd | grep "$username" | wc | awk '{print $1}') == 1 ]
    then
	    echo "USER EXISTS"
    else
	    
    	read -p "Password: " password

    	# Create the user
   	sudo useradd $username

    	# Set the password for the user
    	echo -e "$password\n$password" | sudo passwd $username
	echo "USER CREATED SUCCESSFULLY"
    fi

}

function delete_user() {
	read -p "Username: " username
	if [ $(cat /etc/passwd | grep "$username" | wc | awk '{print $1}') == 0 ]
	then
		echo "USER DOES NOT EXIST"
	else
		sudo userdel $username
		echo "USER DELETED SUCCESSFULLY"
	fi
}

function reset_password() {
	read -p "Username: " username
	if [ $(cat /etc/passwd | grep "$username" | wc | awk '{print $1}') == 0 ]
	then echo "USER DOES NOT EXIST"
	else
		read -p "New Password: " new_password
		echo -e "$new_password\n$new_password" | sudo passwd $username
		echo "PASSWORD UPDATE SUCCESSFULLY"
	fi
}

function list_users() {
	cat /etc/passwd
}

function help() {
	echo "Syntax - <options>"
	echo "options"
	echo "-c or --create - to create a new user"
	echo "-d or --delete - to delete an existing user"
	echo "-r or --reset - to reset password of an existing user"
	echo "-l or --list - to list all the users"
}

if [ $option == "-c" ] || [ $option == "--create" ]
then
	create_user
elif [ $option == "-d" ] || [ $option == "--delete" ]
then
	delete_user
elif [ $option == "-r" ] || [ $option == "--reset" ]
then
	reset_password
elif [ $option == "-l" ] || [ $option == "--list" ]
then
	list_users
elif [ $option == "-h" ] || [ $option == "--help" ]
then
	help
else
	echo "Invalid Option"
fi







