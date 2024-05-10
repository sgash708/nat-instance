locals {
  internet_cidr = "0.0.0.0/0"
  ssm = {
    ssm = {
      service_name = "com.amazonaws.ap-northeast-1.ssm"
      name         = "${var.application_name}-ssm"
    }
    ec2 = {
      service_name = "com.amazonaws.ap-northeast-1.ec2messages"
      name         = "${var.application_name}-ssm-ec2"
    }
    message = {
      service_name = "com.amazonaws.ap-northeast-1.ssmmessages"
      name         = "${var.application_name}-ssm-messages"
    }
  }
}
