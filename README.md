# SubEnum-Wrapper 🔍

A powerful bash wrapper script designed to streamline the reconnaissance phase of bug bounty hunting and penetration testing. **AutoSubEnum** runs multiple subdomain enumeration tools concurrently, combines their results, cleans the formatting, and outputs a single, deduplicated list of valid subdomains.

## Features
* **Multi-Tool Integration:** Leverages `subfinder`, `assetfinder`, `sublist3r`, and `findomain`.
* **Smart Filtering:** Uses regex to ensure only valid subdomains of the target are kept.
* **Clean Output:** Automatically removes carriage returns, converts to lowercase, and strips duplicate entries.
* **System Friendly:** Uses secure temporary directories for processing and automatically cleans up after execution.

## Prerequisites
For this script to work, you must have the following tools installed and accessible in your system's `$PATH`:
* [Subfinder](https://github.com/projectdiscovery/subfinder)
* [Assetfinder](https://github.com/tomnomnom/assetfinder)
* [Sublist3r](https://github.com/aboul3la/Sublist3r) (Python 3 version)
* [Findomain](https://github.com/Findomain/Findomain)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shirkirtia-art/SubEnum-Wrapper.git
   cd SubEnum-Wrapper

2. Make the script executable:
    ```bash
    chmod +x subenum.sh

3. Usage
Run the script by passing the target domain as an argument:

   ```bash
   ./subenum.sh example.com

Example Output

   ```bash
      [+] Starting subdomain enumeration for hackerone.com
      [+] Output will be saved to subdomains.txt (duplicates removed)
      [+] Running subfinder...
      [+] Running assetfinder...
      [+] Running sublist3r...
      [+] Running findomain...
      [+] Combining results and removing duplicates...
      [+] Done! Found 29 unique subdomains.
      [+] Saved to: subdomains.txt

      First 15 subdomains:
      a.hackerone.com
      api.hackerone.com
      app.hackerone.com
      ...
