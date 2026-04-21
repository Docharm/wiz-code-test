provider "aws" {
  region = "ap-northeast-2"
}

# 1. S3 Public Access 완전 개방
resource "aws_s3_bucket" "bad_bucket" {
  bucket = "wiz-demo-bad-bucket-123456"

  acl = "public-read"  # ❌ public 접근

  force_destroy = true
}

# 2. Public Access Block 미설정 (의도적으로 누락)
# aws_s3_bucket_public_access_block 없음 → ❌

# 3. Security Group 전체 오픈
resource "aws_security_group" "bad_sg" {
  name        = "wiz-bad-sg"
  description = "insecure sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ SSH 전체 오픈
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ RDP 전체 오픈
  }
}

# 4. 암호화 없는 EBS
resource "aws_ebs_volume" "bad_ebs" {
  availability_zone = "ap-northeast-2a"
  size              = 10

  encrypted = false  # ❌ 암호화 안함
}

# 5. IAM Wildcard 권한
resource "aws_iam_policy" "bad_policy" {
  name = "wiz-bad-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"  # ❌ full 권한
      }
    ]
  })
}