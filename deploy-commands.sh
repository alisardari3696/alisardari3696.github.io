# Initialize git (if not already)
git init
git add .
git commit -m "Initial site"

# Option A — using gh (creates repo and pushes)
# install and authenticate gh if needed: gh auth login
gh repo create USERNAME/USERNAME.github.io --public --source=. --remote=origin --push

# Option B — manual remote (use HTTPS or SSH)
# HTTPS example:
git branch -M main
git remote add origin https://github.com/USERNAME/USERNAME.github.io.git
git push -u origin main

# After push, open site in browser
$BROWSER "https://USERNAME.github.io"
