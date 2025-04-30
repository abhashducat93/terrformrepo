provider "aws" {
    region = "us-east-1" # Replace with your desired AWS region
}

# Generate a new key pair
resource "tls_private_key" "my_key" {
    algorithm = "RSA"
    rsa_bits  = 2048
}

resource "aws_key_pair" "my_key" {
    key_name   = "my-key-pair"
    public_key = tls_private_key.my_key.public_key_openssh
}

# Launch an EC2 instance
resource "aws_instance" "my_ec2" {
    ami           = "ami-0c02fb55956c7d316" # Replace with a valid AMI ID for your region
    instance_type = "t2.micro"

    key_name = aws_key_pair.my_key.key_name

    tags = {
        Name = "MyEC2Instance"
    }
}

# Output the private key (save this securely)
output "private_key" {
    value     = tls_private_key.my_key.private_key_pem
    sensitive = true
}

# Output the public IP of the EC2 instance
output "ec2_public_ip" {
    value = aws_instance.my_ec2.public_ip
}

# Output the instance ID of the EC2 instance
output "ec2_instance_id" {
    value = aws_instance.my_ec2.id
}
