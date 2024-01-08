# WSL-Linux-Kernel

My Experiment on WSL Linux Kernel

The goal of this experiment is to create a script (newkernel.sh) that download the request version of the source kernel from the official site and using the suggest .config compile a new version of WSL with latest kernel patches.

It will create a new bzImage-test in the folder c:\wslconfig and linked it to active windows user profile.

Any suggest or commit will be accepted.

Starting from Releases Kernel 5.12.3_OK it will be available my compiled kernel and also the needed files to create your own in sources.zip

Hope you will enjoy my job.

I just prepare different config file to compile different version kernel

- mywsl-config513-EOL is made for stable release 5.13.X EOL
- mywsl-config514-EOL is made for stable release 5.14.X EOL
- mywsl-config515 is made for stable release 5.15.X 
- mywsl-config516-EOL is made for stable release 5.16.X EOL
- myswl-config517-EOL is made for stable release 5.17.X EOL
- myswl-config518-EOL is made for stable release 5.18.X EOL
- mywsl-config519-EOL is made for stable release 5.19.X EOL
- mywsl-config60-EOL is made for stable release 6.0.X EOL

- mywsl-config61 is made for stable release 6.1.X
- mywsl-config62-EOL is made for stable release 6.2.X EOL
- mywsl-config63-EOL is made for stable release 6.3.X EOL
- mywsl-config64-EOL is made for stable release 6.4.X EOL
- mywsl-config65-EOL is made for stable release 6.5.X EOL
- mywsl-config66 is made for stable release 6.6.X
- mywsl-config67 is made for stable release 6.7.X
- mywsl-configrc is made for next release candidate 6.8-rc

- mywsl-configlt is made for longterm release 5.10.X

After compile kernel
if you want to add modules
must run

- make modules

- sudo make modules_install
