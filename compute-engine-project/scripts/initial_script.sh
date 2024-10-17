#############mounting disks
DISK="/dev/sdb"
MOUNT_POINT="/mnt/disks/additional-disk"

# Crear el punto de montaje si no existe
sudo mkdir -p ${MOUNT_POINT}

# Comprobar si el disco ya tiene un sistema de archivos
if ! sudo blkid ${DISK}; then
  echo "Creating filesystem on ${DISK}"
  sudo mkfs.ext4 ${DISK}
fi

# Montar el disco
sudo mount -o discard,defaults ${DISK} ${MOUNT_POINT}

# Obtener el UUID del disco
UUID=$(sudo blkid -s UUID -o value ${DISK})

# Comprobar si la entrada ya existe en /etc/fstab
if ! grep -qs "${UUID}" /etc/fstab; then
  echo "Adding ${DISK} to /etc/fstab"
  echo "UUID=${UUID} ${MOUNT_POINT} ext4 discard,defaults 0 2" | sudo tee -a /etc/fstab
fi
sudo chmod 777 /mnt/disks/additional-disk


############installing docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# The following command is to set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` stable"

# Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version
sudo apt update
sudo apt install -y docker-ce
docker pull nginx
docker run --name mynginx -d -p 80:80 nginx
