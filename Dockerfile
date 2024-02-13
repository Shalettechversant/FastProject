# # Use an official Python runtime as a parent image
# FROM python:3.10-slim

# # Set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# # Set the working directory in the container
# WORKDIR /app

# # Install system dependencies
# # RUN apt-get update && apt-get install -y netcat

# # Install Python dependencies
# COPY requirements.txt /app/
# RUN pip install  -r requirements.txt

# # RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of your application code
# COPY . /app/

# # Copy the health check script
# COPY healthcheck.sh /app/healthcheck.sh

# # Run database migrations
# # RUN alembic upgrade head

# # Expose the port on which your FastAPI application runs
# EXPOSE 8000

# # Command to run the FastAPI application
# CMD ["uvicorn", "run:app", "--host", "0.0.0.0", "--port", "8000"]


# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
# RUN apt-get update && apt-get install -y netcat
RUN apt-get update && apt-get install -y postgresql-client

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install  -r requirements.txt

# Copy the rest of your application code
COPY . /app/

# Copy the health check script
COPY healthcheck.sh /app/healthcheck.sh

# Make the health check script executable
RUN chmod +x /app/healthcheck.sh

# Expose the port on which your FastAPI application runs
EXPOSE 8000

# Command to run the FastAPI application
CMD ["uvicorn", "run:app", "--host", "0.0.0.0", "--port", "8000"]

