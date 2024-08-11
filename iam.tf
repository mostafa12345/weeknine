resource "aws_iam_role" "iam_role_ssm_full_access" {
  name = "iam_role_ssm_full_access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = "111"
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess" 

  ]
}

# Create an IAM role for SSM
resource "aws_iam_role" "ssm_role" {
  name = "ssm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow",
        Principal = {
          Service = "ssm.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role.name
}


resource "aws_iam_instance_profile" "iam_profile" {
  name = "iam_profile"
  role = aws_iam_role.ssm_role.name
}
