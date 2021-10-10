locals {
  image_id = var.release != "" ? var.release : formatdate("YYYYMMDDhhmmss", timestamp())
}

source "googlecompute" "imagem-base-orquestradores" {
  project_id          = var.config_gcp.id_projeto
  source_image_family = var.config_gcp.familia_imagem
  ssh_username        = var.config_gcp.usuario_ssh
  zone                = var.config_gcp.zona

  image_name = replace("orquestradores-${local.image_id}", ".", "-")

}

