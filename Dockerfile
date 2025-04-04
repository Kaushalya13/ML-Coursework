# Use the official Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libatlas-base-dev \
    liblapack-dev \
    gfortran \
    python3-distutils \
    python3-setuptools \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install essential build tools
RUN pip install --upgrade pip setuptools wheel Cython

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port your Flask app runs on
EXPOSE 5000

# Run the app
CMD ["python", "main.py"]
