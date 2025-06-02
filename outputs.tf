output "ec2_master_ip"{
        value = aws_instance.master_node.public_ip
}

output "ec2_workernode_ip"{
        value = aws_instance.worker_node[*].public_ip
}