
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>


#define  FIFOFILE  "/media/userdata/watchdog"

int main(int argc,char *argv[])
{
	if(0 != access(FIFOFILE,F_OK))
    {
        mkfifo(FIFOFILE,0666);
    }
	 int pipe_fd = open(FIFOFILE, O_RDONLY|O_NONBLOCK);
	 printf("open watchdog: %d \n",pipe_fd);

	 sleep(10);

	 char buff[2] = {0};
	 int num = 0;
     while(1)
     {
     	sleep(1);
         if(pipe_fd > 0)
         {
             int n = read(pipe_fd, buff, 1);
           // printf("watchdog n=%d num=%d ...\n",n,num);
             if (n != 1)
             {
                num++;
             }else
             {
             	num = 0;
             }
             if(num > 6)
             {
             	printf("watchdog hunger ...\n");
		system("echo 'watchdog hunger' >> /media/userdata/debuglog.log");
             	system("reboot");
             }
         }else
         {
         	printf("watcdog file not exist ...\n");
            system("reboot");
         }
        
     }
    close(pipe_fd);

}
