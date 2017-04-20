
1. Gateone

Example: https://localhost:4433/?ssh=ssh://ubuntu:ubuntu@10.66.33.4:22

2. noVNC

Example: https://localhost:6080/vnc.html?token=xxxx&password=yyyy&autoconnect=1&encrypt=1

3. Lan2Internet

* Internet: 10.66.33.2
* Lan: 10.66.33.4

Lan, novnc:
    $ ssh -nNT -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -R 5001:10.66.33.4:5900 ubuntu@10.66.33.2

Lan, ssh:
    $ ssh -nNT -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -R 2001:10.66.33.4:22 ubuntu@10.66.33.2

Internet, novnc:
    https://localhost:6080/vnc.html?token=md5sum of 5001&password=yyyy&autoconnect=1&encrypt=1

Internet, ssh:
    https://localhost:4433/?ssh=ssh://ubuntu:ubuntu@10.66.33.2:2001
