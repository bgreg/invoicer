#!/bin/bash

install_file_if_missing() {
  if [ ! -f $1 ]; then
    echo "making file $1"
    cp $2 $1
  fi
}

install_directory_if_missing() {
  if [ ! -d $1 ]; then
    echo "making directory $1"
    mkdir $1
  fi
}

install_file_if_missing "personal_info.rb" "templates/personal_info_template.rb"
install_file_if_missing "last_invoice.txt" "last_invoice_template.txt"
install_directory_if_missing "paid"
install_directory_if_missing "unpaid"
bundle install
