# Use the official Dart SDK image (version 3.7.1) with development tools included
FROM dart:3.7.1-sdk

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the pubspec files (e.g., pubspec.yaml and pubspec.lock) into the container
# This step helps leverage Docker's cache for dependency installation
COPY pubspec.* ./

# Run "dart pub get" to install the dependencies defined in pubspec.yaml
RUN dart pub get

# Copy the rest of the application code into the container
COPY . .

# Set the default command to run when the container starts
CMD [ "dart", "run" ]
