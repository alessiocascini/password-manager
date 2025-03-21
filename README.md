# Password Manager

## Overview

Experience a lightweight, command-line password manager built in Dart that puts security and simplicity at the forefront. This tool leverages cutting-edge cryptographic techniques to ensure your sensitive data stays protected while providing an intuitive interface for managing your passwords.

## Key Features

- **Master Password Protection**: Secure your entire vault with a single, robust master password.
- **Advanced Encryption**: Encrypts your passwords using AES-CBC with a secure initialization vector (IV), keeping your data safe.
- **Secure Password Generation**: Automatically generates strong, random passwords for all your accounts.
- **Effortless Data Management**: Stores your encrypted passwords in a JSON file for quick and easy retrieval.
- **Intuitive Command-Line Interface**: Navigate and manage your passwords with a user-friendly CLI.
- **Seamless Docker Integration**: Deploy the application in a containerized environment for consistent setups and streamlined operations.

## Prerequisites

Before running the project, ensure you have the following installed on your system:

- **Dart SDK (v3.7.1 or later)**  
  Download and install the Dart SDK from the [official website](https://dart.dev/get-dart).

- **Docker**  
  Required for containerized deployment, which simplifies running the application across different environments.

## Docker Hub

The official Docker image for this project is available on Docker Hub. You can pull and run it with the following commands:

```bash
docker pull alessiocascini/password-manager:1.1.0
docker run -it --rm alessiocascini/password-manager:1.1.0 bash
```

For more details, visit the [Docker Hub Repository](https://hub.docker.com/repository/docker/alessiocascini/password-manager).

## Installation

### Running Locally

To run the application on your local machine:

1. **Clone the Repository**:

   Begin by cloning the repository to your local system:

   ```bash
   git clone https://github.com/alessiocascini/password-manager.git
   ```

2. **Navigate to the Project Directory**:

   Move into the project's root directory:

   ```bash
   cd password-manager
   ```

3. **Install Dependencies**:

   Fetch and install the necessary dependencies:

   ```bash
   dart pub get
   ```

4. **Run the Application**:

   Launch the application:

   ```bash
   dart run
   ```

### Running with Docker

To run the application using Docker, follow these steps:

1. **Build the Docker Image**:

   Create the Docker image from the Dockerfile:

   ```bash
   docker build -t password-manager .
   ```

2. **Run the Docker Container**:

   Start the application within a Docker container:

   ```bash
   docker run -it --rm password-manager bash
   ```

Once inside the Docker container, follow the same steps as for local execution:

3. **Run the Application in Docker**:

   Inside the container, execute the application using:

   ```bash
   dart run
   ```

This allows you to run the Password Manager both locally and in a Docker container.

## Usage

Once the application is running, you can manage your passwords using the command-line interface.

1. **Add a New Password**:

   - Select option `1` to add a password.
   - Enter the name of the service.
   - Choose to generate a new password or provide an existing one.

2. **Retrieve an Existing Password**:
   - Select option `2` to retrieve a password.
   - Enter the name of the service.
   - If found, the encrypted password will be displayed.

## License

This file is part of Password Manager.

Password Manager is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Password Manager is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with Password Manager. If not, see <https://www.gnu.org/licenses/>.
