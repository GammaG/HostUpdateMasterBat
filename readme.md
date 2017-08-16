My contribution to the https://github.com/StevenBlack/hosts project.

1. First execute
The batch will on first execute git clone for the current project and copy the pulled content into system32/drivers/etc. 
You may want to put your myhosts file into the folder, otherwise the default one from the repository will be copied.
Finally it will execute the project itself and flush the dns after.
So this is more or less an one click installer.

2. Later executes
If the project already exists in system32/driver/etc it will execute and git pull the master branch of the project.
After that it will execute the project itself and flush the dns after.

Important:
Git and python is needed to be available on console for this script to work.
So have it in your path before executing. 

Also the .bat needs to be executed as administrator because otherwise it won't be able to write in system32.




 