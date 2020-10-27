# Kuber-Whaaa?

> This presentation was prepared for the [Springfield Devs] [Dev Night].

[Kubernetes] is changing the way we deploy software on-premise and in the cloud.
Created by engineers at Google, Kubernetes is an open-source container-
orchestration and operations control-plane. That's a bunch of fancy words to say
"it runs your software." Let's take a look at how we can deploy a simple
application in Kubernetes using Terraform (infrastructure as code) from start to
finish!

This project is a simple demonstration of how you can go from zero to Kubernetes
quickly using Infrastructure as Code (namely Terraform). By the time we're done,
we'll have NodeRED and Minio running in a Kubernetes cluster with automatic DNS,
free SSL, and endless possibilities!

## Terraform

[Terraform] is a tool for provisioning your cloud infrastructure as code. This
allows you to version-control, parameterize, automate, and scale your
infrastructure design. To work with this project, it's recommended you install
[tfenv] with `brew install tfenv`.

## Included Modules

The `main.tf` file contains the following modules. Collectively, they comprise a
functional Kubernetes cluster on Digital Ocean.

- [cluster](modules/cluster)
- [kube-state-metrics](modules/kube-state-metrics)
- [traefik](modules/traefik)
- [cert-manager](modules/cert-manager)
- [node-red](modules/node-red)
- [minio](modules/minio)

[Springfield Devs]: https://www.meetup.com/sgfdevs
[Dev Night]: https://www.meetup.com/sgfdevs/events/271320688/
[Kubernetes]: https://kubernetes.io/
[Terraform]: https://terraform.io/
[tfenv]: https://github.com/tfutils/tfenv