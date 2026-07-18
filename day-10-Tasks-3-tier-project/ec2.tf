resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = aws_subnet.private[0].id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<EOF
#!/bin/bash

dnf update -y
dnf install -y httpd

systemctl start httpd
systemctl enable httpd

cat <<'HTML' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform AWS Infrastructure</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #eef2ff, #f8fafc);
            color: #1e293b;
        }

        .header {
            background: linear-gradient(135deg, #1e3a8a, #2563eb);
            color: white;
            padding: 45px 20px;
            text-align: center;
        }

        .header h1 {
            font-size: 42px;
            margin-bottom: 12px;
        }

        .header p {
            font-size: 18px;
            opacity: 0.9;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .success {
            background: white;
            border-radius: 16px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            margin-bottom: 35px;
        }

        .success h2 {
            color: #15803d;
            margin-bottom: 10px;
        }

        .success p {
            color: #64748b;
            font-size: 16px;
        }

        .architecture {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 35px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .architecture h2 {
            margin-bottom: 25px;
            color: #1e3a8a;
        }

        .flow {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .flow-box {
            background: #eff6ff;
            border: 2px solid #2563eb;
            border-radius: 12px;
            padding: 16px 22px;
            min-width: 150px;
            font-weight: bold;
        }

        .arrow {
            font-size: 28px;
            color: #2563eb;
        }

        .services {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 22px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            border-top: 5px solid #2563eb;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .card .icon {
            font-size: 38px;
            margin-bottom: 12px;
        }

        .card h3 {
            margin-bottom: 10px;
            color: #1e3a8a;
        }

        .card p {
            color: #64748b;
            line-height: 1.6;
        }

        .status {
            display: inline-block;
            margin-top: 15px;
            padding: 6px 14px;
            border-radius: 20px;
            background: #dcfce7;
            color: #166534;
            font-size: 13px;
            font-weight: bold;
        }

        .footer {
            margin-top: 50px;
            background: #0f172a;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .footer p {
            margin: 6px;
            opacity: 0.85;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 30px;
            }

            .arrow {
                transform: rotate(90deg);
            }

            .flow {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<section class="header">
    <h1>🚀 Terraform AWS Infrastructure</h1>
    <p>Complete Three-Tier Cloud Architecture Deployed Successfully</p>
</section>

<main class="container">

    <section class="success">
        <h2>✅ Infrastructure Deployment Successful!</h2>
        <p>
            This application is running on an AWS infrastructure
            provisioned completely using Terraform.
        </p>
    </section>

    <section class="architecture">

        <h2>🏗️ Application Architecture</h2>

        <div class="flow">

            <div class="flow-box">
                🌍 Internet
            </div>

            <div class="arrow">➡️</div>

            <div class="flow-box">
                ⚖️ Application<br>
                Load Balancer
            </div>

            <div class="arrow">➡️</div>

            <div class="flow-box">
                🖥️ Private<br>
                EC2 Instance
            </div>

            <div class="arrow">➡️</div>

            <div class="flow-box">
                🗄️ RDS<br>
                Database
            </div>

        </div>

    </section>

    <section class="services">

        <div class="card">
            <div class="icon">🌐</div>
            <h3>VPC</h3>
            <p>
                Isolated virtual network designed to securely host
                the complete AWS infrastructure.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">📡</div>
            <h3>Public Subnets</h3>
            <p>
                Host the Application Load Balancer and provide
                controlled internet connectivity.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">🔒</div>
            <h3>Private Subnets</h3>
            <p>
                Securely host application servers without exposing
                them directly to the public internet.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">🌉</div>
            <h3>Internet Gateway</h3>
            <p>
                Provides internet connectivity for resources
                deployed in public subnets.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">🚪</div>
            <h3>NAT Gateway</h3>
            <p>
                Allows private EC2 instances to securely access
                the internet for outbound traffic.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">🛡️</div>
            <h3>Security Groups</h3>
            <p>
                Controls traffic between the ALB, EC2 application
                server, and RDS database.
            </p>
            <span class="status">✓ Deployed</span>
        </div>

        <div class="card">
            <div class="icon">🖥️</div>
            <h3>EC2 Instance</h3>
            <p>
                Private application server running Apache Web Server
                behind the Application Load Balancer.
            </p>
            <span class="status">✓ Running</span>
        </div>

        <div class="card">
            <div class="icon">⚖️</div>
            <h3>Application Load Balancer</h3>
            <p>
                Distributes incoming HTTP traffic to the private
                application server.
            </p>
            <span class="status">✓ Healthy</span>
        </div>

        <div class="card">
            <div class="icon">🔑</div>
            <h3>IAM Role</h3>
            <p>
                Provides secure permissions to the EC2 instance
                without storing AWS access keys.
            </p>
            <span class="status">✓ Attached</span>
        </div>

        <div class="card">
            <div class="icon">🗄️</div>
            <h3>RDS MySQL</h3>
            <p>
                Managed relational database running securely inside
                private database subnets.
            </p>
            <span class="status">✓ Available</span>
        </div>

    </section>

</main>

<footer class="footer">

    <p>🚀 Infrastructure as Code with Terraform</p>

    <p>
        AWS VPC • ALB • EC2 • NAT Gateway • IAM • RDS
    </p>

    <p>
        Apache Web Server is Running Successfully!
    </p>

</footer>

</body>
</html>
HTML
EOF
}