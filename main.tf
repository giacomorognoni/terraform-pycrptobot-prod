module "pycryptobot1" {
  source = "./modules/pycryptobot"

  name          = var.name
  desired_count = var.desired_count

}
