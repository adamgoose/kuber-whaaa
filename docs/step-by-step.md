# Step-by-Step

## Step Zero: Get Ready

You'll need to install [tfenv]. You'll also need a [Digitalocean] account. Click
[here][Digitalocean] to get $100 free credit!

## Step One: Connect to Digitalocean

Create a [Personal Access Token][pat] with write access, and place it in a
`terraform.tfvars.json` file. Also choose a domain to serve your cluster at.

```json
{
  "do_token": "MY_PERSONAL_ACCESS_TOKEN_WITH_WRITE_ACCESS",
  "domain": "my.domain.com"
}
```

> The `/variables.tf` file declares two input variables that are required to
> apply this module: `do_token` and `domain`. Instead of passing them to
> `terraform apply` every time, we'll put them in this file.

## Step Two: Provision the Cluster

Terraform allows you to compose modules that are parameterizable and reusable.
We have a module called `cluster` that will create a Digitalocean Kubernetes
cluster and provide authentication information. Since every other module we're
using will depend on said cluster, let's get it up and running all by itself.

It will take around 5 minutes for Digitalocean to provision your cluster.
Terraform will log every 10 seconds as its waiting to indicate that things are
still working properly.

```bash
terraform apply -target module.cluster
```

> Terraform will provide some warnings about using the `-target` flag. They are
> not wrong, and the flag should be used sparingly. We're going to continue to
> utilize it within this project to demonstrate each component individually. By
> the time we're done, we'll be able to run `terraform apply` without the
> `-target` flag.

You can review the plan Terraform has for you, and simply enter `yes` to make it
happen!

Once your cluster has been created, you'll be able to see it on your
[Digitalocean Dashboard][clusters]. You'll also notice a new file has been
created: `kubeconfig.yaml`. This file contains connection information and
credentials for your newly created cluster. Keep it safe! Also, Digitialocean
rotates the credentials, so you might have to run the above command in a week
or so to update your `kubeconfig.yaml` file.

## Step Three: Install Some Modules

### Kubernetes State Metrics

Now that your cluster is up and running and you have your `kubeconfig.yaml` file,
you're ready to start installing things into the cluster. Let's start with
something simple: `kube-state-metrics`. This module will allow you to see the
[Advanced System Metrics][asm] in the [Digitalocean Dashboard][clusters]. Other
Kubernetes tools can also utilize this API to present cluster metrics to you.

```bash
terraform apply -target module.kube-state-metrics
```

It might take a few moments for the Metrics API server to be available. Once it
is, check out the [dashboard][clusters]! You could also use [k9s] to see these
metrics.

### Traefik

Next, we'll get started with our Kubernetes Ingress Controller. Kubernetes does
not handle ingress natively, however it provides API abstractions so that
Ingress can be handled by the proxy of your choice. I like [Traefik], but there
are several other options out there.

Point your domain's nameservers at `ns1.digitalocean.com.`,
`ns2.digitalocean.com.`, and `ns3.digitalocean.com.`. For example, if your
domain is `my.domain.com`, create the following entries in your domain's DNS
zone:

- `my.domain.com NS 60 ns1.digitalocean.com`
- `my.domain.com NS 60 ns2.digitalocean.com`
- `my.domain.com NS 60 ns3.digitalocean.com`

Next, do the magic:

```bash
terraform apply -target module.traefik
```

This will deploy Traefik, provision a Digitalocean Load Balancer (via Kubernetes
Services of type LoadBalancer), and configure DNS to point to said LoadBalancer.
Due to the way LoadBalancers are asynchronously provisioned, your command might
fail due to a missing IP address. Don't panic. Wait a few minutes, and try again.

### Cert-Manager

[Cert-Manager][cm] will automatically fetch Certificates from LetsEncrypt for
any Ingress resources created, which we'll be doing in the next step. First,
update `/modules/cert-manager/kustomize/cluster-issuer.yaml` to contain your
email address; this is required for LetsEncrypt.

```bash
terraform apply -target module.cert-manager
```

Again, due to the asynchronous nature of Cert-Manager, your command might fail
at first. Don't panic. Wait a few minutes, and try again.

## Step Four: Install Some More Modules

Now that our Infrastructure is ready to serve traffic to our apps, we need some
apps! Let's quickly bring up NodeRED and Minio, but not after updating their
respective `hostname`s in `/main.tf`.

```bash
terraform apply -target module.node-red -target module.minio
```

It will take a few minutes for your certificates to resolve. You can observe
this process:

```bash
KUBECONFIG=./kubeconfig.yaml kubectl get certificate --all-namespaces --watch
```

Once they're ready, head to `https://${node-red or minio hostname}` to see your
apps running!

That's everything this project has to offer. For solidarity's sake,  you can run
`terraform apply` without any arguments. Terraform will likely insist on
checking the value of your LoadBalancer's IP and update the DNS record
accordingly, however after saying `yes`, you'll notice 0 resources were changed.

## Step Five: Clean Up

Another nice thing about Infrastructure as Code is that it keeps track of
everything you've created in the cloud, from clusters to volumes to load
balancers... Time to destroy it all?

```bash
terraform destroy
```

Again, for reasons, you might have to run it a couple of times.

[tfenv]: https://github.com/tfutils/tfenv
[Terraform]: https://www.terraform.io/downloads.html
[ktp]: https://github.com/kbst/terraform-provider-kustomize
[Digitalocean]: https://m.do.co/c/6f278dc1a57d
[pat]: https://cloud.digitalocean.com/account/api/tokens
[clusters]: https://cloud.digitalocean.com/kubernetes/clusters
[asm]: https://www.digitalocean.com/docs/kubernetes/how-to/monitor-advanced/
[k9s]: https://k9scli.io/
[Traefik]: https://traefik.io
[cm]: https://cert-manager.io