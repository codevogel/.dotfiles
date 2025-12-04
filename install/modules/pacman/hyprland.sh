#deps: stow
sudo pacman -S --noconfirm --needed \
    hyprland
    kitty                    # Terminal emulator
    egl-wayland              # EGL support for Wayland
    mako                     # Notification daemon
    pipewire                 # Audio service
    wireplumber              # PipeWire session manager
    xdg-desktop-portal-hyprland  # Portal backend for Hyprland
    hyprpolkitagent          # Polkit agent (GUI auth dialogs)
    qt5-wayland              # Qt5 Wayland support
    qt6-wayland              # Qt6 Wayland support
	 wl-clipboard             # Copy/paste utils

stow -d $HOME/.dotfiles/ -t $HOME -S hyprland

### ---------------------------------------------
### Prompt user for NVIDIA setup
### ---------------------------------------------
read -rp "Do you want to configure NVIDIA modules and initramfs automatically? [y/N]: " ANSWER
ANSWER=${ANSWER,,}

if [[ "$ANSWER" == "y" ]]; then
    echo "Applying NVIDIA configuration..."
else
    echo "Skipping NVIDIA configuration."
    exit 0
fi

sudo pacman -S --noconfirm --needed linux-headers nvidia-open-dkms nvidia-utils

NVIDIA_CONF="/etc/modprobe.d/nvidia.conf"
NVIDIA_CONF_CONTENT="options nvidia_drm modeset=1"

# Create file if it doesn't exist
if [ ! -f "$NVIDIA_CONF" ]; then
    echo "$NVIDIA_CONF_CONTENT" | sudo tee "$NVIDIA_CONF" > /dev/null
else
    # Add line only if missing
    if ! grep -Fxq "$NVIDIA_CONF_CONTENT" "$NVIDIA_CONF"; then
        echo "$NVIDIA_CONF_CONTENT" | sudo tee -a "$NVIDIA_CONF" > /dev/null
    fi
fi

MKC="/etc/mkinitcpio.conf"
NEEDED_MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)

# Track whether we modified the file
CHANGED=0

# Extract current MODULES line (if any)
CURRENT_LINE=$(grep -E '^MODULES=\(' "$MKC")

if [ -z "$CURRENT_LINE" ]; then
    # No MODULES line exists → create one with required modules
    NEW_LINE="MODULES=(${NEEDED_MODULES[*]})"
    echo "Adding MODULES line: $NEW_LINE"
    echo "$NEW_LINE" | sudo tee -a "$MKC" > /dev/null
    CHANGED=1
else
    # Parse current modules into an array
    # Remove 'MODULES=(' and ending ')'
    CURRENT_MODULES=($(echo "$CURRENT_LINE" | sed -E 's/^MODULES=\(|\)//g'))

    # Build a set for easy checking
    UPDATED_MODULES=("${CURRENT_MODULES[@]}")

    for mod in "${NEEDED_MODULES[@]}"; do
        if ! printf '%s\n' "${CURRENT_MODULES[@]}" | grep -qx "$mod"; then
            UPDATED_MODULES+=("$mod")
            CHANGED=1
        fi
    done

    if [ "$CHANGED" -eq 1 ]; then
        NEW_LINE="MODULES=(${UPDATED_MODULES[*]})"

        # Replace the whole MODULES line safely
        sudo sed -i "/^MODULES=\(/c\\$NEW_LINE" "$MKC"

        echo "Updated MODULES line:"
        echo "  $NEW_LINE"
    fi
fi

# Regenerate initramfs only if changes were made
if [ "$CHANGED" -eq 1 ]; then
    echo "Changes detected — regenerating initramfs..."
    sudo mkinitcpio -P
else
    echo "No changes needed — initramfs not rebuilt."
fi

