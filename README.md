# terraform-gke-qse
Qlik Sense Enterprise deployed to a GKE kubernetes cluster with Terraform.

## Prerequisites
- Google Cloud SDK - https://cloud.google.com/sdk/install
- kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl/
- helm - https://github.com/helm/helm/blob/master/docs/install.md
- terraform - https://www.terraform.io/downloads.html
- git - https://git-scm.com/downloads

  
 Install all as per their instructions.  For helm, when running "helm init"add the "--client-only" flag.


## What you need:

you need to have a project set up in google. 

You will also need a service account and the credentials saved to  account.json (see: https://cloud.google.com/video-intelligence/docs/common/auth see: _Set up a service account_).


a variables file i.e. gke.tfvars containing:

```
network="us-central1"
region="us-central1"
initial_node_count=2
machine_type="n1-standard-2"
cluster_zone="us-central1-a"
cluster_name="terraform-qse-lkn-gke"
project="terraform-qse-lkn"
```
Rename basic-sample.yaml you basic.yaml  and edit to enter appropriate values for your identity provider.  Ensure the hostname set here matches what you will add to your hosts file/dns.

## Running it:

(below assumes linux, but the terraform scripts should be platform independent)
```
cd /somedirectory
git clone https://github.com/ljckennedy/terraform-gke-qse.git
cp myvarsfileicreated.tfvars ./terraform-gke-qse/gke.tfvars
cp account.json ./terraform-gke-qse/
cd ./terraform-gke-qse/
terraform init
terraform apply -var-file=gke.tfvars
```

This should take about 10 minutes to complete.  It will take longer for all the pods to dowload and start up.  

When completed you should see a output similar to this:
```
client_certificate = <sensitive>
client_key = <sensitive>
cluster_ca_certificate = <sensitive>
host = <sensitive>
run_this = gcloud container clusters get-credentials terraform-qse-lkn-gke --zone us-central1-a --project terraform-qse-lkn
```

cut and paste the command after _**'run_this = '**_ to get us kubectl to be able to monitor your kubernetes cluster.

To see if Qlik Sense is ready, run _**kubectl get pods**_.  All pods should show as running eventually.

To find out what IP address is assigned to qlik sense, run  _**kubectl get services qseonk8s-nginx-ingress-controller**_  

```
kubectl get services qseonk8s-nginx-ingress-controller
NAME                                TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                      AGE
qseonk8s-nginx-ingress-controller   LoadBalancer   10.47.246.238   34.67.192.149   80:30297/TCP,443:32482/TCP   82m
```

then edit your host file to add and entry for the external IP matching the hostname specified in your yaml file:
#### hosts file:
```
34.67.192.149 lkn.elastic.example
```

Now open your browser at https://lkn.elastic.example 

You should bew redirected to your IDP to login, and if login is successful, you should see this!

![alt text](https://github.com/ljckennedy/terraform-gke-qse/raw/master/image.png "QSE on K8S")



## Notes
This document assumes you are familiar with the basics of Qlik Sense Enterprise on Kubernetes.  See https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Deploying-Qlik-Sense-multi-cloud-Efe.htm for details.


This is the first release  - please provide feedback if you see issues in your environment.  
