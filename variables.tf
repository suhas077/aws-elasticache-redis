variable "AWS_ACCESS_KEY_ID" {
}

variable "AWS_SECRET_ACCESS_KEY" {
}


variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}

variable "cidr_blocks" {
  description = "The CIDR blocks to create the workstations in."
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "namespace" {
  description = "Default namespace"
  default ="elasticcache"
}

variable "cluster_id" {
  type=list (string)
  default = ["node-01","node-02","node-03" ]
  description = "Id to assign the new cluster"
}

variable "node_groups" {
  description = "Number of nodes groups to create in the cluster"
  default     = 3
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0ba8e031ca32ab37f"
  }
}

variable "PATH_TO_PRIVATE_KEY"{
    default="mykey"
}

variable "PATH_TO_PUBLIC_KEY"{
    default="mykey.pub"
}

