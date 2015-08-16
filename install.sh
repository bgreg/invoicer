#!/bin/bash

install_file_if_missing() {
  if [ ! -f $1 ]; then  
    echo "making file $1"
    cp personal_info_template.rb personal_info.rb
  fi 
} 

install_directory_if_missing() {
  if [ ! -d $1 ]; then 
    echo "making directory $1" 
    mkdir $1
  fi
}


install_file_if_missing "personal_info.rb"
install_directory_if_missing "paid"
install_directory_if_missing "unpaid"
