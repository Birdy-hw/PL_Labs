#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>

int main(int argc, char *argv[]) { //here we are taking the input and output file names as args from the cmd line
    
    if(access(argv[2], F_OK) == 0){ // this checks if the output file already exists, if it does it throws an error
        printf("Output file already exists \n");
        exit(0);
    }
    if(access(argv[1], F_OK) == -1){ // this checks if the input file exists, if it doesn't it throws an error
        printf("Input file doesn't exists \n");
        exit(0);
    }
    
    int input_file = open(argv[1], O_RDONLY); //opening the input file in Read Only Mode and storing descriptor
    int output_file = open(argv[2], O_WRONLY | O_CREAT , 0644); //opening the output file in Write Only and 
                                                                //giving permission to create it
    
    const char *name = "Kyle M. Dsouza"; //Hard-coding name
    write(output_file,name, strlen(name)); //writing name to output file
    write(output_file, " ", 1);
    
    uid_t uid = getuid(); //getting User ID using function call
    char uid_str[10];
    int uid_len = sprintf(uid_str,"%d\n",uid);
    write(output_file,uid_str,uid_len); //writing User ID to output file

    char buffer[100];

    write(output_file, buffer, read(input_file, buffer, 100)); //writing the contents of input file to output file

    close(input_file); //closing both files
    close(output_file);

    return 0;
}
