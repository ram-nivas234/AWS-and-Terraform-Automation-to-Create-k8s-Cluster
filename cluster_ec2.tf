resource "aws_instance" "master_node" {
  tags = {
    Name = "Master_Node"
  }

    key_name        = aws_key_pair.aws_key.key_name
    security_groups = ["k8s_master_sg"]
    ami             = var.ami["master"]
    instance_type   = var.instance_type["master"]
    
    root_block_device {

        volume_size = 10
        volume_type = "gp3"
    }
  
  # user_data = file("master.sh k8s-master") we could also use this but we will not 
  # because in order to local execute we have to use provisioner so we are not including this 

  connection {
    type        = "ssh"
    user        = "ubuntu" 
    private_key = file("aws_key")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./master.sh"
    destination = "/home/ubuntu/master.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/master.sh",
      "sudo sh /home/ubuntu/master.sh k8s-master"
    ]
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, playbook.yml"

    # you can also try this with scp command ---
    # resource "null_resource" "copy_from_remote" {
    # provisioner "local-exec" {
    # command = "scp -i aws_key.pem ubuntu@${aws_instance.example.public_ip}:~/join-command.sh ."
    #}
    # But it's good to go with ansible !
  }
}

resource "aws_instance" "worker_node" {
  count = var.worker_node_count
  tags = {
    Name = "worker_Node${count.index}"
  }
   
    key_name        = aws_key_pair.aws_key.key_name
    security_groups = ["k8s_worker_sg"]
    ami             = var.ami["worker"]
    instance_type   = var.instance_type["worker"]
    depends_on      = [aws_instance.master_node]
    
    root_block_device {

        volume_size = 10
        volume_type = "gp3"
    }

    connection {
    type        = "ssh"
    user        = "ubuntu"  
    private_key = file("aws_key")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./worker.sh"
    destination = "/home/ubuntu/worker.sh"
  }
  provisioner "file" {
    source      = "./join-command.sh"
    destination = "/home/ubuntu/join-command.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/worker.sh",
      "sudo sh /home/ubuntu/worker.sh k8s-worker-${count.index}",
      "sudo sh /home/ubuntu/join-command.sh"
    ]
  }

}
