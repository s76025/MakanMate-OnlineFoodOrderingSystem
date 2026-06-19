# MakanMate - Online Food Ordering System

Java Servlet + JSP + MySQL web-based application using MVC architecture.

## Modules

1. Customer Information Management
   - Register customer
   - View customer list/profile
   - Update customer/profile
   - Delete customer by admin

2. Menu Items Management
   - Add menu item
   - View menu items
   - Update menu item
   - Delete menu item

3. Order Transactions Management
   - Place order
   - View order history/details
   - Update order status by admin
   - Delete order by admin

## Technology

- Java Servlet Controller
- JSP View
- DAO + Model MVC structure
- MySQL database
- Maven WAR project
- Tomcat 9 recommended

## Setup

1. Create MySQL database by running:
   ```sql
   source sql/database.sql;
   ```
   Or copy and run the SQL in phpMyAdmin / MySQL Workbench.

2. Edit database settings in:
   `src/main/java/com/makanmate/util/DBConnection.java`

   Default:
   - database: `online_food_ordering`
   - user: `root`
   - password: `admin`

3. Open project in NetBeans as Maven project.

4. Clean and Build.

5. Run with Apache Tomcat 9.

## Demo Login

Admin:
- Email: admin@makanmate.com
- Password: admin123

Customer:
- Email: customer@makanmate.com
- Password: customer123

## GitHub Submission

Upload this folder to GitHub, then submit the GitHub URL in a Word document to ePembelajaran.
