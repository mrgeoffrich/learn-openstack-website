# Local Prerequisites

Some tools need to be installed locally before you can start. They are:

1. VirtualBox
2. Packer
3. Ansible
4. Git

It's also good to have these tools locally if you want to do your own work on scripts or automation.

## Mac steps

* [Install homebrew](https://brew.sh/)
* Install Python: ```brew install python```
* Install Ansible: ```pip install ansible```
* Install Packer: ```brew install packer```
* Install VirtualBox: ```brew cask install virtualbox```
* Install VirtualBox extension pack: ```brew cask install virtualbox-extension-pack```

## Windows steps

* If you are using Windows 10, install [Windows Subsystem for Linux](https://msdn.microsoft.com/en-au/commandline/wsl/install_guide)
* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Install VirtualBox extensions](https://www.virtualbox.org/wiki/Downloads)
* [Install packer](https://www.packer.io/intro/getting-started/install.html)
* Using the Windows Subsystem for Linux (WSL), install Ansible using the linux instructions below

## Linux steps

* Install Ansible:

```
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

* Install [Packer](https://www.packer.io/intro/getting-started/install.html)

```
wget https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip
sudo apt-get install unzip
unzip packer_1.0.0_linux_amd64.zip
sudo mv packer /usr/bin
rm packer_1.0.0_linux_amd64.zip
```

* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Install VirtualBox extensions](https://www.virtualbox.org/wiki/Downloads)