# 📊 Resource Monitoring with Terraform

Terraform modules to monitor AWS resources using **CloudWatch, Lambda, and SNS**.  
This solution provides **serverless, automated monitoring** with customizable alerts and dashboards.

---

## 🌟 Features
- 🔍 **Real-time Monitoring** – Capture metrics & logs for AWS services  
- ⚡ **Serverless Processing** – AWS Lambda handles monitoring logic  
- 📧 **Instant Alerts** – Notifications via Amazon SNS (Email/SMS/Slack)  
- 📈 **Dashboards** – Visualize metrics in CloudWatch  
- 🔧 **Modular** – Easily plug & play Terraform modules  

---

## 🏗️ Architecture
The monitoring solution is designed using AWS serverless components:

- 🛠️ **Terraform** – Infrastructure as Code  
- ☁️ **AWS CloudWatch** – Metrics, logs, alarms  
- 🌀 **AWS Lambda** – Custom alert handling  
- 📢 **Amazon SNS** – Notifications & escalation  
- 🔐 **IAM Roles & Policies** – Secure access management  

📌 _Refer to the diagram below for the architecture flow:_  
![Architecture Diagram](./Downloads/Serverless_Monitor.drawio.png)

---

## 📦 Modules
- `cloudwatch-metrics` 📊 – Collects AWS service metrics  
- `lambda-alerts` ⚡ – Executes logic for custom monitoring  
- `sns-notifications` 📢 – Sends alerts to subscribers  

---

## 🔔 Alerts & Notifications

- 📧 **Email notifications**
- 📱 **SMS alerts**
- 💬 **Slack / Teams integration (optional)**

---

## 🙌 Contributing
PRs are welcome! 🎉 Please open an issue before submitting major changes.
