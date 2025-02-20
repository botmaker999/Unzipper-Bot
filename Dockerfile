FROM archlinux:latest

# Update system and install required packages
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm python python-pip zstd p7zip gcc

# Create working directory
RUN mkdir /app/
WORKDIR /app/

# Copy application code into the container
COPY . /app/

# (Optional) Create a virtual environment if you wish to isolate Python packages
# RUN python -m venv /app/venv
# RUN /app/venv/bin/pip install --upgrade pip setuptools
# RUN /app/venv/bin/pip install -r requirements.txt

# Install Python dependencies globally (if not using a virtual environment)
RUN pip3 install --upgrade setuptools pip && \
    pip3 install -r requirements.txt

# Expose the Heroku port. Heroku provides the PORT env variable at runtime.
EXPOSE ${PORT:-5000}

# Start the application.
# Make sure your start.sh listens on the port specified by $PORT.
CMD ["/bin/bash", "start.sh"]
