variable "prefix" {
    description = "The prefix which should be used for all resources in this example "
}

variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    default = "East US" 
}


variable "password" {
    description = "The Azure  resource password"
    default = "Admin123*#123" 
    sensitive = true
}

variable "username" {
    description = "The Azure username"
    default     = "admin123" 
    sensitive   = true
}

variable "num_vms" {
    type        =  number
    description = "The number of Vitual machines"
}


variable "num_managed_disks" {
    type        = number
    description = "The number of Managed disks"
}