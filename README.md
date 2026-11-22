# CyberShieldWeb

# CyberShield – Smart Cyber Threat Detection and URL Security Analyzer

## Project Description

CyberShield is a Java-based web application designed to analyze URLs and identify potentially suspicious or unsafe links. It provides user registration, login, URL scanning, scan history, and security reports.

The main objective of this project is to demonstrate basic URL security analysis and web application development using Java technologies.

## Technologies Used

- Java
- Java Servlets
- JSP (JavaServer Pages)
- JDBC
- Hibernate ORM
- JSTL and Expression Language (EL)
- HTML and CSS
- MySQL / MariaDB
- Apache Tomcat 8.5
- NetBeans IDE
- XAMPP

## Main Features

1. User Registration and Login
2. Secure Password Hashing
3. URL Security Scanning
4. Threat Classification
5. Scan History
6. Security Reports
7. Report Update and Delete
8. Session Management
9. Error Handling

## Project Structure

```text
CyberShieldWeb/
├── src/
│   ├── java/
│   │   └── com/cybershield/
│   │       ├── entity/
│   │       ├── model/
│   │       ├── servlet/
│   │       └── util/
│   └── hibernate.cfg.xml
│
├── web/
│   ├── WEB-INF/
│   ├── META-INF/
│   ├── dashboard.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── scan.jsp
│   ├── history.jsp
│   └── reports.jsp
│
├── screenshots/
├── database/
├── README.md
└── build.xml
```

## Screenshots

### Screenshot 1

![Screenshot 1](screenshots/Screenshot%202026-11-20%20191002.png)

### Screenshot 2

![Screenshot 2](screenshots/Screenshot%202026-11-20%20191039.png)

### Screenshot 3

![Screenshot 3](screenshots/Screenshot%202026-11-20%20191353.png)

### Screenshot 4

![Screenshot 4](screenshots/Screenshot%202026-11-20%20191945.png)

## Database Setup

1. Install XAMPP.
2. Start Apache and MySQL from the XAMPP Control Panel.
3. Open phpMyAdmin.
4. Create a database named `cybershield_db`.
5. Import the database schema SQL file.
6. Configure the database connection in `hibernate.cfg.xml`.
7. Ensure the required database tables are created.

## Database Schema

The database schema SQL file is available in the `database` folder.

[Download Database Schema SQL File](database/cybershield_db%20%281%29.sql)

## How to Run

1. Install JDK 8 or a compatible JDK.
2. Install Apache Tomcat 8.5.
3. Install NetBeans IDE.
4. Open the `CyberShieldWeb` project in NetBeans.
5. Check that the required project libraries are available.
6. Start MySQL from XAMPP.
7. Run the project using Apache Tomcat.
8. Open the application in your browser.

## Project Repository

GitHub Repository:

https://github.com/pavanrs19012006-hub/CyberShieldWeb

## Important Note

The URL scanner uses basic security heuristics for educational purposes. A result marked Safe does not guarantee that a URL is harmless. The project is intended for academic demonstration and learning.
