variable "region"{
    default = "ap-south-1"
    type = string
}

variable "ami"{
    default = {
        master = "ami-0e35ddab05955cf57"
        worker = "ami-0e35ddab05955cf57"
    }
    type = map(string)
}

variable "instance_type"{
    default = {
        master = "t2.medium"
        worker = "t2.micro"
    }
    type = map(string)
}

#worker_node_instance_number

variable "worker_node_count"{
    default = 2
    type = number
}