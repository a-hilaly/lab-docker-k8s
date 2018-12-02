FROM python:3.7-alpine

# Define environ
ENV VERSION 1

# Add server script
ADD server.py .

# Add requirements file
ADD requirements.txt .

# Install requirements
RUN pip3 install -r requirements.txt

# Expose port 8080 for container
EXPOSE 8080

# Command to run server
ENTRYPOINT [ "python3", "server.py" ]
