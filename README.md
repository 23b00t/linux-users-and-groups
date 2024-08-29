# Project Overview

This project involves setting up a directory structure, creating user accounts, assigning users to groups, and configuring folder permissions.

## Tasks

1. **Create Directory Structure**
   Create folders with the following structure:
   ```plaintext
   firma/
   ├── boss
   │   └── bill
   ├── hr
   │   ├── jim
   │   └── john
   ├── it
   │   ├── alice
   │   └── bob
   └── sale
       ├── tim
       └── tom
   ```

2. **Create Groups and Users**
   Create the necessary groups and users.

3. **Add Users to Groups**
   Assign users to their respective groups.

4. **Adjust Folder Permissions**
   Set the appropriate permissions for the folders.

5. **Given Files**
   - `groups.txt`: Contains the names of groups, one per line.
   - `users.txt`: Contains usernames and their associated groups in the format `username:group1,group2`.

## Solution

### Scripts

1. **`create_users.sh`**
   This script requires one argument: a file with lines in the format `username:group1,group2`. It creates users and assigns them to the specified groups.

2. **`create_groups.sh`**
   This script requires one argument: a file with one group per line. It creates the specified groups.

3. **`create_project.sh`**
   This script orchestrates the entire setup:
   - It populates `/etc/skel` with default folders.
   - It handles user and group creation.
   - It recursively adjusts folder permissions.

## Usage

1. **Run `create_groups.sh`**
   ```bash
   ./create_groups.sh groups.txt
   ```

2. **Run `create_users.sh`**
   ```bash
   ./create_users.sh users.txt
   ```

3. **Run `create_project.sh`**
   ```bash
   ./create_project.sh
   ```

## Notes

- Ensure that `groups.txt` and `users.txt` are formatted correctly.
- Check the permissions and existence of the default folders in `/etc/skel`.

For further assistance or troubleshooting, refer to the script comments and documentation.
