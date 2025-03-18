# # Use Ubuntu as the base image
# FROM ubuntu:latest

# # Update package lists
# RUN apt-get update

# # Install MySQL Server
# RUN apt-get install -y mysql-server

# # Modify MySQL configuration to allow external connections
# RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# # Expose MySQL port
# EXPOSE 3306

# # Start MySQL server when the container starts
# CMD ["mysqld_safe"]


FROM ubuntu:latest
WORKDIR /app
RUN apt install -y python3
RUN apt install -y python-pip && pip3 --version
CMD ["python"]

# Step 1: Use the latest Ubuntu image
FROM ubuntu:latest

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Update package list and install Python3 and pip
RUN apt update && apt install -y python3 python3-pip

# Step 4: Verify pip version (optional, but useful for debugging)
RUN pip3 --version

# Step 5: Set the default command to run Python3
CMD ["python3"]



FROM ubuntu:latest
WORKDIR /app
RUN apt update && apt install -y nginx 
RUN nginx -version
EXPOSE 80
CMD ["nginx","-g","daemon;"]



