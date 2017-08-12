# Deploying OpenStack to a single VM

This is a great place to start with OpenStack as it keeps the deployment relatively simple, but also aims to stand up the core OpenStack components.

## Prerequisites

Ensure that you have already done the steps to [Install prerequisites](localprereq.md) and [Set up a Base Image](baseimage.md).

## YouTube Video

This tutorial is now also available as a YouTube video to watch that focuses on the VirtualBox solution. You can follow this along with the steps below.

<iframe width="560" height="315" src="https://www.youtube.com/embed/uN9D9uXk4oA?ecver=1" frameborder="0" allowfullscreen></iframe>

## Create the all in one target server

We can now run another packer build, which will take the base image and make some more changes to it.

<div class="virtualbox" style="display: none">
<div>Run</div>
<code>packer build --only=virtualbox-ovf allinoneserver.json</code>

</div>

<div class="fusion" style="display: none">
<div>Run</div>
<code>packer build --only=vmware-vmx allinoneserver.json</code>

</div>

<div class="hyperv" style="display: none">
<p><b>Note</b> - You will need to set up an external Virtual Switch and set the variable in allinoneserver.json to match the name of this switch.</p>
<div>Run</div> 
<code>packer build --only=hyperv-iso allinoneserver.json</code>

</div>

<div class="novisor" style="display: none">
<p>
Please select a preferred hypervisor using the dropdown at the top right.
</p>
</div>

### What it's doing

This build step will take the base image and do some slight customisation to it to make it suitable to perform an all in one installation. This base image is cloned, and then some more shell scripts are executed on the VM to make some more changes.

<div class="hyperv" style="display: none">
<b>Hyper-V Special Note</b> - At the moment the all in one server is built from scratch and is not cloned. This will be fixed later to reduce the time it takes but this will require some custom scripting as Packer doensn't support building a VM from a vhdx file.
</div>

These scripts will clone the openstack-ansible repository and runs some of the openstack-ansible scripts which prepares the machine for an installation.

Another folder called `allinone-server` will be created which contains the VM files for this new machine.

## Start the VM

Time to actually configure the networking and start the VM. Just a quick note, the networking I recommend for ease of use, is to make sure the VM is connected to the same network as your development machine. This makes it a lot easier to connect to, but it also means if you switch networks on your machine, you might have troubles connecting to the all in one VM afterwards. Your VM will get an IP from the same DHCP server are your development machine.

<div class="virtualbox" style="display: none">

<p>First import the built VM image into VirtualBox:</p>

<code>VBoxManage import ./virtualbox/allinone-server/allinone-server.ovf</code>

<p></p>

<p>This networking part is a bit tricky depending on your network setup. You want your new VM to be a part of your local network. It does this by attaching to your wifi or LAN connection and getting an IP address just like your development machine.</p>

<p>Running the following code will list all your network interfaces that you can connect the VM to:</p>

<code>VBoxManage list bridgedifs</code>
<p></p>
<p>In my case, my wifi adapter comes up at "en0: Wi-Fi (Airport)". This is the network my laptop is currently connected to (and it gets is IP from this network as well). You now want to attach the VM to this particular network via the following commands. The first command sets the network adapter to bridge and attaches it to my Wi-Fi adapater (named "en0: Wi-Fi (AirPort)"). The second command enables promiscuous mode which is essential for the networking to operate correctly.</p>

<code>VBoxManage modifyvm "allinone-server" --nic1 bridged --bridgeadapter1 'en0: Wi-Fi (AirPort)'</code><br/>
<code>VBoxManage modifyvm "allinone-server" --nicpromisc1 allow-all</code><br/>
<p></p>
<p>Now start the VM:</p>

<code>VBoxManage startvm allinone-server</code>

</div>

<div class="fusion" style="display: none">

Manually go into the network settings on the VM and select, under "Bridged Networking", the current network that your Mac is connected to. Then run:

<code>/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion start ./vmware/allinone-server/allinone-server.vmx</code>
</div>

<div class="hyperv" style="display: none">

Run the following powershell to import and start the VM:

<code>
$vmpath = '.\hyperv\allinone-server\Virtual Machines'

$files = Get-ChildItem -Path $vmpath -Filter '*.vmcx'
$vmcxFilePath = $vmpath + '\' + $files[0].Name
Import-VM $vmcxFilePath  -Copy -GenerateNewId

Start-VM -Name "allinone-server"
</code>

</div>


## Start the OpenStack deployment

To start the deployment, ssh into the machine using the default vagrant username and password, which is vagrant/vagrant. Then run the following commands:

```bash
sudo su
cd /opt/openstack-ansible
scripts/bootstrap-aio.sh
scripts/run-playbooks.sh
```

And now wait! It takes a fair bit of time for the installation to complete, so give it about 30 minutes.

## Post deployment exploration

### SSH into your new machine

So now that the machine is all set up, what now? Time to explore your awesome all in one deployment!

First to make things a bit easier, you want to ensure you can SSH into the machine from your desktop. Using the console of the VM, log in (using vagrant/vagrant) and get the IP of the server by typing:

`cat /etc/openstack_deploy/openstack_user_config.yml | grep external_lb_vip_address | cut -d ' ' -f 4`

You will also need to turn on password authentication for SSH. Using `sudo nano /etc/ssh/sshd_config` edit the line that has `PasswordAuthentication` and set the value to `yes`.

Now restart the ssh deamon by typing `systemctl restart sshd`.

### Dashboard

Next step is to access the dashboard, and you can explore openstack via "Horizon" which is the name of the dashboard website in OpenStack.

There are two main users you will want to use to explore the server. One is admin, the other is demo. The user demo always has the password demo. To find the admin password run the following on the allinone server by typing:

`cat /etc/openstack_deploy/user_secrets.yml | grep keystone_auth_admin_password | cut -d ' ' -f 2`

You will notice the user_secrets.yml file contains all the passwords generated for this installation.

Now browse to https://allinone or https://192.168.0.50 (where you put in the proper IP address there) to get to the dashboard.

Now that you have the dashboard open log in as the user "demo". Now lets provision a server and get it working!

### One more Network Setting

One more network setting needs to be modified on your desktop. When you create servers on Openstack you can give them public IP addresses. These are the IP addresses that the outside world (ie, your desktop in this case) use to access the server.

You need to configure your desktop to route traffic for those IP addresses through the allinone VM. By default, the all in one OpenStack installation will set up a subnet `172.29.248/22` for these public "floating" IPs.

Say the IP of your allinone VM is 192.168.0.50:

* On a Mac, add a route using the command `sudo route -n add 172.29.248/22 192.168.0.50`
* On a Windows machine, add a persistent route using the admin command prompt `route add -p 172.29.248.0 MASK 255.255.252.0 192.168.0.50`

__Note__: On a Mac, this command will need to be re-run if you restart your machine.

### Provision a VM in OpenStack

These steps are just general OpenStack steps, but will get you a server up and running quickly just to make sure everything is operating. The OpenStack installation comes with a mini-OS called Cirros which is useful for testing your OpenStack installation. These steps will also ensure you can connect in to and out from the VM properly.

#### DNS Setting

The first step allows your VMs to talk _out_ to a DNS server. Go to Project -> Network -> Networks -> private -> Subnets -> private-subnet -> Edit Subnet. On the "Subnet Details" screen set the DNS to 8.8.8.8. (You can use another DNS server if you required it here)

#### Security - Allow SSH & ICMP in

Then to the default security group, add SSH and ICMP traffic so you can SSH into and ping your new VMS. Go to Project -> Network -> Security Groups -> Manage Rules (on default). Add a rule for "All ICMP" , Ingress, from CIDR 0.0.0.0/0. Add a rule for "SSH", Ingress, from CIDR 0.0.0.0/0.

#### A New Key Pair

Then navigate to Project -> Compute -> Key Pairs. Create a new key pair, name it however you want.

#### Create the VM

Then navigate to Project -> Compute -> Instances. Click Launch instance. Set the Instance Name to what you like, then go to the next screen. For the source select "cirros" (using the little up arrow button). Click next. For the flavour select "temptest2" (again using the little up arrow). Click next. Select the "private" network, click next. Leave network ports empty. Click next. Leave the default security group selected. Click next. You new key pair is already selected, click "Launch Instance". The remaining sceens don't need input but feel free to browse through them if you are interested in what you can configure.

Once the VM is up and running, the Power state will change to "Running". Click on the instance name, click on log, then on "View Full Log". When the VM boots it should show you that its aquired a DCHP address and has booted succesfully.

#### Associate a Floating IP

Now, back at the screen with the VM, select "Associate Floating IP". Click the plus button and click "Allocate IP". Then click "Associate". You now have a real IP you can SSH in to, from your desktop!

#### Finally, SSH in

Now from your desktop, SSH into this IP with the username cirros and the password cubswin:) and from inside this machine you should be able to ping www.google.com.

You should also be able to ping the floating IP from your desktop.

### The Utility Container

OpenStack also has a very comprehensive command line tool that can be used to manage all aspects. When the all in one server is set up, there is a special utility container which you can use which comes ready for using the command line tool.

SSH into the allinone server, and run the following command to attach into a special utility container:

```bash
sudo su
lxc-attach -n `lxc-ls -1 | grep utility`
```

Run a few of these next commands to explore the OpenStack environment from the command line. The first command configures the openstack client. The remaining commands list out various items from the environment.

```bash
source /root/openrc
openstack project list
openstack image list
openstack user list
openstack network list
openstack service list
```

Type `exit` to get out of the LXC container.

## What next?

Feel free to explore the other parts of openstack! Log in with the admin user and have a look at the special screens that the admin user can see. Try playing with other services like the object store and the DNS and orchestration services!