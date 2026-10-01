variable "name_prefix" {
  description = "Prefijo para nombrar los recursos de la VM"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  description = "Tamaño de la VM. Comprueba disponibilidad con az vm list-skus"
  type        = string
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  description = "Contenido de la clave pública SSH"
  type        = string
}

variable "os_disk_size_gb" {
  type    = number
  default = 30
}

variable "shutdown_time" {
  description = "Hora de apagado automático diario en formato HHmm"
  type        = string
  default     = "2300"

  validation {
    condition     = can(regex("^([01][0-9]|2[0-3])[0-5][0-9]$", var.shutdown_time))
    error_message = "shutdown_time debe tener formato HHmm, por ejemplo 2300."
  }
}

variable "shutdown_timezone" {
  description = "Zona horaria de Windows para el apagado"
  type        = string
  default     = "Romance Standard Time"
}

variable "tags" {
  type    = map(string)
  default = {}
}
