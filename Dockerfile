FROM archlinux:latest

# Update system and install required packages
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm python python-pip python-virtualenv zstd p7zip gcc

# Set working directory
WORKDIR /app/

# Copy application code into the container
COPY . /app/

# Create a virtual environment in /app/venv
RUN python -m venv /app/venv

# Upgrade pip and setuptools inside the virtual environment
RUN /app/venv/bin/pip install --upgrade pip setuptools

# Install Python dependencies from requirements.txt within the virtual environment
RUN /app/venv/bin/pip install -r requirements.txt

# Expose the port Heroku assigns (defaulting to 5000 if not set)
EXPOSE ${PORT:-5000}

# Set the startup command.
# If your start.sh is a shell script, you can use:
# CMD ["/bin/bash", "start.sh"]
# Otherwise, if it's a Python script, you might invoke it as shown below.
CMD ["/app/venv/bin/python", "start.sh"]
