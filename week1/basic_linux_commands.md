## Basic linux commands

1. Create a group: <i>SCASchool</i>  
    <code>sudo groupadd SCASchool</code>

2. create a user: <i>yusuf</i>  
   <code>sudo adduser yusuf</code>

    login into the new user and create a text file  
    <code> sudo su yusuf </code>  
    <code> cd /home/yusuf </code>  
    <code> nano intro_to_devops.txt </code>

3.  Assign the new user to the group <i>SCASchool</i>  
    <code>sudo usermod -aG SCASchool yusuf</code>

     Check the groups of the new user:  
    <code>groups yusuf</code>  
    <b>output: </b>   
    yusuf : yusuf SCASchool

4. Change group owner of the text file to <i>SCASchool</i>
  
    <code> yusuf@ip-172-26-7-195:~$ chgrp SCASchool intro_to_devop.txt</code>   

5. Give write permission on the text file to the group <i>SCASchool</i>   
    <code> yusuf@ip-172-26-7-195:\~$ chmod g\+rw intro_to_devop.txt  </code>  
    <code>yusuf@ip-172-26-7-195:~$ ls -la </code>  
    <b>output:</b>