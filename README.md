# arch-xfce-rdp
Arch Linux XFCE Container with Remote Desktop 

# How to Build:
- Clone this Repository 
- Update the bulidfiles/packages.txt with the packages that you wish to install on the container. 
- Build the image 

```bash
bash build-image.sh
```
- Update your docker-compose configuration file.
- Run the docker 

```bash
docker-compose up -d 
```
