# WSL-Linux-Kernel

My Experiment on WSL Linux Kernel

The goal of this experiment is to create a script (newkernel.sh) that download the request version of the source kernel from the official site and using the suggest .config compile a new version of WSL with latest kernel patches.

It will create a new bzImage-test in the folder c:\wslconfig and linked it from active windows user profile.

Any suggest or commit will be accepted.

Starting from Releases Kernel 5.12.3_OK it will be available my compiled kernel and also the needed files to create your own in sources.zip

Hope you will enjoy my job.

I just prepare 3 different config file to compile kernel

- mywsl-config is done for stable release
- mywsl-configrc is done for release candidate
- mywsl-configlt is done for longterm release 

