
    

provider "aws" {
  allowed_account_ids     = [ "865653379834" ]
  region                  = "ap-south-1"
  default_tags {
    tags = {
  "class" = "mani-demo",
}
  } 
}
