#!/data/data/com.termux/files/usr/bin/bash

FULL TERMUX SETUP SCRIPT

Includes: Banner, storage permission, repo change, x11 & root repo, pkg update,

QEMU install, Ubuntu proot install, Windows ISO folder, VNC install, launchers.

PURPLE="\e[95m" YELLOW="\e[93m" ORANGE="\e[38;5;208m" RESET="\e[0m"

1# Install Termux Change Repo

termux-change-repo

--- Banner ---

echo -e "${PURPLE}" cat <<'BANNER'


---

/ __ \ / __ |  /  | \ | | | |  | | |  | | \  / |  | | | |  | | |  | | |/| | . ` | | || | || | |  | | |\  | _/ _/||  ||_| _| BANNER echo -e "${RESET}"

echo -e "${YELLOW}Made by assam gaming yt${RESET}" echo -e "${ORANGE}powered by Chatgpand${RESET}" echo

Storage Permission

echo "Requesting storage permission..." termux-setup-storage

Update & Upgrade

echo "Updating Termux..." pkg update -y && pkg upgrade -y

Install Repos

echo "Installing x11-repo & root-repo..." pkg install -y x11-repo root-repo

---------------------------

TERMUX CHANGE REPO (Official Menu)

---------------------------

echo -e "${YELLOW}Repositories updated.${RESET}"

Install core packages

echo "Installing required packages..." pkg install -y wget git proot-distro proot pulseaudio tigervnc

Attempt QEMU install (depends on repo)

pkg install -y qemu-system-x86_64 qemu-utils || pkg install -y qemu || echo "QEMU optional packages missing in your repo."

Create Windows ISO Folder

ISO_DIR="/storage/emulated/0/windows_iso_folder" echo "Creating Windows ISO folder at: $ISO_DIR" mkdir -p "$ISO_DIR" ls -lah "$ISO_DIR"

Install Ubuntu

if proot-distro list | grep -qi "ubuntu"; then echo "Ubuntu already installed." else echo "Installing Ubuntu..." proot-distro install ubuntu fi

Ubuntu Launcher

LAUNCHER="$HOME/start-ubuntu.sh" cat > "$LAUNCHER" <<'SH' #!/data/data/com.termux/files/usr/bin/bash echo "Starting Ubuntu..." proot-distro login ubuntu --shared-tmp --env HOME=/root SH chmod +x "$LAUNCHER"

echo "Ubuntu launcher created: $LAUNCHER"

Add Alias

echo "alias ubuntu='$LAUNCHER'" >> $HOME/.bashrc

Windows ISO Launcher Script

ISO_LAUNCH="$HOME/run-windows-iso.sh" cat > "$ISO_LAUNCH" <<'SCRIPT' #!/data/data/com.termux/files/usr/bin/bash ISO_DIR="/storage/emulated/0/windows_iso_folder" echo "Available ISOs:" ls -1 "$ISO_DIR" | nl -ba

echo echo -n "Enter ISO filename: " read iso

ISO_PATH="$ISO_DIR/$iso"

if [ ! -f "$ISO_PATH" ]; then echo "ISO not found!" exit 1 fi

echo "Launching QEMU..." qemu-system-x86_64 -m 2048 -smp 2 -cdrom "$ISO_PATH" -boot d -vga std -net nic -net user -usb -device usb-tablet -display sdl SCRIPT chmod +x "$ISO_LAUNCH"

echo "Windows ISO launcher created: $ISO_LAUNCH"

Instructions

echo "Setup Complete!" echo "Run 'ubuntu' to start Ubuntu." echo "Run 'bash $ISO_LAUNCH' to start QEMU Windows installation."