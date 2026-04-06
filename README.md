# Homelab Infrastructure

Personal homelab and project infrastructure — IaC, configuration management, deployment automation, and static sites.

## Structure

### `packer/`
Packer templates for building AWS machine images. Includes an AMI build that runs the CIS hardening Ansible role and an ECR Docker image build. Both use HCL and the Ansible provisioner plugin.

### `ansible-role-ubuntu-cis/`
Ansible role that applies CIS Benchmark hardening to Ubuntu 22.04. Used by the Packer AMI build as its provisioner. Covers all major CIS sections including network configuration, logging/auditing, access controls, and system maintenance.

### `terraform/`
Terraform code to provision the AWS environment. Organized into modules:
- **vpc** — VPC, public subnet, internet gateway, and route table
- **ec2** — Nextcloud server instance with an attached EBS data volume and security group
- **s3** — Private S3 bucket for static site hosting
- **cloudfront** — CloudFront distribution with OAC pointing at an S3 origin

### `scripts/`
Automation scripts for deployment and device management:
- `deploy_hairbygabrielac.yml` — Ansible playbook that syncs the HairByGabrielaC site to S3 and invalidates the CloudFront cache
- `deploy_logan_kicking_academy.yml` — Same for the Logan Kicking Academy site
- `check_activation_lock.sh` — Kandji custom script that checks for Activation Lock on enrolled devices
- `install_teleport_connect.sh` — Kandji custom script that installs Teleport Connect
- `install_cursor.sh` — Kandji custom script that installs Cursor and configures privacy settings

### `HairByGabrielaC/`
Static website for HairByGabrielaC. Deployed to S3 and served via CloudFront.

### `logan_kicking_academy/`
Static website for Logan Kicking Academy. Deployed to S3 and served via CloudFront.
