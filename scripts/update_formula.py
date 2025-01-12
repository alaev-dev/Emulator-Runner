#!/usr/bin/env python3
import hashlib
import os
import re
import sys
import urllib.request

def get_tarball_sha(version, repo):
    """Download the release tarball and calculate its SHA256 hash."""
    url = f"https://github.com/{repo}/archive/refs/tags/v{version}.tar.gz"
    try:
        response = urllib.request.urlopen(url)
        data = response.read()
        return hashlib.sha256(data).hexdigest()
    except Exception as e:
        print(f"Error downloading tarball: {e}")
        sys.exit(1)

def update_formula(version, sha, formula_path="Formula/erun.rb"):
    """Update the Homebrew formula with new version and SHA."""
    try:
        with open(formula_path, 'r') as f:
            content = f.read()

        # Update URL
        content = re.sub(
            r'url "https://github\.com/[^/]+/[^/]+/archive/refs/tags/v[^"]+"',
            f'url "https://github.com/alaev-dev/erun/archive/refs/tags/v{version}.tar.gz"',
            content
        )

        # Update SHA256
        content = re.sub(
            r'sha256 "[a-f0-9]+"',
            f'sha256 "{sha}"',
            content
        )

        with open(formula_path, 'w') as f:
            f.write(content)

        print(f"Successfully updated formula for version {version}")
        print(f"New SHA256: {sha}")

    except Exception as e:
        print(f"Error updating formula: {e}")
        sys.exit(1)

def main():
    if len(sys.argv) != 2:
        print("Usage: update_formula.py VERSION")
        sys.exit(1)

    version = sys.argv[1]
    repo = "alaev-dev/erun"
    
    print(f"Calculating SHA256 for version {version}...")
    sha = get_tarball_sha(version, repo)
    
    print("Updating formula...")
    update_formula(version, sha)

if __name__ == "__main__":
    main()