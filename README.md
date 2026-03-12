# Serverless SRE Monitoring Lab (AWS)

## Project Overview

This project demonstrates a **Serverless SRE monitoring architecture on AWS**.  
It simulates a production event-processing pipeline where application logs are generated, processed, stored, and monitored for failures.

The system uses **Lambda, SQS, S3, CloudWatch, and SNS** to implement an **event-driven architecture with observability and alerting**.

---

## Architecture

Producer Lambda → SQS Queue → Consumer Lambda → S3 Storage  
                                    ↓  
                               CloudWatch Logs  
                                    ↓  
                               CloudWatch Alarm  
                                    ↓  
                                    SNS  

---

## AWS Services Used

| Service | Purpose |
|------|------|
| AWS Lambda | Serverless compute for log generation and processing |
| Amazon SQS | Message queue for decoupling services |
| Amazon S3 | Storage for processed log events |
| Amazon CloudWatch | Monitoring, logs, metrics, alarms |
| Amazon SNS | Email notifications for incidents |
| IAM | Secure role-based access for services |

---

## Workflow

1. Producer Lambda generates application events.
2. Events are pushed into an **SQS queue**.
3. Consumer Lambda is automatically triggered by SQS.
4. Consumer processes the message.
5. Successful events are stored in **Amazon S3**.
6. Errors generate **Lambda failures**.
7. **CloudWatch monitors metrics and logs**.
8. **CloudWatch alarms trigger SNS alerts**.

---

## Testing Scenarios

### Normal Flow
Producer sends a success event → Consumer processes message → Data stored in S3.

### Failure Simulation
Producer sends an error event → Consumer Lambda fails → CloudWatch detects error → Alarm triggers → SNS sends notifications.

---

## Observability

CloudWatch monitors key metrics:

- Lambda Invocations
- Lambda Errors
- Lambda Duration
- SQS Queue Depth
- SQS Messages in Flight

CloudWatch dashboards visualize system health.

---

## Incident Simulation

The consumer Lambda intentionally throws an exception when:
