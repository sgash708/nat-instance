data "aws_iam_policy_document" "bastion" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
data "aws_iam_policy" "ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
