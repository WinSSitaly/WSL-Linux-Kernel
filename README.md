# WSL-Linux-Kernel

My Experiment on WSL Linux Kernel

The goal of this experiment is to create a script (newkernel.sh) that download the request version of the source kernel from the official site and using the suggest .config compile a new version of WSL with latest kernel patches.

It will create a new bzImage-test in the folder c:\wslconfig and linked it from active windows user profile.

Any suggest or commit will be accepted.

Starting from Releases Kernel 5.12.3_OK it will be available my compiled kernel and also the needed files to create your own in sources.zip

Hope you will enjoy my job.

I just prepare different config file to compile different version kernel

- mywsl-config13 is done for stable release 5.13.X EOL
- mywsl-config14 is done for stable release 5.14.X EOL
- mywsl-config14 is done for stable release 5.15.X 
- mywsl-config14 is done for stable release 5.16.X 
- mywsl-configrc is done for release candidate (actually 5.17.X)
- mywsl-configlt is done for longterm release 5.10.X
