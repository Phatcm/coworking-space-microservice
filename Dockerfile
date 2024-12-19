# Use a lightweight Python image
FROM python:3.11-slim

# Set a maintainer label
LABEL maintainer="phatcm"

# Expose necessary ports
EXPOSE 80 443

# Set the working directory
WORKDIR /src

# Set the Python path to include your source folder
ENV PYTHONPATH "${PYTHONPATH}:/src"

# Install Python dependencies
COPY src/analytics/requirements.txt ./analytics/
RUN pip install --no-cache-dir -r ./analytics/requirements.txt

# Copy the entire project
COPY . .

# Set the entry point to run your application
CMD ["python", "src/analytics/app.py"]
