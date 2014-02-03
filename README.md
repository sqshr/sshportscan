sshportscan
===========

This is a simple bash script to conduct a portscan using SSH port forwarding. It uses/abuses the control sequences to set and remove port forwards, and curl to detect if a service is listening on the found port. The script doesn't read options in, these are defined in the script itself (but they should be pretty clear).
