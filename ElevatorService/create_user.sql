# Create user
CREATE USER 'elevator_dev'@'%' IDENTIFIED BY '';
CREATE USER 'elevator'@'%' IDENTIFIED BY 'YOUR_PASSWD_HERE';

# Grant privileges
GRANT ALL PRIVILEGES ON elevator_development.* TO 'elevator_dev'@'%';
GRANT ALL PRIVILEGES ON elevator_test.*        TO 'elevator_dev'@'%';
GRANT ALL PRIVILEGES ON elevator_production.*  TO 'elevator'@'%';
FLUSH PRIVILEGES;
