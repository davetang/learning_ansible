# Learning about Ansible

Ansible is a configuration manager (CM) tool that can orchestrate the
provisioning of infrastructure like VMs. Ansible uses a declarative
configuration style, which means it allows you to describe what the desired
state of infrastructure should look like. This is different from an imperative
configuration style, which requires you to supply all the minute details on
your desired state of infrastructure. Because of its declarative style, Ansible
is a great tool for software engineers who are not well versed in system
administration.

Ansible is written in Python, open-source, and free to use. The configuration
is written in Yet Another Markup Language (YAML), a data serialisation language
that Ansible uses to describe complex data structures and tasks. Two important
things worth noting is that YAML uses indentation to organise elements like
Python.

Ansible applies its configuration changes over SSH. The most common use of SSH
is to gain access to the command line on a remote host, but users can also
deploy it to forward network traffic and copy files securely. By using SSH,
Ansible can provision a single host or a group of hosts over the network.

## Ansible concepts

* `Playbook` - a playbook is a collection of ordered tasks or roles that you
can use to configure hosts.

* `Control node` - a control node is any Unix machine that has Ansible
installed on it. You will run your playbooks or commands from a control node,
and you can have as many control nodes as you like.

* `Inventory` - an inventory is a file that contains a list of hosts or groups
of hosts that Ansible can communicate with.

* `Module` - a module encapsulates the details of how to perform certain
actions across operating systems, such as how to install a software package.
Ansible coms preloaded with many modules.

* `Task` - a task is a command or action (such as installing software or adding
a user) that is executed on the managed host.

* `Role` - a role is a group of tasks and variables that is organised in a
standardised directory structure, defines a particular purpose for the server,
and can be shared with other users for a common goal. A typical role could
configure a host to be a database server. This role would include all the files
and instructions necessary to install the database application, configure user
permissions, and apply seed data.

## SSH

1. Generate key using `ssh-keygen` where `-f output_keyfile` and `-b bits`.

```console
ssh-keygen -t rsa -b 4096 -f ansible
```

2. Add public key `ansible.pub` to `~/.ssh/authorized_keys` on the host machine.
3. Change permission.

```console
cat ansible.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

4. Make sure `~/.ssh` is only accessible to you or else ssh will not use your
   key.

```bash
chmod 700 ~/.ssh
```

5. Add entry to `~/.ssh/config` on local machine.

```
Host my_host
  HostName 192.168.0.42
  User dave
  IdentityFile ~/.ssh/ansible
```

6. SSH using host name.

```console
ssh my_host
```

## Getting started

Ansible uses simple, human-readable scripts called playbooks to automate your
tasks. You declare the desired state of a local or remote system in your
playbook. Ansible ensures that the system remains in that state.

Inventories organise managed nodes in centralised files that provide Ansible
with system information and network locations. Using an inventory file, Ansible
can manage a large number of hosts with a single command.

Create a file named `inventory.ini` with the IP addresses of the machines to be
automated.

```
[myhosts]
192.168.0.42
```

Verify your inventory.

```console
ansible-inventory -i inventory.ini --list
```
```
{
    "_meta": {
        "hostvars": {}
    },
    "all": {
        "children": [
            "ungrouped",
            "myhosts"
        ]
    },
    "myhosts": {
        "hosts": [
            "192.168.0.42"
        ]
    }
}
```

Ping the `myhosts` group in your inventory.

```console
ansible myhosts --private-key ansible -m ping -i inventory.ini
```
```
192.168.0.42 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

For more hosts, use [YAML](https://docs.ansible.com/ansible/latest/getting_started/get_started_inventory.html#inventories-in-ini-or-yaml-format).
