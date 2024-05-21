variable "instance_names" {
  type        = map
#   default     = {
#      db-dev = "t3.small"
#      backend-dev = "t3.micro"
#      frontend-dev = "t3.micro"
#    }
 }

 variable "environment" {
   default = "dev"
 }

variable "common_tags" {
    type = map
    default = {
      Project = "Expense"
      Terraform = "true"
    }
}

variable "domain_name" {
    default = "malluru.online"
}

variable "zone_id" {
    default = "Z05281582RQ01LB1JNU7W"

}





