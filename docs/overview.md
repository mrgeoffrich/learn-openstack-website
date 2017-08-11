# Course Overview

The current version of Openstack that is deployed with this tooling is [Ocata](https://releases.openstack.org/ocata/). When Pike eventually is released I will look at upgrading the scripts to deploy Pike as well.

Before you can perform the tasks, please [install the local pre-requisites](localprereq.md).

## Using this documentation

Please select your preferred hypervisor on the dropdown at the top right. This will customise what documentation is relevant for you, and will only show documentation for that particular hypervisor.

<div class="virtualbox" style="display: none">
<p>
You have selected Virtual Box documentation.
</p>
</div>

<div class="fusion" style="display: none">
<p>
You have selected VMware Fusion documentation.
</p>
</div>

<div class="hyperv" style="display: none">
<p>
You have selected Hyper-V documentation.
</p>
</div>

<div class="novisor" style="display: none">
<p>
Please select a preferred hypervisor using the dropdown at the top right.
</p>
</div>

## Track 1 - All in One OpenStack Deployment

This track is for people that just want to explore OpenStack. It will set up a single OpenStack VM.

1. [Set up an Ubuntu base image](baseimage.md)
2. [Deploy Openstack to a single VM](openstack-single.md)

## Track 2 - Multi-node OpenStack Deployment

This track is more gear towards people who want to learn how to deploy OpenStack into more complex environments. The section is still a work in progress.

1. [Set up an Ubuntu base image](baseimage.md)
2. [Set up a deployment server](deployserver.md)
3. [Set up a multi-node environment](multi-node.md)
