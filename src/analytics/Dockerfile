#Base image
FROM python:3.10-slim

#Set workdir
WORKDIR /src

#Copy the requirements.txt file for caching
COPY src/analytics/requirements.txt /src/requirements.txt

#Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

#Copy the code to app folder
COPY src/analytics /src

#Expose port
EXPOSE 80 443 5000

#Command to run app
CMD [ "python", "app.py" ]