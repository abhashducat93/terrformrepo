provider "aws" {
    region = "us-west-1"
}

resource "aws_s3_bucket" "example" {
    bucket = "my-unique-bucket-name-1234885"
    acl    = "private"
    versioning {
        enabled = true
    }
    tags = {
        Name        = "MyS3Bucket"
        Environment = "Dev"
    }
}
