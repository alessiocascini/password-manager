# Password Manager

## Overview

This project is a command-line password manager developed in Dart, designed to securely store and manage your passwords. It utilizes modern cryptographic techniques to ensure the safety of your sensitive information.

## Features

- **Master Password Authentication**: Secures access to your password vault using a master password.
- **Password Encryption**: Employs AES-CBC encryption with a secure initialization vector (IV) to protect stored passwords.
- **Password Generation**: Generates strong, random passwords for new accounts.
- **Data Storage**: Saves encrypted passwords in a JSON file for easy retrieval.
- **Command-Line Interface**: Provides a user-friendly CLI for adding and retrieving passwords.

## Requirements

- **Dart SDK**: Ensure that the Dart SDK is installed on your system. You can download it from the [official Dart website](https://dart.dev/get-dart).

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/cascini-alessio/password-manager.git
   ```

2. **Navigate to the Project Directory**:

   ```bash
   cd password_manager
   ```

3. **Install Dependencies**:

   ```bash
   dart pub get
   ```

## Usage

1. **Run the Application**:

   ```bash
   dart run
   ```

2. **Add a New Password**:

   - Select option `1` to add a new password.
   - Enter the name of the service.
   - Choose to generate a new password or enter an existing one.

3. **Retrieve an Existing Password**:

   - Select option `2` to retrieve a password.
   - Enter the name of the service.
   - If the service exists, the encrypted password will be displayed.

## License

This program is free software: you can redistribute it and/or modify it under the terms of the **GNU General Public License** as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the [GNU General Public License](http://www.gnu.org/licenses/) for more details.

A copy of the GNU General Public License is included in the `LICENSE` file of this repository.
