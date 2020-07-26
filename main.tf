terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "thrucovid19"

    workspaces {
      name = "learn-terraform-circleci"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "portfolio" {
  tags = {
    Name = "Portfolio Website Bucket"
  }

  bucket = "${var.app}.${var.label}"
  acl    = "public-read"

  website {
    index_document = "${var.app}.html"
    error_document = "error.html"
  }
  force_destroy = true

}

output "Endpoint" {
  value = aws_s3_bucket.portfolio.website_endpoint
}
