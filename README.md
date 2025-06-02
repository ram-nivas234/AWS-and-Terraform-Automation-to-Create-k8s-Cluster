# kubeadm k8s Automation using Terraform & ansible in Aws

This is a complete guide for kubeadm k8s setup using Terraform & ansible with 1 master node & 2 worker node .

**----------Some_Useful_Terraform_Commands-------------**

terraform init -- create enviornment

terraform validate -- to check if any syntax error 

terraform plan

terrafrom apply / terraform apply -auto-approve

terraform destroy / terraform destroy -auto-approve

terraform state list

terraform refresh

terraform destroy --target=<any_state_list>

terraform import aws_instance.my_manual_instance <instance_id>

#it will import my manual instance now we can manage this instance using terraform

terraform state show aws_instance.my_manual_instance

terraform workspace list #by_default=default

terraform workspace new <new_workspace_name>

#now if i do- terraform state list nothing will appear here in new workspace

terraform select workspace default 

#now if i do- terraform state list everything will appear here 

