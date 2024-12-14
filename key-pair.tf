# Step 1: Generate a private key using the tls_private_key resource
resource "tls_private_key" "pro_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Step 2: Save the private key to a local file
resource "local_file" "private_key" {
  filename = "pro-key.pem"  # This is the private key file you will download
  content  = tls_private_key.pro_key.private_key_pem
}

# Step 3: Create an EC2 key pair using the generated public key
resource "aws_key_pair" "pro_key" {
  key_name   = "pro-key"
  public_key = tls_private_key.pro_key.public_key_openssh
}

output "private_key_path" {
  value = local_file.private_key.filename
}