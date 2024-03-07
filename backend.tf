terraform {
  backend "s3" {
    bucket         = "terraform-demo-mani"
    key            = "865653379834/vpc/vpc.tfstate"
    region         = "us-east-1"
    encrypt        = true
    #dynamodb_table = "terraform-demo-mani"

  }
}
