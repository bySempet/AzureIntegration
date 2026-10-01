variable "location" {
  type    = string
  default = "North Europe"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "allowed_ssh_cidr" {
  description = "Tu IP pública con /32."
  type        = string
}

variable "vm_size" {
  description = "Comprueba antes su disponibilidad en la región con az vm list-skus"
  type        = string
  default     = "Standard_F2s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "shutdown_time" {
  description = "Hora de apagado"
  type        = string
  default     = "2300"
}
