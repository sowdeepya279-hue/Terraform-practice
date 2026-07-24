provider "aws"  {
    profile = "dev"
    alias = "dev-account"
    region = "us-east-1"
  
}
provider "aws" {
    profile = "prod"
    alias = "prod-account"
    region = "us-west-2"
  
}