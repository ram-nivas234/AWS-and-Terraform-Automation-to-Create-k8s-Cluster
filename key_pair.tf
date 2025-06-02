resource "aws_key_pair" "aws_key" {
  key_name   = "aws-key"
  public_key = file("aws_key.pub")
}