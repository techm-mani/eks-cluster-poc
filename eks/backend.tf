
terraform {
  backend "s3" {
    bucket         = "terraform-demo-mani"
    key            = "865653379834/subnet/subnet.tfstate"
    region         = "us-east-1"
  }
}
