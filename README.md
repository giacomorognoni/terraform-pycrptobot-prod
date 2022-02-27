# terraform-pycryptobot-prod

## Overview

The aws infrastructure required to run the pycryptobot instantiation as a daemon service.

## Infrastructure

The project includes the following infrastructure:

### Resources

* ECS Cluster: ECS cluster to host ecs tasks running pycryptobot as a daemon service.
* ECR Repository: ECR repository to host pycryptobot docker image pushed from pycryptobot repo.
* ECS Task: ECS task that pulls docker image from ECR and runs the pycryptobot as a daemon.
* Nat Gateway: Nat Gateway to allow traffic from private subnet running ecs task with internet gateway.
* Internet Gateway: Internet Gateway to receive traffic from Nat Gateway and allow the pycryptobot to communicate with the relevant crypto exchanges in order to perform trades.
* Load Balancer: Load balancer to distribute traffic to relevant servers.
* Routing tables: Routing tables to route traffic to the relevant subnet and task.
* Security groups and NACLs: To limit traffic across infrastructure.
* IAM roles: Relevant iam roles to allow ECS task to interface with relevant services and move through security groups and NACLs.

### Variables

All variables are defined using terraform cloud integrated with the relevant github repo.