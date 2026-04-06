Ansible Role Ubunut CIS
=========

An ansible role to perform Ubuntu hardening based on the latest CIS Benchmark published for Ubuntu 20.04.

Requirements
------------

Ansible Version Minimum 2.1

Role Variables
--------------

Review all default configuration before running this playbook, role variables defined in defaults/main.yml.

* Read and change configurable default values.

If you need you to change file templates, you can find it under `files/templates/*`

Dependencies
------------

Ansible version > 2.1

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```Yaml
---
- hosts: host1
  become: yes
  remote_user: root
  gather_facts: no
  roles:
    - { role: "ansible-role-ubuntu-cis",}
```

License
-------

BSD

Author Information
------------------

