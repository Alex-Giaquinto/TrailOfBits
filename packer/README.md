# Packer — AMI & ECR Image Builds

This directory contains [Packer](https://www.packer.io/) templates for building:

- **AMI** — a hardened Ubuntu 22.04 Amazon Machine Image (CIS-aligned)
- **ECR image** — a minimal Docker image published to Amazon ECR

## Directory layout

```
packer/
├── ami.pkr.hcl                     # AMI build definition
├── ecr.pkr.hcl                     # ECR Docker image build definition
├── variables.pkr.hcl               # Shared variable declarations
├── Makefile                        # Convenience build targets
├── files/
│   ├── cloudwatch-agent-config.json
│   └── app/
│       └── entrypoint.sh           # Container entrypoint
├── scripts/
│   ├── 01-system-update.sh
│   ├── 02-harden-os.sh
│   ├── 03-configure-auditd.sh
│   ├── 04-install-cloudwatch-agent.sh
│   └── 05-cleanup.sh
└── output/                         # Build manifests (git-ignored)
```

## Prerequisites

| Tool | Minimum version |
|------|----------------|
| Packer | 1.9.0 |
| AWS CLI | 2.x |
| Docker | 24.x |

AWS credentials must be available via environment variables, `~/.aws/credentials`, or an IAM instance profile.

## Usage

### Initialise plugins

```sh
make init
```

### Validate templates

```sh
make validate AWS_REGION=us-east-1 ECR_REGISTRY=123456789012.dkr.ecr.us-east-1.amazonaws.com
```

### Build the hardened AMI

```sh
make build-ami AWS_REGION=us-east-1 AMI_VERSION=1.2.0
```

The resulting AMI ID is written to `output/ami-manifest.json`.

### Build and push the ECR image

```sh
make build-ecr \
  AWS_REGION=us-east-1 \
  ECR_REGISTRY=123456789012.dkr.ecr.us-east-1.amazonaws.com \
  ECR_REPOSITORY=trailofbits/app \
  IMAGE_TAG=v1.2.0
```

### Build everything

```sh
make build-all \
  AWS_REGION=us-east-1 \
  ECR_REGISTRY=123456789012.dkr.ecr.us-east-1.amazonaws.com \
  IMAGE_TAG=v1.2.0
```

## What the AMI build does

1. Waits for cloud-init to complete
2. Applies all available OS security updates
3. Applies CIS-level hardening (sysctl, SSH, UFW, password policy)
4. Installs and configures `auditd` with a CIS-aligned ruleset
5. Installs the Amazon CloudWatch agent with log and metric collection
6. Cleans up build artefacts (SSH host keys, history, logs, temp files)

Notable AMI properties:
- Root EBS volume encrypted with KMS
- IMDSv2 enforced (no IMDSv1)
- SSH password authentication disabled; root login disabled
