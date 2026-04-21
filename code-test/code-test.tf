provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_security_group" "test_sg" {
  name        = "test-sg"
  description = "test"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 위험 설정 test
  }
}