# Setting up a deployment server

A deployment server will set up a machine that you can perform multi-node deployments from. It will store all the various OpenStack Ansible scripts to apply to all the nodes.

Let's clone your base image, customise the image and deploy the correct assets on it to get it ready to perform a more complex OpenStack deployment.

We are going to use [OpenStack-Ansible](https://docs.openstack.org/developer/openstack-ansible/) to perform the deployment with.

### Prerequisites

Ensure that you have already done the steps to [Install prerequisites](localprereq.md) and [Set up a Base Image](baseimage.md).

## Create deployment server

We can now run another packer build, which will take the base image and make some changes to it, to prepare it. 

<div class="virtualbox" style="display: none">
Run: 
<code>packer build --only=virtualbox-ovf deployserver.json</code>
</div>

<div class="fusion" style="display: none">
Run: 
<code>packer build --only=vmware-vmx deployserver.json</code>
</div>

<div class="hyperv" style="display: none">
<p><b>Note</b> - You will need to set up an external Virtual Switch and set the variable in deployserverhyperv.json to match the name of this switch.</p>
Run: 
<code>packer build --only=hyperv-iso deployserverhyperv.json</code>

</div>

<div class="novisor" style="display: none">
<p>
Please select a preferred hypervisor using the dropdown at the top right.
</p>
</div>

### What it's doing

This build step will take the base image created and do some slight customisation to it to make it suitable to perform deployments from.