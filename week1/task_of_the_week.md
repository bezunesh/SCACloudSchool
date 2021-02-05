## Task of the week

1. Create 3 groups 
   `echo group1 group2 group3 | sudo xargs -n1 -p groupadd`

2. Create 15 users and assign them accross the groups created above  
    
    ```
        #!/bin/bash
        for i in $(cat  users.txt); do
            useradd $i 
            if [[  $i =~ ^([a-d]) ]]; then
                    usermod -aG group1 $i
                    echo "user: $i added  in group1"
            elif [[ $i =~ ^([e-i]) ]]; then
                    usermod -aG group2 $i
                    echo "user $i added  in group2"
            else
                    usermod -aG group3 $i
                    echo "user $i added in group3"
            fi         
        done
    ```