aws_region = "us-east-1"

app_name = "tomcat-mtls"

ecr_image = "257394453954.dkr.ecr.us-east-1.amazonaws.com/tomcat-mtls-app:latest"

keystore_secret_arn   = "arn:aws:secretsmanager:us-east-1:257394453954:secret:tomcat/keystore"
truststore_secret_arn = "arn:aws:secretsmanager:us-east-1:257394453954:secret:tomcat/truststore"

domain_name = "kapdan-devcloud.com"