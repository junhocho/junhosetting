#!/bin/bash
# Install autojump for better directory navigation

echo "Installing autojump..."

# Clone autojump repository
git clone git://github.com/wting/autojump.git ~/autojump-temp
cd ~/autojump-temp

# Run the installation
python3 install.py --user

# Clean up
cd ~
rm -rf ~/autojump-temp

# Add autojump to zshrc if not already present
if ! grep -q "autojump.sh" ~/.zshrc; then
    echo '' >> ~/.zshrc
    echo '# Autojump' >> ~/.zshrc
    echo '[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh' >> ~/.zshrc
fi

echo "Autojump installed successfully!"
echo "Please restart your shell or run 'source ~/.zshrc' to start using autojump"