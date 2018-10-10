Based off of https://github.com/marcelo-ochoa/docker/tree/master/12.2-ru

To use, you will need to download the following patches from My Oracle Support and place file in this directory:  
p27674384_122010_Linux-x86-64.zip  
p27475613_122010_Linux-x86-64.zip  
p6880880_180000_Linux-x86-64.zip  

To build, run buildDockerImage.sh

This will build a patched installation of Oracle Database 12.2 Enterprise Edition and then build scripts as a new image

The following is the order that this image should be used:  
      oracle/database/12.2.0.1/base
      oracle/database/12.2.0.1/180417 (Latest Patchset)  
      oracle/database/12.2.0.1/scripts (Add latest scripts - invoked automatically by buildDockerImage.sh in 180417)

