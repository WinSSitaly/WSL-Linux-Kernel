# WSL-Linux-Kernel

My Experiment on WSL Linux Kernel

The goal of this experiment is to create a script (newkernel.sh) that download the request version of the source kernel from the official site and using the suggest .config compile a new version of WSL with latest kernel patches.

It will create a new bzImage-test in the folder c:\wslconfig and linked it to active windows user profile.

Any suggest or commit will be accepted.

Starting from Releases Kernel 5.12.3_OK it will be available my compiled kernel and also the needed files to create your own in sources.zip

Hope you will enjoy my job.

I just prepare different config file to compile different version kernel

- mywsl-config13 is made for stable release 5.13.X EOL
- mywsl-config14 is made for stable release 5.14.X EOL
- mywsl-config15 is made for stable release 5.15.X 
- mywsl-config16 is made for stable release 5.16.X EOL
- myswl-config17 is made for stable release 5.17.X
- myswl-config17 is made for stable release 5.18.X
- mywsl-configrc is made for release candidate (latest 5.18.Xrc) [work in progress]
- mywsl-configlt is madee for longterm release 5.10.X
