# Use the official Python base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the working directory
# COPY requirements.txt .

# Install the Python dependencies
RUN python -m pip install flask docker pyyaml

# Copy the application code to the container
COPY . .

# Expose the Flask app port
EXPOSE 5000

# Set the environment variables
ENV FLASK_APP=index.py

# Start the Flask web app
CMD ["flask", "run", "--host=0.0.0.0"]
