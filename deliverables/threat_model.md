# Threat Model: Secure Containerized Microservices

## 1. Overview
This document outlines the threat modeling exercise performed on the initial insecure application, following STRIDE and MITRE ATT&CK methodologies.

---



Threat Model for the Application
STRIDE Analysis
The STRIDE methodology helps identify potential security threats in an application. Below is the STRIDE analysis for the mywebapp:
## 1. STRIDE Analysis

|| **Threat**                 | **Description**                                                 | **Mitigation**                                                        |
| -------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Spoofing**               | No authentication on endpoints — anyone can access the app      | Add API keys, authentication headers, or restrict access to localhost |
| **Tampering**              | Command injection via `/ping?ip=...`                            | Validate input, use subprocess with argument lists                    |
| **Repudiation**            | No logging or tracking of actions                               | Add server-side logging of requests                                   |
| **Information Disclosure** | Stack traces shown on errors; sensitive info in code            | Disable debug mode; remove hardcoded secrets                          |
| **Denial of Service**      | No input limits; complex expressions or pings could hang server | Use input validation, timeouts, memory/pid limits                     |
| **Elevation of Privilege** | `eval()` and command injection could allow shell access         | Replace `eval()` with `ast.literal_eval`; validate inputs             |




## 2. MITRE ATT&CK Mapping (Containers)

| **Technique ID** | **Technique Name**                | **Description**                                    | **Mitigation**                              |
| ---------------- | --------------------------------- | -------------------------------------------------- | ------------------------------------------- |
| T1059            | Command and Scripting Interpreter | Unvalidated inputs passed to shell commands        | Use parameterized subprocess calls          |
| T1609            | Container Escape                  | Unrestricted container could lead to host breakout | Run as non-root, use kernel namespace remap |
| T1611            | Escape to Host                    | If container compromised, attacker might escape    | Harden Docker daemon, restrict privileges   |
| T1203            | Exploitation for Client Execution | Usage of `eval()` leads to code execution          | Avoid dynamic execution functions           |



## 3. Controls Mapping





| **Vulnerability**         | **Control ID** | **Control Description**                  |
| ------------------------- | -------------- | ---------------------------------------- |
| Hardcoded passwords       | AC-6           | Least Privilege                          |
| Unvalidated user input    | SI-10          | Input Validation                         |
| No authentication         | IA-2           | Identification and Authentication        |
| Container running as root | AC-6, CM-7     | Least Privilege, Least Functionality     |
| Unrestricted eval() usage | SI-10, SC-18   | Input Validation, Execution Restrictions |






---

## 5. Risk Rating Summary

| Threat | Risk | Likelihood | Impact | Mitigation Priority |
|--------|------|------------|--------|----------------------|
| Command Injection | High | High | Critical | Immediate |
| Credential Exposure | Medium | High | Medium | High |
| Eval-based execution | High | Medium | High | Immediate |
| Root user in container | High | Medium | Critical | Immediate |

---

## 6. Conclusion

This threat model identifies the major flaws in the system and informs the remediation and architecture redesign. The final implementation significantly reduces the attack surface and enforces least privilege, defense in depth, and secure defaults.

