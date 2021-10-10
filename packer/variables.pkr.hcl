variable "config_gcp" {
  type = object({
    id_projeto     = string
    zona           = string
    familia_imagem = string
    usuario_ssh    = string
  })
  default = {
    id_projeto     = env("GCP_PROJECT")
    zona           = "us-central1-a"
    familia_imagem = "ubuntu-2004-lts"
    usuario_ssh    = "mentoria_iac"
  }
}

variable "release" {
  type        = string
  description = "Tag de release da pipeline de CI"
  default     = null
}
