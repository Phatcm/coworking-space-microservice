# Base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /src

# Copy requirements.txt for caching
COPY src/analytics/requirements.txt /src/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the whole src directory to /src
COPY src /src   

# Set PYTHONPATH to include the /src directory
ENV PYTHONPATH="/src"

# Expose ports
EXPOSE 80 443 5000

# Command to run app
CMD [ "python", "/src/analytics/app.py" ]
