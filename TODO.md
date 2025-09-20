# TODO

## Convert to Serverpod

- Length must be between 8 and 128 characters.

### Password Hashing

- Use a strong password hashing algorithm like Argon2, bcrypt, or scrypt instead of SHA-256 for hashing passwords. (possible with cryptography package)
- Increase the salt length to at least 16 bytes for better security.
- Make the hashing function asynchronous to avoid blocking the main thread.

### User

- Improve error handling to provide more specific feedback on login failures (e.g., user not found, incorrect password).
