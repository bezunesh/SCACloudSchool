#!/bin/bash
for i in $(cat  users.txt); do
        useradd $i
        if [[ $i =~ ^([a-d]) ]]; then
                usermod -aG group1 $i
                echo "user: $i added  in Group1"
        elif [[ $i =~ ^([e-i]) ]]; then
                usermod -aG group2 $i
                echo "user $i added  in Group2"
        else
                usermod -aG group3 $i
                echo "user $i added in group3"
        fi         
done
