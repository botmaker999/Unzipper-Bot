FROM archlinux:latest

# Update system and install required packages
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm python python-pip python-virtualenv zstd p7zip gcc

# Create working directory
RUN mkdir /app/
WORKDIR /app/

# Copy your application code into the container
COPY . /app/

# Create a virtual environment in /app/venv
RUN python -m venv /app/venv

# Upgrade pip and setuptools inside the virtual environment
RUN /app/venv/bin/pip install --upgrade pip setuptools

# Install Python dependencies from requirements.txt within the virtual environment
RUN /app/venv/bin/pip install -r requirements.txt

# Use the virtual environment's python to run your application
CMD ["/app/venv/bin/python", "start.sh"]
