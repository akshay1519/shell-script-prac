# Shell Script Collection

A comprehensive collection of practical shell scripts for system administration, monitoring, file management, and automation tasks.

## 📋 Table of Contents

- [Overview](#overview)
- [Scripts](#scripts)
  - [System Monitoring](#system-monitoring)
  - [File Management](#file-management)
  - [User Management](#user-management)
  - [Network & Security](#network--security)
  - [Database & Backup](#database--backup)
  - [Utilities](#utilities)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

## 🚀 Overview

This repository contains 20+ shell scripts designed to automate common system administration tasks, monitor system resources, manage files, and provide useful utilities for daily operations.

## 📁 Scripts

### System Monitoring

| Script | Description | Features |
|--------|-------------|----------|
| [`1timer_announcer.sh`](1timer_announcer.sh) | Time announcer with customizable messages | Continuous time display with date/time formatting |
| [`2uptime_monitor.sh`](2uptime_monitor.sh) | System uptime monitoring | Real-time uptime display with 5-second intervals |
| [`8system_info.sh`](8system_info.sh) | System information display | OS, kernel, hostname, and user information |
| [`9disk_monitor.sh`](9disk_monitor.sh) | Disk space monitoring | Free space monitoring for root partition |
| [`14system_monitor.sh`](14system_monitor.sh) | Comprehensive system resource monitor | CPU, memory, and network usage with visual progress bars |
| [`15service_monitor.sh`](15service_monitor.sh) | Service health monitoring and auto-restart | Monitors critical services (nginx, apache2, ssh, mysql) |

### File Management

| Script | Description | Features |
|--------|-------------|----------|
| [`3filesize_check.sh`](3filesize_check.sh) | File size checker with validation | Interactive file size display with error handling |
| [`6file_change_monitor.sh`](6file_change_monitor.sh) | File modification monitoring | Real-time file change detection |
| [`10file_watcher.sh`](10file_watcher.sh) | Advanced file watcher | Timestamp-based file modification tracking |
| [`17enc_dec_file.sh`](17enc_dec_file.sh) | File encryption/decryption tool | AES-256-CBC encryption using OpenSSL |
| [`20compress_logs.sh`](20compress_logs.sh) | Log compression and cleanup | Automated log compression with email reporting |
| [`daily-logger.sh`](daily-logger.sh) | Daily log file creation | Date-based log directory and file management |
| [`dir-notes.sh`](dir-notes.sh) | Directory and notes management | Interactive directory creation with note-taking |

### User Management

| Script | Description | Features |
|--------|-------------|----------|
| [`13account_permission.sh`](13account_permission.sh) | Account and permission auditing | User login tracking and file permission analysis |
| [`16user_management.sh`](16user_management.sh) | Complete user management system | Add/modify/delete users, group management, logging |

### Network & Security

| Script | Description | Features |
|--------|-------------|----------|
| [`11network_health.sh`](11network_health.sh) | Network connectivity monitoring | Multi-host ping monitoring with email alerts |
| [`12log_analyzer.sh`](12log_analyzer.sh) | Web server log analysis | IP frequency analysis and error code detection |
| [`19traffic_monitor.sh`](19traffic_monitor.sh) | Network traffic monitoring | Traffic threshold monitoring with email alerts |

### Database & Backup

| Script | Description | Features |
|--------|-------------|----------|
| [`18db_bkp_res.sh`](18db_bkp_res.sh) | Database backup and restore | MySQL and PostgreSQL support with compression |

### Utilities

| Script | Description | Features |
|--------|-------------|----------|
| [`4countdown.sh`](4countdown.sh) | Interactive countdown timer | User input validation and visual countdown |
| [`5currency_conveter.sh`](5currency_conveter.sh) | Real-time currency converter | Live exchange rates via API integration |
| [`7fortune_teller.sh`](7fortune_teller.sh) | Random fortune generator | Interactive fortune telling with predefined messages |
| [`sampledata.sh`](sampledata.sh) | CSV data processing demo | Data filtering, sorting, and transformation examples |

## 🔧 Prerequisites

### Required Tools
- **Bash** (version 4.0+)
- **Basic Unix utilities**: `awk`, `sed`, `grep`, `curl`, `bc`
- **System tools**: `systemctl`, `stat`, `df`, `free`, `top`

### Optional Dependencies
- **OpenSSL** - Required for [`17enc_dec_file.sh`](17enc_dec_file.sh)
- **MySQL/PostgreSQL clients** - Required for [`18db_bkp_res.sh`](18db_bkp_res.sh)
- **Mail utilities** (`mailutils` or `mailx`) - Required for email notifications
- **Internet connection** - Required for [`5currency_conveter.sh`](5currency_conveter.sh)

## 🛠 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/akshay1519/shell-script-prac.git
   cd shell-script-prac
   ```

2. **Make scripts executable:**
   ```bash
   chmod +x *.sh
   ```

3. **Install optional dependencies (Ubuntu/Debian):**
   ```bash
   # For email notifications
   sudo apt-get install mailutils
   
   # For database operations
   sudo apt-get install mysql-client postgresql-client
   
   # For mathematical calculations
   sudo apt-get install bc
   ```

## 🚀 Usage

### Running Individual Scripts

Most scripts can be run directly:
```bash
./1timer_announcer.sh
./4countdown.sh
./7fortune_teller.sh
```

### Configuration

Several scripts require configuration before use:

#### Email Notifications
Edit the following variables in applicable scripts:
```bash
# In network_health.sh, traffic_monitor.sh, compress_logs.sh
Email="your-email@example.com"
ADMIN_EMAIL="your-email@example.com"
```

#### Network Interface
Update network interface names in monitoring scripts:
```bash
# In system_monitor.sh, traffic_monitor.sh
INTERFACE="eth0"  # Change to your interface (e.g., wlan0, enp0s3)
```

#### Service Monitoring
Customize services to monitor in [`15service_monitor.sh`](15service_monitor.sh):
```bash
services=("nginx" "apache2" "ssh" "mysql")  # Add/remove services as needed
```

### Examples

**File Size Check:**
```bash
./3filesize_check.sh
# Enter file path when prompted
```

**Currency Conversion:**
```bash
./5currency_conveter.sh
# Follow prompts for amount and currencies
```

**System Monitoring:**
```bash
./14system_monitor.sh
# Real-time system resource monitoring
```

**User Management (requires root):**
```bash
sudo ./16user_management.sh
# Interactive menu for user operations
```

## 📊 Features

- **Interactive User Interfaces** - Most scripts provide user-friendly prompts
- **Error Handling** - Comprehensive input validation and error checking
- **Logging** - Built-in logging for monitoring and management scripts
- **Email Notifications** - Automated alerts for critical events
- **Cross-Platform Compatibility** - Works on most Unix-like systems
- **Configurable Parameters** - Easy customization for different environments

## 🔒 Security Considerations

- Scripts requiring root privileges are clearly marked
- Sensitive operations include confirmation prompts
- Password inputs are handled securely (hidden input)
- File permissions are validated before operations
- Network operations include error handling for security

**Note:** Always test scripts in a safe environment before using in production. Some scripts require specific system configurations or permissions to function properly.