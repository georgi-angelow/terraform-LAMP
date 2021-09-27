# LAMP Stack In AWS Using Terraform

```html
.
├── ec2.tf
├── index.php
├── main.tf
├── outputs.tf
├── rds.tf
├── README.md
├── routetables.tf
├── sg.tf
├── subnets.tf
├── variables.tf
└── vpc.tf
```


> A LAMP stack is simply a web application created on Linux server using Apache, PHP and MySQL (L=Linux, A=Apache, M=MySQL, P=PHP). In this demo, we will use an EC2 Linux instance to create our frontend web application and will use AWS MySQL RDS as backend database.


Steps:
1. Changes variables in variables.tf
2. Change public key in ec2.tf specify the path var id_rda in ec2.tf (line 43)
3. You need to have profile setuped in ~/.aws/credentials
4. Copy web_server_address from the output and connect to the instance
5. Edit /var/www/html/index.php in EC2 instance (web server) (change 'Your Database Server address here' with the output for db_server_address)
6. Connect to the RDS (mysql -h ENDPOINT -u myuser -pmypassword )
7. Execcute - 
    USE mydb;
    CREATE TABLE counter (visits int(10) NOT NULL);
    INSERT INTO counter(visits) values(1);
8. Open web_server_address in the browser , hit refresh and check