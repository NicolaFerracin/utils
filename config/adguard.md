## How to install, setup and run AdGuard

- Run AdGuard docker image
  ```
  docker run -d \
    --name adguardhome \
    -v $PWD/adguard/work:/opt/adguardhome/work \
    -v $PWD/adguard/conf:/opt/adguardhome/conf \
    -p 53:53/tcp -p 53:53/udp \
    -p 3000:3000/tcp \
    -p 80:80/tcp \
    adguard/adguardhome
  ```
- Find AdGuard Server IP address (i.e. `http://192.168.1.212`)
  ```
  ifconfig | grep inet
  // Look for something like 192.168.1.23 under en0 or en1.
  ```
- In the Router DNS Server, set the LAN DNS Server to the above IP address
    - For DIGI, this is:
      ```
      http://192.168.1.1/
      user: user - pw: user
      Red Local > LAN > Servidor DHCP > Turn off ISP DNS > Enter AdGuard Server IP Address
      ```
- Go to the AdGuard server address, at port 3000, where AdGuard is running (i.e. `http://192.168.1.212:3000`) and conclude setup
