# So you want your own private cloud hello?

There are two main tracks you can explore in these tutorials. There is also code available at [https://github.com/mrgeoffrich/learn-openstack-scripts](https://github.com/mrgeoffrich/learn-openstack-scripts) which this tutorial will use to automate as many of the steps as possible.

## 1. Learn OpenStack

The first track deploys OpenStack to a single virtual machine, and is great for learning how to use OpenStack. It will install a very functional single machine, with all of the main components required. For a single developer, this is enough to learn OpenStack. To follow this track, just finish up at the [OpenStack All in One](openstack-single.md) step.

## 2. Learn Complex OpenStack Deployments

The second track deploys OpenStack to a number of virtual machines. This is more relevant and useful for anyone who wants to run OpenStack at scale. In this deployment, different VMs are dedicated to different roles. This is a lot more difficult than a single machine deployment, but lets you take advantage of multiple servers if you have them.

__Note__: You can skip the [OpenStack All in One](openstack-single.md) step if you just want to focus on doing a multi-node deployment.

## Where do I begin?

Start with the [course overview](overview.md).

## Is this hard to run?

All the steps _should_ be completely repeatable, using some tools and files from my repo at [learn-openstack-scripts](https://github.com/mrgeoffrich/learn-openstack-scripts). Those scripts should get you from start to finish, including building the VM from scratch and installing OpenStack. I am trying to avoid any manual work required, and where there are manual steps its more for learning/exploration, or because I am yet to find a good way to automate it.

## Work in progress

I'm currently working on the steps for a multi-node deployment. The all in one deployment steps are complete.

Due to the reasonable amount of scripts I'm maintaining, there can be bugs! Please feel free to contact me if something isn't working as expected.

If you want to follow my current list of tasks and progress feel free to look at [my Trello board](https://trello.com/b/JYP6QyQm/learnopenstack). 

# What you will need

* A computer with 16GB of RAM (the more RAM the merrier)
* Virtualisation software
* Internet connectivity
* Time

## Supported Platforms

* You can run this from Windows 10, Mac OSX Sierra or a Linux machine.
* I'm looking to support VirtualBox, VMware Fusion and Hyper-V. VirtualBox and VMWare Fusion for the Mac and VirtualBox and Hyper-V for Windows.
* This should work under Linux as well for VirtualBox but I am currently not testing that scenario.
* Later down the track I would like to add support for KVM and EXSi.

## Knowledge which helps

You don't need to be expert in any of the below, but any knowledge is helpful.

* Linux, specifically Ubuntu 16.04
* Openstack
* Ansible
* Openstack-Ansible
* Virtualisation tooling
* Packer
* General networking concepts

## Why use these tools?

I wanted to use the most mature set of tooling for deploying OpenStack, in a wide range of configurations. So it should work for a single box deployment, but you can also take it further with a multi node configuration. Once you master these tools, you can then perform your own deployments on whatever scale and configuration you need. OpenStack-Ansible seems to have the most robust set of automation scripts for all the various components, even if it has a slightly steeper learning curve than say, [DevStack](https://docs.openstack.org/developer/devstack/).

You will also find the set of tooling included in these tutorials to be flexible to work across a wide range of hypervisors and platforms, if you require this. So it's not a huge amount of work to say, target Hyper-V instead of VirtualBox.

Currently the only big restriction is using Ubuntu as the guest operating system. This can potentially be expanded later with a few different options.

## A bit about me

I initially started exploring OpenStack as I was finding I wanted to explore running software that would achieve a similar automation capability as AWS, but was something I could run in my home lab.

My background is mostly VMWare/Windows stack/C#. I spent a fair bit of my career as a software developer and these days I mainly manage teams of software developers. Since they don't let me code at work I like to spend time at home with little (or big) projects, building stuff.

I also like to learn, so I take these opportunities to go off the beaten path and use a variety of operating systems, tools and languages that I haven't used before. I've taken a recent interest in private cloud technologies and a very keen interest in OpenStack.

I'm no expert in the technologies used in this tutorials, so if you know of ways to improve this tutorial please feel free to contact me or make a contribution!