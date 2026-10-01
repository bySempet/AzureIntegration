variable "name_prefix" {
  description = "Prefijo para nombrar los recursos de red"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "allowed_ssh_cidr" {
  description = "Tu IP pública en formato 203.0.113.10/32. Es el único origen permitido para SSH."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr debe ser un CIDR válido"
  }

  validation {
    condition     = var.allowed_ssh_cidr != "0.0.0.0/0" && var.allowed_ssh_cidr != "::/0"
    error_message = "No se permite abrir SSH a todo Internet (0.0.0.0/0). Usa tu IP pública con /32."
  }

  validation {
    condition     = try(tonumber(split("/", var.allowed_ssh_cidr)[1]) >= 24, false)
    error_message = "El rango es demasiado amplio: el prefijo debe ser /24 o más estrecho (lo normal es tu IP con /32)."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
