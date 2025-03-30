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

## Installation

### Running with Docker

The official Docker image for this project is available on Docker Hub. It is recommended to download and run it using the following commands:

```bash
docker pull alessiocascini/password-manager:1.1.0
docker run -it --name password-manager alessiocascini/password-manager:1.1.0
```

This will create and start a container named `password-manager`. Once the container is created, you can restart it anytime without losing data using:

```bash
docker start -i password-manager
```

When you are done and want to remove the container:

```bash
docker rm password-manager
```

If you prefer to build the Docker image manually, you can do so with:

```bash
docker build -t password-manager .
```

Then, run the container with:

```bash
docker run -it --name password-manager password-manager
```

### Running Locally

To run the application on your local machine without Docker:

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/alessiocascini/password-manager.git
   ```

2. **Navigate to the Project Directory**:

   ```bash
   cd password-manager
   ```

3. **Install Dependencies**:

   ```bash
   dart pub get
   ```

4. **Run the Application**:

   ```bash
   dart run
   ```

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
