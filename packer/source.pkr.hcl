locals {
  image_id = var.release != "" ? var.release : formatdate("YYYYMMDDhhmmss", timestamp())
}

source "googlecompute" "imagem-rke" {
  project_id          = var.config_gcp.id_projeto
  source_image_family = var.config_gcp.familia_imagem
  ssh_username        = var.config_gcp.usuario_ssh
  zone                = var.config_gcp.zona

  image_name = replace("rke-${local.image_id}", ".", "-")

}

source "googlecompute" "imagem-nomad" {
  project_id          = var.config_gcp.id_projeto
  source_image_family = var.config_gcp.familia_imagem
  ssh_username        = var.config_gcp.usuario_ssh
  zone                = var.config_gcp.zona

  image_name = replace("nomad-${local.image_id}", ".", "-")

}
