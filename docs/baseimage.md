# Creating a Base Image

A base image is an image of a virtual machine. The base image will be an installed and configured Ubuntu 16.04 server. This image can then be cloned multiple times to create copies to use when provisioning new virtual machines. This greatly speeds up the process to creating multiple machines and does it in a reliable manner.

The main tool in use here is Packer. Packer will automatically install Ubuntu from the installation ISO and configure it correctly. Once the installation is done, the final installed image is placed into a folder ready for use.

## YouTube Tutorial

The virtualbox steps on a mac are available as a youtube tutorial now!

<iframe width="560" height="315" src="https://www.youtube.com/embed/IDjibt2aLOQ?ecver=1" frameborder="0" allowfullscreen></iframe> <br/>

## Creating an Ubuntu 16.04 base image

First clone this repo:

```git clone https://github.com/mrgeoffrich/learn-openstack-scripts```

Then run the packer build for your virtualisation tool of choice. Change directory into the repo.

<div class="virtualbox" style="display: none">
Run: 
<code>packer build --only=virtualbox-iso ubuntu1604base.json</code>

</div>

<div class="fusion" style="display: none">
Run: 
<code>packer build --only=vmware-iso ubuntu1604base.json</code>

</div>

<div class="hyperv" style="display: none">
<p><b>Note</b> - You will need to set up an external Virtual Switch and set the variable in ubuntu1604base.json to match the name of this switch.</p>
Run: 
<code>packer build --only=hyperv-iso ubuntu1604base.json</code>

</div>

<div class="novisor" style="display: none">
<p>
Please select a preferred hypervisor using the dropdown at the top right.
</p>
</div>

### What it's doing

Packer will download the ubuntu 16.04 ISO, create a new blank virtual machine, then automatically step through the installation process for Ubuntu 16.04. Once the installation is done, and SSH is available, packer will SSH in and run a number of commands to continue setting up the machine. If you want to look at the configuration, the ```ubuntu1604base.json``` file is the packer config, and in the scripts folder are the shell scripts that are executed.

### What it creates

<div class="virtualbox" style="display: none">
There will be a virtualbox/base-ubuntu folder with the VirtualBox (ovf) virtual machine files inside.
</div>

<div class="fusion" style="display: none">
There will be a vmware/base-ubuntu folder with the VMware (vmx,vmdk) virtual machine files.
</div>

<div class="hyperv" style="display: none">
There will be a hyperv/base-ubuntu folder with the Hyper-V format virtual machine files.
</div>
