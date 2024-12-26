#Base image
FROM python:3.10-slim

# Set the working directory to /src (not inside analytics)
WORKDIR /src

# Copy the requirements.txt file for caching
COPY src/analytics/requirements.txt /src/requirements.txt

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the whole src directory to /src
COPY src /src

# Expose ports
EXPOSE 80 443 5000

# Command to run app
CMD [ "python", "/src/analytics/app.py" ]