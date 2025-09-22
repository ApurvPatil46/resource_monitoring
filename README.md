# Serverless AWS Infrastructure Monitoring 🚀

A **serverless, cost-effective solution** to monitor AWS infrastructure — starting with **EC2 instances** — and take automated actions to save costs.  
This repository contains a **Python script** and **Terraform modules** that together provide monitoring, alerting, and automated remediation.

## 📌 Overview
Many teams rely on paid SaaS monitoring tools like Datadog or New Relic. While powerful, they can be expensive for smaller projects.  
This solution leverages **AWS Lambda, CloudWatch Events, and SNS** to build a lightweight, scalable, and cost-efficient monitoring system — **without running any servers.**

### ✨ Features
- ✅ Monitors EC2 instances running beyond a configurable runtime (default: 24h)
- ✅ Automatically **stops** or **terminates** instances
- ✅ Sends alerts via **Amazon SNS** (email/SMS/integrations)
- ✅ Fully **serverless** & pay-per-use
- ✅ Easily **extendable** to EBS, Snapshots, RDS, or other resources
- ✅ **Infrastructure-as-Code** with Terraform

---

## 🛠 Architecture
![Architecture Diagram](/Users/apurvpatil/Downloads/cost-optimization.png)
**Components:**
1. **Python Script** – Identifies long-running EC2 instances and stops/terminates them.
2. **AWS Lambda** – Hosts and runs the script serverlessly.
3. **CloudWatch Events** – Triggers the Lambda function on a schedule.
4. **Amazon SNS** – Sends alerts with details of stopped/terminated instances.

---

## 📂 Repository Structure
```
.
├── scripts/
│ └── resource_monitor_script.py # Main Python logic
├── terraform/
│ ├── lambda/ # Lambda module
│ ├── cloudwatch_event/ # CloudWatch Event module
│ └── sns/ # SNS module
└── README.md
```

🔧 Extending the Solution
1. You can enhance this solution to:
2. Clean up unused EBS volumes or snapshots
3. Stop idle RDS instances
4. Monitor cost anomalies
5. Integrate notifications with Slack or PagerDuty

## Diagram
