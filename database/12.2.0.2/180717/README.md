Based off of https://github.com/marcelo-ochoa/docker/tree/master/12.2-ru

To use, you will need to download the following patches from My Oracle Support and place file in this directory:  
p27923353_122010_Linux-x86-64.zip  
p28163133_122010_Linux-x86-64.zip  
p6880880_180000_Linux-x86-64.zip  

To build, run buildDockerImage.sh

This will build a patched installation of Oracle Database 12.2 Enterprise Edition.   

The following is the order that this image should be used:  
      oracle/database/12.2.0.1-ee  
      oracle/database/12.2.0.1.YYMMDD-ee (Latest Patchset)  
      oracle/database/12.2.0.1.YYMMDD-ee-scripts (Add latest scripts)  

