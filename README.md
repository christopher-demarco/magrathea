# Magrathea

Generate lab infrastructure for an Ansible class.

There are two modes of operation. The first is to create a series of
instances which serve as students' workstations for running the class
exercises.

The second is to run from within a student's workstation to
create/destroy a second instance which she can provision via Ansible.


## Prerequisites

- [Terraform](http://terraform.io)
- [Ansible](http://ansible.com)
- [Python 3](docs.python-guide.org)

You will also need a Google Cloud account, properly set up with a
project and service account credentials, and a DNS domain set up in
Google Cloud. FIXME Replace all occurrences of my domain `foam.ninja`
with your own.


# Creating a workstation

1. Run `generate_workstation_list.py` to create the list of hostnames
   to be created.
2. Ensure that `workstation/keys` contains (a) Google Cloud
   credentials and (b) an SSH keypair. Don't check this directory into
   source control!
3. `cd` into `workstations` and run `terraform init ; terraform up`.

Instances will be created such that, for an instance
`foo-bar.foam.ninja`, the user `foo` exists with the password `bar`.
Inside that user's home directory will be directories containing the
class materials, and a `.profile` to automagically prepare to run
Ansible.

Also inside the user's home directory will be a configuration of the
Magrathea project itself, suitable for creating a second instance
`alpha.foo-bar.foam.ninja` for the student to 


# Creating an SSH host

1. SSH into the workstation
2. `cd` to `magrathea/workstation` and run `terraform init ; terraform up`.

