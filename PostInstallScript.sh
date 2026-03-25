#!/bin/bash

# SCRIPT MADE BY STRIKER -> github.com/BrandowLucas

iteration="0.9.8"

# MODIFY YOUR PACKAGES HERE !!!
packages=(
flatpak dolphin-plugins p7zip unzip zenity qbittorrent htop ncdu dhclient corectrl firejail flatpak-kcm protontricks inotify-tools fast eog discord system-monitoring-center hardinfo debtap webapp-manager zerotier-one zerotier-gui-git distrobox podman q4wine-git yt-dlp obs-studio hunspell-en_us klassy brave exa lunar-client kio-admin gpu-screen-recorder-ui mission-center lshw qemu-desktop virt-manager protonplus libinput-tools evtest gemini-cli signal-desktop darkly-bin hmcl-beta-bin xorg-xeyes  # plasma-x11-session quickemu chatgpt-desktop-bin keepassxc notion-app-electron detect-it-easy-bin telegram-desktop obsidian kwalletmanager signal-desktop jackett orca lightly-qt session-desktop-bin swapspace kwin-effect-rounded-corners-git proton-vpn-gtk-app mongodb-compass haguichi vesktop piper
)

prog_packages=(
python-pip zed cmake gdb strace sourcegit git-credential-manager github-cli maven jdk21-openjdk jdk8-openjdk recaf #intellij-idea-community-edition #clion visual-studio-code-bin trash-cli github-desktop
glfw glew extra-cmake-modules
)

# set: export GCM_CREDENTIAL_STORE=secretservice
# for sourcegit be able to log in into your account

# git config --global user.email "email@gmail.com"
# git config --global user.name "BrandowLucas"

pentest_packages=(
wireshark-qt whois gnu-netcat nmap traceroute
tcpdump macchanger scapy masscan arp-scan
hping httptunnel httrack hashcat
mhash aircrack-ng socat binwalk
sleuthkit mitmproxy #maltego
)

gaming_dependencies=(
wine-staging winetricks lib32-vulkan-icd-loader vkbasalt lib32-vkbasalt
mangohud-git lib32-mangohud-git goverlay-git gamemode lib32-gamemode lutris latencyflex-bin #
heroic-games-launcher-bin ttf-arimo-nerd lib32-freetype2 freetype2
lib32-alsa-plugins lib32-pipewire gamescope lib32-sdl sdl sdl2 lib32-sdl2 #bottles
)

remove_packages=(
firefox plasma-systemmonitor gwenview
)

flatpak_apps=(
    #app/net.nokyan.Resources/x86_64/stable                             # Resources
    #net.davidotek.pupgui2                                               # ProtonUP-Qt
    app/it.mijorus.gearlever/x86_64/stable                              # GearLever
    #app/com.dec05eba.gpu_screen_recorder/x86_64/stable                 # GPU Screen Recorder
    #app/com.brave.Browser/x86_64/stable                                # Brave
    app/sh.ppy.osu/x86_64/stable                                        # Osu
    #app/org.telegram.desktop/x86_64/stable                             # Telegram
    app/io.github.dvlv.boxbuddyrs/x86_64/stable                         # BoxBuddy (distrobox frontend) # needs native podman installed
    https://sober.vinegarhq.org/sober.flatpakref                        # Sober (Roblox android frontend)
)

# Choose which services you want to enable
services=(
libvirtd.socket iwd gpu-screen-recorder-ui #jackett.service swapspace
)


# CHANGE MIRROR COUNTRY HERE !!!

# e.g: "France,Germany,Mexico" or "FR,DE,MX" (ISO 3166-1 alpha-2 format)
countries="BR,US"


# Put your shell env vars here (works for both ZSH and FISH)
shell_config=(
    #'alias nano="nano -/"'
    'alias z="zeditor"'
    'alias sc="systemctl"'
    'alias sce="systemctl enable"'
    'alias sceu="systemctl enable --user"'
    'alias scen="systemctl enable --now"'
    'alias sceun="systemctl enable --user --now"'
    'alias scs="systemctl status"'
    'alias scsu="systemctl status --user"'
    'alias scst="systemctl stop"'
    'alias scstu="systemctl stop --user"'
    'alias scd="systemctl disable"'
    'alias scdn="systemctl disable --now"'
    'alias scdu="systemctl disable --user"'
    'alias scdun="systemctl disable --user --now"'
    'alias scr="systemctl restart"'
    'alias scru="systemctl restart --user"'
    'alias lt="exa -T"'
    'alias la="exa -la"'
    'alias l="exa"'
    'alias ls="exa"'
    'alias nested="QT_QPA_PLATFORM=wayland dbus-launch -- kwin_wayland plasmashell"'
    'alias fwine="firejail --profile=/etc/firejail/wine.profile wine"'
    'alias fwinecfg="firejail --profile=/etc/firejail/wine.profile winecfg"'
    'alias fwine32="WINEARCH=win32 WINEPREFIX=~/.wine32 firejail --profile=/etc/firejail/wine32.profile wine"'
    'alias fwinecfg32="WINEARCH=win32 WINEPREFIX=~/.wine32 firejail --profile=/etc/firejail/wine32.profile winecfg"'

)

# ZRAM configuration (generator settings)
zram_config=(
    # Use 'ram' for 100% or 'ram / 2' for 50%.
    # On 6GB RAM, 100% is recommended for better multitasking.
    '[zram0]'
    'compression-algorithm = %ALGO%'
    'zram-size = ram * 2'  # gives ~12GB zram
    'swap-priority = 100'
    'fs-type = swap'

   # '#writeback-device = /dev/loop0'
)

# ZRAM parameters (Standard)
zram_params_config=(
    # Force the system to compress idle background apps
    'vm.swappiness = 150'

    # Helps with memory pressure spikes when the game loads new areas
    'vm.watermark_boost_factor = 0'
    'vm.watermark_scale_factor = 125'

    # Lower latency for games (stops the kernel from trying to read 'extra' swap pages)
    #'vm.page-cluster = 0 # Setting this to 0 helps latency, but increases I/O overhead with small frequent read/writes.'
)

# CachyOS specific ZRAM parameter configuration (udev rules)
# Since CachyOS the regular zram_params_config config path (/etc/sysctl.d/99-vm-zram-parameters.conf)
# won't work, we'll use CachyOS own config file (via udev, not via sysctl)
zram_params_config_cachy=(
    '# When used with ZRAM, it is better to prefer page out only anonymous pages,'
    '# because it ensures that they do not go out of memory, but will be just'
    '# compressed. If we do frequent flushing of file pages, that increases the'
    '# percentage of page cache misses, which in the long term gives additional'
    '# cycles to re-read the same data from disk that was previously in page cache.'
    '# This is the reason why it is recommended to use high values from 100 to keep'
    '# the page cache as hermetic as possible, because otherwise it is "expensive"'
    '# to read data from disk again. At the same time, uncompressing pages from ZRAM'
    '# is not as expensive and is usually very fast on modern CPUs.'
    '#'
    '# Also it is better to disable Zswap, as this may prevent ZRAM from working'
    '# properly or keeping a proper count of compressed pages via zramctl.'
    'ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="125", \'
    '    RUN+="/bin/sh -c '\''echo N > /sys/module/zswap/parameters/enabled'\''"'
)



# sudo usermod -aG zerotier-one striker (for zerotier-gui to work)
# TODO: Make a output for software that is being installed on other, programming, network and flatpak applications. Similar to what to enable_services() and remove_packages() already do.


# TODO: Make function to add custom repos via a variable, and maybe move chaotic aur function to it (altough not sure how im going to implement key/gpg auto signing support)
# TODO function to patch KDE (either through kwriteconfig6 or konsave):
# Custom KDE (Workspace and Konsole)
#ALT + V/C for pasting/coping on Konsole
#night light to 5000k Always on
#kde feedback
#gruvbox color theme
#add system measurement widgets
#shortcuts:
#redo = CTRL Y



NC='\033[0m' # No Color
BOLD='\033[1m' # Bold
DIM='\033[2m' # Dim/Faint
UNDERLINE='\033[4m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[38;5;226m'

logo() {
    echo -e ""
    echo -e "${BOLD}EOS Post install script ver ${iteration}${NC}"
    echo -e "By ${UNDERLINE}https://github.com/BrandowLucas${NC}"
    echo -e ""
}

update_mirrorlist() {
    echo
    printf "${BLUE}Do you want to update mirrorlist${RED} (recommended at least once)${NC}? (y/n): "
    read choice

    # Convert choice to lowercase for consistency
    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
        local countries="BR,US"

        local temp_file=$(mktemp)

        # Check if we're running Manjaro
        if grep -q "Manjaro" /etc/os-release; then
            echo -e "${YELLOW}You are running Manjaro, updating mirrorlist using pacman-mirrors, please wait... ${NC}"
            sudo pacman-mirrors --fasttrack
            echo -e "${GREEN}Updated Manjaro mirrorlist.${NC}"
        else
            # Otherwise, update Arch/EndeavourOS mirrors
            echo -e "${YELLOW}Updating Arch Linux repositories, please wait... ${NC}"
            reflector --verbose -c $countries --protocol https --sort rate --latest 10 --download-timeout 3 --threads 5 --save $temp_file

            sudo cp $temp_file /etc/pacman.d/mirrorlist

            rm $temp_file

            echo -e "${GREEN}Updated /etc/pacman.d/mirrorlist with the top 10 Arch Linux mirrors in $countries.${NC}"

            echo -e "${YELLOW}Updating EndeavourOS repositories, please wait... ${NC}"
            eos-rankmirrors --sort rate -t 3 --list-only
            echo -e "${GREEN}Updated /etc/pacman.d/endeavouros-mirrorlist with top fastest EOS mirrors${NC}"
        fi

        yay -Sy
    else
        echo "Skipping mirrorlist update..."
    fi
}

updatesys() {
    echo
    printf "${BLUE}Do you want to update your system${RED} (Highly advised after install — skipping may break the system)${NC}? (y/n): "
    read choice

    if [[ "$choice" == "y" ]]; then
        # Install 'archlinux-keyring' if not already installed
      #  if ! yay -Qq | grep -qw "archlinux-keyring"; then
            echo "Installing archlinux-keyring..."
            yay -S --noconfirm archlinux-keyring
     #   fi

        # Update system
        echo "Updating system..."
        yay -Syu --noconfirm
    else
        echo "Skipping system update..."
    fi
}

configure_chaotic_aur() {
    echo
    printf "${BLUE}Do you want to configure Chaotic AUR ${RED}(recommended)${NC}? (y/n): "
    read choice1
    if [[ "$choice1" == "y" ]]; then
        # Check if [chaotic-aur] section exists and comment it out if necessary
        if grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
            # Comment out the [chaotic-aur] section
            echo "The [chaotic-aur] section is present in /etc/pacman.conf. Commenting it out..."
            sudo sed -i 's/^\[chaotic-aur\]/#\[chaotic-aur\]/' /etc/pacman.conf
            sudo sed -i 's/^Include = \/etc\/pacman.d\/chaotic-mirrorlist/#Include = \/etc\/pacman.d\/chaotic-mirrorlist/' /etc/pacman.conf
        fi

        # Check if chaotic-keyring is installed
        if ! pacman -Qq chaotic-keyring > /dev/null 2>&1; then
            sudo pacman-key --init
            sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
            sudo pacman-key --lsign-key 3056513887B78AEB
            echo "chaotic-keyring is not installed. Installing..."
            sudo rm -rf /etc/pacman.d/chaotic*
            sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
            #sudo pacman -Sy
        else
            echo -e "${GREEN}chaotic-keyring is already installed.${NC}"
        fi

        # Check if chaotic-mirrorlist is installed
        if ! pacman -Qq chaotic-mirrorlist > /dev/null 2>&1; then
            echo "chaotic-mirrorlist is not installed. Installing..."
            sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
            sudo pacman -Sy # just in case
        else
            echo -e "${GREEN}chaotic-mirrorlist is already installed.${NC}"
        fi

        # Check if /etc/pacman.d/chaotic-mirrorlist exists and is readable
        if [ ! -r /etc/pacman.d/chaotic-mirrorlist ]; then
            echo "Error: /etc/pacman.d/chaotic-mirrorlist could not be read or does not exist."
            echo "Please ensure the file exists and is readable before configuring Chaotic AUR."
            exit 1
        fi

        # Check if [chaotic-aur] section should be uncommented
        if grep -q "^#\[chaotic-aur\]" /etc/pacman.conf; then
            echo "The [chaotic-aur] section is commented out in /etc/pacman.conf. Uncommenting..."
            sudo sed -i 's/^#\[chaotic-aur\]/\[chaotic-aur\]/' /etc/pacman.conf
            sudo sed -i 's/^#Include = \/etc\/pacman.d\/chaotic-mirrorlist/Include = \/etc\/pacman.d\/chaotic-mirrorlist/' /etc/pacman.conf
        else
            # Section doesn't exist, so append it
            if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
                sudo bash -c 'cat << EOF >> /etc/pacman.conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF'
                echo -e "${GREEN}Chaotic AUR configuration has been added to /etc/pacman.conf.${NC}"
            else
                echo "Chaotic AUR is already configured in /etc/pacman.conf."
            fi
        fi
        else
        echo "Skipping Chaotic AUR configuration..."
    fi
}

backup_system() {
    # Function to check if the system is using Btrfs
    is_btrfs() {
        mount | grep -q 'type btrfs'
    }

    echo
    echo -e "${BLUE}Do you want to install a backup system?${NC} "
    echo -e "1. Install ${ORANGE}Timeshift ${NC}(simpler to use)"
    echo -e "2. Install ${ORANGE}Btrfs Assistant ${NC}(advanced, but requires BTRFS fs)"

    read -p "Enter your choice [1-2]: " choice

    case $choice in
        1)
            if yay -Qq timeshift &> /dev/null; then
                echo -e "Timeshift ${GREEN}is already installed.${NC}"
            else
                echo "Installing Timeshift..."
                sudo pacman -S --noconfirm timeshift
            fi
            ;;
        2)
            if ! is_btrfs; then
                echo "Btrfs Assistant requires a Btrfs filesystem. Your system does not use Btrfs."
                return
            fi

            if yay -Qq btrfs-assistant &> /dev/null; then
                echo -e "${GREEN}Btrfs Assistant is already installed.${NC}"
            else
                echo "Installing Btrfs Assistant..."
                sudo pacman -S --noconfirm btrfs-assistant boost-libs
            fi
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please enter 1 or 2.${NC}"
            ;;
    esac
}

install_gui_store() {
    echo
    echo -e "${BLUE}Do you want to install a GUI store/package manager?${NC}"
    echo -e "1) Install ${ORANGE}Pamac${NC} (Native and Flatpak) ${RED}(recommended)${NC}"
    echo -e "2) Install ${ORANGE}Discover${NC} (Flatpak packages only)${NC}"
    echo -e "3) Install ${ORANGE}Octopi${NC} (Native packages only)${NC}"
    read -p "Please choose an option (1, 2, or 3): " choice

    case "$choice" in
        1)
            if ! yay -Qq pamac-flatpak &>/dev/null; then
                echo "Installing Pamac..."
                yay -S --noconfirm pamac-flatpak
            else
                echo -e "${GREEN}Pamac is already installed.${NC}"
            fi
            ;;
        2)
            if ! yay -Qq discover &>/dev/null; then
                echo "Installing Discover..."
                yay -S --noconfirm discover
            else
                echo -e "${GREEN}Discover is already installed.${NC}"
            fi
            ;;
        3)
            if ! yay -Qq octopi &>/dev/null; then
                echo "Installing Octopi..."
                yay -S --noconfirm octopi
            else
                echo -e "${GREEN}Octopi is already installed.${NC}"
            fi
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please select 1, 2, or 3.${NC}"
            return 1
            ;;
    esac
}

# Function to install other software
install_other_software() {
    echo
    printf "${BLUE}Do you want to install other software?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
            for pkg in "${packages[@]}"; do
        if yay -Qq "$pkg" > /dev/null 2>&1; then
            echo -e "$pkg ${GREEN}is already installed.${NC}"
        else
            echo "$pkg is not installed. Installing..."
            yay -S --noconfirm "$pkg"
        fi
    done
        else
        echo "Skipping instalation of other software..."
    fi
}

install_flatpak_apps() {
    echo
    printf "${BLUE}Do you want to install Flatpak applications?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        echo -e "${YELLOW}Installing Flatpak applications...${NC}"
        for app in "${flatpak_apps[@]}"; do
            # Check if the app is already installed (system or user)
            if flatpak list --system | grep -q "$app" || flatpak list --user | grep -q "$app"; then
                echo -e "  $app ${GREEN}is already installed.${NC}"
                continue
            fi

            # Try system-wide installation first
            echo -e "  Attempting system-wide installation of $app..."
            if flatpak install -y --system "$app" > /dev/null 2>&1; then
                echo -e "${GREEN}  $app installed successfully (system-wide).${NC}"
            else
                # If system-wide fails, try user installation
                echo -e "${YELLOW}  System-wide installation failed for $app. Trying user installation...${NC}"
                if flatpak install -y --user "$app"; then
                    echo -e "${GREEN}  $app installed successfully (user mode).${NC}"
                else
                    echo -e "${RED}  Failed to install $app in both system and user modes.${NC}"
                fi
            fi
        done
        echo -e "${GREEN}Flatpak installation complete.${NC}"
    else
        echo -e "${YELLOW}Skipping flatpak apps installation...${NC}"
    fi
}

# Function to install programming software
install_prog_software() {
    echo
    printf "${BLUE}Do you want to install programming/debugging software?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
            for pkg in "${prog_packages[@]}"; do
        if yay -Qq "$pkg" > /dev/null 2>&1; then
            echo -e "$pkg ${GREEN}is already installed.${NC}"
        else
            echo "$pkg is not installed. Installing..."
            yay -S --noconfirm "$pkg"
        fi
    done
        else
        echo "Skipping programming software installation..."
    fi
}

install_network_tools() {
    echo
    printf "${BLUE}Do you want to install network/pentest tools?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then

        for pkg in "${pentest_packages[@]}"; do
            if yay -Qq "$pkg" > /dev/null 2>&1; then
                echo -e "$pkg ${GREEN}is already installed.${NC}"
            else
                echo "$pkg is not installed. Installing..."
                yay -S --noconfirm "$pkg"
            fi
        done
            else
        echo "Skipping network/pentest tools instalation..."
    fi
}

gaming_dependencies() {
    echo
    printf "${BLUE}Do you want to install gaming dependencies?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
            for pkg in "${gaming_dependencies[@]}"; do
        if yay -Qq "$pkg" > /dev/null 2>&1; then
            echo -e "$pkg ${GREEN}is already installed.${NC}"
        else
            echo "$pkg is not installed. Installing..."
            yay -S --noconfirm "$pkg"
        fi
    done
        else
        echo "Skipping gaming dependencies instalation..."
    fi
}

choose_driver_installation() {
    # Sub-function to install RADV drivers
    install_radv_drivers() {

        radv_packages=(
            "vulkan-radeon" "lib32-vulkan-radeon"
        )

        for pkg in "${radv_packages[@]}"; do
            if yay -Qq "$pkg" > /dev/null 2>&1; then
                echo -e "$pkg ${GREEN}is already installed.${NC}"
            else
                echo "$pkg is not installed. Installing..."
                yay -S --noconfirm "$pkg"
            fi
        done
    }

    # Sub-function to install NVIDIA drivers
    install_nvidia_drivers() {

        nvidia_packages=(
            "nvidia-utils" "lib32-nvidia-utils" "nvidia" "nvidia-dkms" "nvidia-settings"
        )

        for pkg in "${nvidia_packages[@]}"; do
            if yay -Qq "$pkg" > /dev/null 2>&1; then
                echo -e "$pkg ${GREEN}is already installed.${NC}"
            else
                echo "$pkg is not installed. Installing..."
                yay -S --noconfirm "$pkg"
            fi
        done
    }

    # Sub-function to handle installing both RADV and Nvidia drivers
    install_both_drivers() {
        install_radv_drivers
        install_nvidia_drivers
    }

    echo
    echo -e "${BLUE}Which drivers do you want to install? ${NC}"
    echo -e "1. ${RED}RADV AMD drivers${NC}" # Red color for RADV
    echo -e "2. ${LIGHT_GREEN}NVIDIA Proprietary ${NC}drivers"
    echo -e "3. Both ${RED}RADV ${NC}and ${LIGHT_GREEN}NVIDIA ${NC}drivers"

    read -p "Please choose an option (1, 2, 3): " choice
    case $choice in
        1) install_radv_drivers ;;
        2) install_nvidia_drivers ;;
        3) install_both_drivers ;;
        *) echo -e "${YELLOW}Invalid choice. Please enter a number between 1 and 3.${NC}" ;;
    esac
}

install_shell() {

    # Sub-function to install and configure ZSH
    install_zsh() {
            if ! yay -Qq | grep -q "^zsh$"; then
                echo "Installing ZSH..."
                yay -S --noconfirm zsh
            else
                echo -e "ZSH ${GREEN}is already installed.${NC}"
            fi

            if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
                echo "Installing Oh My Zsh..."
                wget --no-check-certificate http://install.ohmyz.sh -O - | sh
            else
                echo -e "Oh My Zsh ${GREEN}is already installed.${NC}"
            fi

            if [[ "$SHELL" != "$(which zsh)" ]]; then
                echo "Changing the default shell to ZSH..."
                chsh -s "$(which zsh)"
            else
                echo "ZSH is already the default shell."
            fi

            ZSH_CONFIG_FILE="$HOME/.zshrc"

            # Add shell_config to .zshrc
            for setting in "${shell_config[@]}"; do
                if ! grep -q "$setting" "$ZSH_CONFIG_FILE"; then
                    echo "$setting" >> "$ZSH_CONFIG_FILE"
                fi
            done

            ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
            if [[ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]]; then
                echo "Installing zsh-autosuggestions plugin..."
                git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTOSUGGESTIONS_DIR"
            else
                echo -e "zsh-autosuggestions ${GREEN}plugin is already installed.${NC}"
            fi

            # Install zsh-syntax-highlighting
            ZSH_SYNTAX_HIGHLIGHTING_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
            if [[ ! -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]]; then
                echo "Installing zsh-syntax-highlighting plugin..."
                git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_HIGHLIGHTING_DIR"
            else
                echo -e "zsh-syntax-highlighting ${GREEN}plugin is already installed.${NC}"
            fi

            # Install fzf
            if ! command -v fzf &> /dev/null; then
                echo "Installing fzf..."
                yay -S --noconfirm fzf
            else
                echo -e "fzf ${GREEN}is already installed.${NC}"
            fi

           # echo "Configuring ZSH with fzf..."
            # Add fzf key bindings to .zshrc if not already present
            if ! grep -q 'bindkey.*fzf-history-widget' "$ZSH_CONFIG_FILE"; then
                cat << 'EOF' >> "$ZSH_CONFIG_FILE"
export FZF_DEFAULT_OPTS="--height 40% --reverse --border --preview 'echo {}' --bind 'ctrl-r:reload(history 1),ctrl-y:accept'"
bindkey '^R' fzf-history-widget
source /usr/share/fzf/key-bindings.zsh
EOF
            fi

            # Add plugins to .zshrc if not already present
            if ! grep -q "plugins=(.*zsh-autosuggestions.*)" "$ZSH_CONFIG_FILE"; then
                sed -i '/^plugins=(/ s/)/ zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSH_CONFIG_FILE"
            fi

            # Add ZSH_AUTOSUGGEST_STRATEGY to .zshrc
            if ! grep -q '^ZSH_AUTOSUGGEST_STRATEGY=' "$ZSH_CONFIG_FILE"; then
                echo 'ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >> "$ZSH_CONFIG_FILE"
            fi

            # Set the theme to agnoster
            if ! grep -q '^ZSH_THEME=' "$ZSH_CONFIG_FILE"; then
                echo 'ZSH_THEME="agnoster"' >> "$ZSH_CONFIG_FILE"
            else
                sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$ZSH_CONFIG_FILE"
            fi

            echo -e "${GREEN}ZSH installation and configuration complete.${NC}"
    }

    # Sub-function to install and configure FISH
    install_fish() {
    # Check if fish is installed
    if pacman -Qs fish >/dev/null 2>&1; then
        echo -e "${GREEN}FISH is already installed.${NC}"
    else
        echo "Installing FISH..."
        yay -S --noconfirm fish || { echo "Failed to install FISH"; exit 1; }
    fi

    # Check if starship is installed
    if pacman -Qs starship >/dev/null 2>&1; then
        echo -e "${GREEN}Starship is already installed.${NC}"
    else
        echo "Installing Starship..."
        yay -S --noconfirm archlinux-keyring starship || { echo "Failed to install Starship"; exit 1; }
    fi

    # Check and set default shell
    if [[ "$SHELL" != "$(which fish)" ]]; then
        echo "Changing the default shell to FISH..."
        chsh -s "$(which fish)" || { echo "Failed to change shell"; exit 1; }
    else
        echo -e "${GREEN}FISH is already the default shell.${NC}"
    fi

    FISH_CONFIG_FILE="$HOME/.config/fish/config.fish"

    # Create fish config directory
    mkdir -p "$HOME/.config/fish" || { echo "Failed to create fish config directory"; exit 1; }

    # Check if Starship initialization line exists
    if ! grep -qF "starship init fish | source" "$FISH_CONFIG_FILE"; then
        echo "starship init fish | source" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Starship"; exit 1; }
    fi

    # Add shell_config to config.fish
    for setting in "${shell_config[@]}"; do
        if ! grep -qF "$setting" "$FISH_CONFIG_FILE"; then
            echo "$setting" >> "$FISH_CONFIG_FILE" || { echo "Failed to add setting to config.fish"; exit 1; }
        fi
    done

    # Configure Starship
    echo "Configuring Starship..."
    starship preset gruvbox-rainbow -o ~/.config/starship.toml || { echo "Failed to configure Starship"; exit 1; }

    echo -e "${GREEN}FISH installation and configuration complete.${NC}"
}

    echo
    echo -e "${BLUE}Do you want to install and configure ${NC}ZSH ${BLUE}or ${NC}FISH ${BLUE}shell${NC}?"
    echo -e "1. ${ORANGE}ZSH${NC}"
    echo -e "2. ${ORANGE}FISH${NC}"

    read -p "Please choose an option (1 or 2): " choice

    case "$choice" in
        1)
            install_zsh
            ;;
        2)
            install_fish
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please choose 1 or 2.${NC}"
            ;;
    esac
}

alacritty() {
    echo
    printf "${BLUE}Do you want to install and configure Alacritty?${NC} (y/n): "
    read choice
        if [[ "$choice" == "y" ]]; then
        if yay -Qq alacritty > /dev/null 2>&1; then
            echo -e "alacritty ${GREEN}is already installed.${NC}"
        else
            echo "alacritty is not installed. Installing..."
            yay -S --noconfirm "alacritty"
        fi
    mkdir -p $HOME/.config/alacritty/
    bash -c 'cat  << EOF > $HOME/.config/alacritty/alacritty.toml
    [mouse]
bindings = [
{ mouse = "Right", action = "Copy" }
]

[keyboard]
bindings = [
{ key = "V", mods = "Alt", action = "Paste"},
{ key = "C", mods = "Alt", action = "Copy"},
]

[window]
opacity = 0.95
#padding = { x = 3, y = 3 }
#position = { x = 1800, y = 1200 }
#blur = true

[font]
size = 12

[cursor]
style =  {blinking = "Always" }
EOF'
        echo -e "${GREEN}Alacritty successfully configured.${NC}"
        else
        echo "Skipping Alacritty instalation..."
    fi
}

# Function to install and configure ZRAM
enable_zram() {
    echo
    echo -e "${BLUE}Do you want to install and configure ZRAM${NC}"
    echo -e "1) Configure zstd compression ${RED}(has better compression ratio)${NC}"
    echo -e "2) Configure lz4 compression ${RED}(has better speed)${NC}"
    read -p "Please choose an option (1 or 2): " compression_choice

    case "$compression_choice" in
        1)
            echo
            compression_algo="zstd"
            ;;
        2)
            echo
            compression_algo="lz4"
            ;;
        *)
            echo
            echo -e "${YELLOW}Invalid choice. Please select 1 or 2.${NC}"
            return 1
            ;;
    esac

    # CachyOS detection and path configuration
    local generator_path="/etc/systemd/zram-generator.conf"
    local params_path="/etc/sysctl.d/99-vm-zram-parameters.conf"
    local par_config=("${zram_params_config[@]}")

    if grep -q "cachyos" /etc/os-release; then
        echo -e "${YELLOW}CachyOS detected, using optimized configuration...${NC}"
        params_path="/etc/udev/rules.d/30-zram.rules"
        par_config=("${zram_params_config_cachy[@]}")
    fi

    echo "Installing and configuring ZRAM with $compression_algo compression..."

    if ! yay -Qq zram-generator > /dev/null 2>&1; then
        yay -Sy --noconfirm zram-generator
    fi

    # Write generator configuration
    printf "%s\n" "${zram_config[@]}" | sed "s/%ALGO%/$compression_algo/g" | sudo tee "$generator_path" > /dev/null

    # Write sysctl/udev configuration
    printf "%s\n" "${par_config[@]}" | sudo tee "$params_path" > /dev/null

    if grep -q "cachyos" /etc/os-release; then
        echo -e "${YELLOW}Applying ZRAM changes...${NC}"
        sudo systemctl stop systemd-zram-setup@zram0.service
        sudo systemctl start systemd-zram-setup@zram0.service
    fi

    echo -e "${GREEN}ZRAM configuration completed.${NC}"

# Troubleshoot: journalctl -xe | grep zram
}

# Function to update GRUB with ZSWAP parameters
update_grub_zswap() {
    local zswap_params="zswap.enabled=1 zswap.compressor=$1 zswap.max_pool_percent=20 zswap.zpool=z3fold"
    local grub_config="/etc/default/grub"
    local parameter="GRUB_CMDLINE_LINUX_DEFAULT"

    if [ -f "$grub_config" ]; then
        # Check if parameters are already present and match exactly what we want
        if grep -q "zswap.enabled=1" "$grub_config" && grep -q "zswap.compressor=$1" "$grub_config"; then
            echo "GRUB parameters are already set."
        else
            # Ensure zswap parameters are not duplicated and remove any existing ones
            sudo sed -i "s/zswap\.enabled=[^ \"']* //g; s/zswap\.enabled=[^ \"']*//g" "$grub_config"
            sudo sed -i "s/zswap\.compressor=[^ \"']* //g; s/zswap\.compressor=[^ \"']*//g" "$grub_config"
            sudo sed -i "s/zswap\.max_pool_percent=[^ \"']* //g; s/zswap\.max_pool_percent=[^ \"']*//g" "$grub_config"
            sudo sed -i "s/zswap\.zpool=[^ \"']* //g; s/zswap\.zpool=[^ \"']*//g" "$grub_config"

            # Prepend parameters to GRUB_CMDLINE_LINUX_DEFAULT, supporting both " and '
            if grep -q "^${parameter}=\"" "$grub_config"; then
                sudo sed -i "s/^${parameter}=\"/&${zswap_params} /" "$grub_config"
            elif grep -q "^${parameter}='" "$grub_config"; then
                sudo sed -i "s/^${parameter}='/&${zswap_params} /" "$grub_config"
            fi
            
            # Cleanup double spaces if any
            sudo sed -i "s/  / /g" "$grub_config"

            sudo update-grub > /dev/null 2>&1
            echo "GRUB parameters updated and grub configuration regenerated."
        fi
    else
        echo "$grub_config does not exist. Skipping GRUB update..."
    fi
}

# Function to update systemd-boot with ZSWAP parameters
update_systemdboot_zswap() {
    local zswap_params="zswap.enabled=1 zswap.compressor=$1 zswap.max_pool_percent=20 zswap.zpool=z3fold"

    # Check if /etc/kernel/cmdline exists
    if [ -f /etc/kernel/cmdline ]; then
        echo "Processing /etc/kernel/cmdline"

        # Backup the existing cmdline
        sudo cp /etc/kernel/cmdline /etc/kernel/cmdline.bak

        # Remove any existing Zswap parameters and extra spaces
        sudo sed -i "s/zswap\.enabled=[^ ]* //g; s/zswap\.enabled=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.compressor=[^ ]* //g; s/zswap\.compressor=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.max_pool_percent=[^ ]* //g; s/zswap\.max_pool_percent=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.zpool=[^ ]* //g; s/zswap\.zpool=[^ ]*$//g" /etc/kernel/cmdline

        # Append the new parameters
        if ! grep -q "zswap.enabled=1" /etc/kernel/cmdline; then
            if [ -s /etc/kernel/cmdline ]; then
                echo -n " $zswap_params" | sudo tee -a /etc/kernel/cmdline > /dev/null
            else
                echo -n "$zswap_params" | sudo tee -a /etc/kernel/cmdline > /dev/null
            fi
            echo "Updated /etc/kernel/cmdline with new parameters."
        else
            echo "Parameters already present in /etc/kernel/cmdline."
        fi

        # Regenerate the boot loader configuration
        sudo kernel-install add $(uname -r) /boot/vmlinuz-$(uname -r)
        echo "Bootloader configuration updated."
    else
        echo "File /etc/kernel/cmdline does not exist. Please ensure you are using systemd-boot."
        return 1
    fi
}

# Function to configure swap file and update /etc/fstab
configure_swap() {
    # Subfunction to check if Btrfs is used
    is_btrfs() {
        sudo mount | grep -q 'type btrfs'
    }

    # Subfunction to check if swap is active
    is_swap_active() {
        sudo swapon --show | grep -q 'swap'
    }

    # Prompt user for the swap file size
    printf "${BLUE}Enter the swap file size ${NC}(e.g., 1G, 2G, ...)${BLUE} or press Enter to use the default size ${NC}(8G): "
    read swap_size

    # Set default size if input is empty
    if [ -z "$swap_size" ]; then
        swap_size="8G"
    fi

    # Validate the swap_size input
    if ! [[ "$swap_size" =~ ^[1-9][0-9]?G$ ]] || [ "${swap_size%G}" -lt 1 ] || [ "${swap_size%G}" -gt 50 ]; then
        echo "Invalid size. Please enter a value between 1G and 50G."
        return 1
    fi

    echo "No active swap found. Setting up a swap $swap_size file..."

    # Turn off all active swaps
    sudo swapoff -a

    # Create a swap file
    sudo touch /swapfile

    # If the filesystem is Btrfs, set the 'C' attribute
    if is_btrfs; then
        sudo chattr +C /swapfile
    fi

    # Allocate space and configure the swap file
    sudo dd if=/dev/zero of=/swapfile bs=1M count=$(( ${swap_size%G} * 1024 ))
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    # Add swap entry to /etc/fstab if not already present
    if ! sudo grep -q '/swapfile' /etc/fstab; then
        echo "/swapfile                                 /swap          swap    defaults  0 0" | sudo tee -a /etc/fstab
    fi

    echo -e "${GREEN}Swap file of size $swap_size created and activated.${NC}"
}

# Function to disable zswap
disable_zswap() {
    echo "Disabling zswap..."

    # Check for systemd-boot
    if [ -f /etc/kernel/cmdline ]; then
        sudo sed -i "s/zswap\.enabled=[^ ]* //g; s/zswap\.enabled=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.compressor=[^ ]* //g; s/zswap\.compressor=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.max_pool_percent=[^ ]* //g; s/zswap\.max_pool_percent=[^ ]*$//g" /etc/kernel/cmdline
        sudo sed -i "s/zswap\.zpool=[^ ]* //g; s/zswap\.zpool=[^ ]*$//g" /etc/kernel/cmdline
        sudo kernel-install add $(uname -r) /boot/vmlinuz-$(uname -r)
        echo "Systemd-boot parameters updated."
    # Check for GRUB
    elif [ -f /etc/default/grub ]; then
        sudo sed -i "s/zswap\.enabled=[^ \"']* //g; s/zswap\.enabled=[^ \"']*//g" /etc/default/grub
        sudo sed -i "s/zswap\.compressor=[^ \"']* //g; s/zswap\.compressor=[^ \"']*//g" /etc/default/grub
        sudo sed -i "s/zswap\.max_pool_percent=[^ \"']* //g; s/zswap\.max_pool_percent=[^ \"']*//g" /etc/default/grub
        sudo sed -i "s/zswap\.zpool=[^ \"']* //g; s/zswap\.zpool=[^ \"']*//g" /etc/default/grub
        sudo update-grub > /dev/null 2>&1
        echo "GRUB parameters updated and grub configuration regenerated."
    else
        echo "Neither /etc/kernel/cmdline nor /etc/default/grub found. Cannot disable zswap."
        return 1
    fi
}

# Function to disable zram
disable_zram() {
    echo "Disabling zram..."

    if grep -q "cachyos" /etc/os-release; then
        echo -e "${YELLOW}CachyOS detected, disabling zram service and removing files...${NC}"
        sudo systemctl disable --now systemd-zram-setup@zram0.service
        # sudo swapoff /dev/zram0
        [ -f /etc/udev/rules.d/30-zram.rules ] && sudo rm /etc/udev/rules.d/30-zram.rules
    fi

    # Disable zRAM devices only
    for zram_device in $(sudo swapon --show=NAME | grep '/dev/zram'); do
        sudo swapoff "$zram_device"

        # Check if the zram-generator.conf file exists before attempting to remove it
        if [ -f /etc/systemd/zram-generator.conf ]; then
            sudo rm /etc/systemd/zram-generator.conf
            echo "$zram_device has been disabled and zram-generator.conf has been removed."
        else
            echo "$zram_device has been disabled, but zram-generator.conf was not found."
        fi
    done

    # Remove standard sysctl config
    if [ -f /etc/sysctl.d/99-vm-zram-parameters.conf ]; then
        sudo rm /etc/sysctl.d/99-vm-zram-parameters.conf
        echo "Standard zram parameters removed."
    fi
}

# Main function to handle memory configuration
z_memory() {
    echo
    echo -e "${BLUE}Do you want to install and configure ${NC}ZRAM ${BLUE}or ${NC}zSWAP ${RED}(recommended)${NC}?"
    echo -e "${BLUE}Please choose an option:${NC}"
    echo -e "1) Configure ${ORANGE}ZRAM${NC}"
    echo -e "2) Configure ${ORANGE}ZSWAP${NC}"
    read -p "Please choose an option (1 or 2): " choice

    case "$choice" in
        1)
            # Disable Zswap if active
            if sudo grep -q "zswap.enabled=1" /etc/kernel/cmdline 2>/dev/null || sudo grep -q "zswap.enabled=1" /etc/default/grub 2>/dev/null; then
                disable_zswap
            fi

            # Disable and remove the swapfile if present
            if sudo swapon --show=NAME | grep -q '/swapfile'; then
                echo "Swapfile detected. Removing..."
                sudo swapoff /swapfile
                sudo rm /swapfile
                sudo sed -i '/\/swapfile/d' /etc/fstab
                echo "Swapfile removed."
            fi

            enable_zram
            ;;
        2)
            # Disable ZRAM if active
            if sudo swapon --show=NAME | grep -q '/dev/zram'; then
                disable_zram
            fi

            # Disable and remove the swapfile if present
            if sudo swapon --show=NAME | grep -q '/swapfile'; then
                echo "Swapfile detected. Removing..."
                sudo swapoff /swapfile
                sudo rm /swapfile
                sudo sed -i '/\/swapfile/d' /etc/fstab
                echo "Swapfile removed."
            fi

            # Ask user for the Zswap compression option
            echo
            echo -e "${BLUE}Do you want to configure ZSWAP with${NC}"
            echo -e "1) lz4 compression ${RED}(better speed)${NC}"
            echo -e "2) zstd compression ${RED}(better compression ratio)${NC}"
            read -p "Please choose an option (1 or 2): " zswap_choice

            case "$zswap_choice" in
                1)
                    echo
                    zswap_compressor="lz4"
                    ;;
                2)
                    echo
                    zswap_compressor="zstd"
                    ;;
                *)
                    echo -e "${YELLOW}Invalid choice. Please select 1 or 2.${NC}"
                    return 1
                    ;;
            esac

            # Update bootloader with Zswap parameters
            if [ -f /etc/kernel/cmdline ]; then
                update_systemdboot_zswap "$zswap_compressor"
                configure_swap
            elif [ -f /etc/default/grub ]; then
                update_grub_zswap "$zswap_compressor"
                configure_swap
            else
                echo -e "${RED}Neither /etc/kernel/cmdline nor /etc/default/grub found. Skipping bootloader update...${NC}"
            fi
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please select 1 or 2.${NC}"
            return 1
            ;;
    esac

    echo -e "${YELLOW}Please reboot to apply any changes.${NC}"
}

#TODO with the next steam beta update, the following script will become obsolete.
configure_steam() {
    echo
    echo -e "${BLUE}Do you want to install and configure Steam?${NC}"
    echo -e "${RED}You need to first log in to your account and then close Steam completely${NC}"

    echo -e "1) Configure Steam Native setup ${RED}(recommended)${NC}"
    echo -e "2) Configure Steam Flatpak setup (recommended only if you play EAC-protected games)"
    read -p "Please choose an option (1 or 2): " choice

    case "$choice" in
        1)
            echo -e "${YELLOW}Configuring Steam Native setup...${NC}"

            # Install Steam and dependencies
            if yay -Qq steam > /dev/null 2>&1; then
                echo -e "${GREEN}Steam is already installed.${NC}"
            else
                echo -e "${YELLOW}Installing Steam...${NC}"
                yay -S --noconfirm steam xdg-desktop-portal-gtk
            fi

            # Install MangoHud for performance overlay
            if yay -Qq mangohud > /dev/null 2>&1; then
                echo -e "${GREEN}MangoHud is already installed.${NC}"
            else
                echo -e "${YELLOW}Installing MangoHud...${NC}"
                yay -S --noconfirm mangohud lib32-mangohud
            fi

            echo -e "${GREEN}Disabling Shader Pre-Cache, enabling Proton Experimental, and setting default tab to Library...${NC}"

            steam_config_dir="$HOME/.local/share/Steam/config"
            steam_userdata_dir="$HOME/.local/share/Steam/userdata"

            # Ensure config directory exists
            mkdir -p "$steam_config_dir"

            # Modify config.vdf
            config_file="$steam_config_dir/config.vdf"
            if [ ! -f "$config_file" ]; then
                echo -e "${YELLOW}Creating new config.vdf...${NC}"
                echo -e "{\n\t\"Steam\" {}\n}" > "$config_file"
            fi

            # Add Proton Experimental
            if ! grep -q "CompatToolMapping" "$config_file"; then
                line_number=$(grep -n '"Rate"' "$config_file" | cut -d: -f1)
                if [ -z "$line_number" ]; then
                    line_number=$(wc -l < "$config_file")
                fi
                content='
                    "CompatToolMapping"
                    {
                        "0"
                        {
                            "name"        "proton_experimental"
                            "config"        ""
                            "priority"        "75"
                        }
                    }
                '
                { head -n "$line_number" "$config_file"; echo "$content"; tail -n +$((line_number+1)) "$config_file"; } > temp.txt && mv temp.txt "$config_file"
            fi

            # Disable Shader Pre-Cache
            if ! grep -q "DisableShaderCache" "$config_file"; then
                line_number=$(grep -n 'CompatVideoTCMediaV1' "$config_file" | cut -d: -f1)
                if [ -z "$line_number" ]; then
                    line_number=$(wc -l < "$config_file")
                fi
                content='
                        "DisableShaderCache"        "1"
                '
                { head -n "$line_number" "$config_file"; echo "$content"; tail -n +$((line_number+1)) "$config_file"; } | sed '/^$/d' > temp.txt && mv temp.txt "$config_file"
            fi

            # Set Library as default tab
            if [ -d "$steam_userdata_dir" ]; then
                for localconfig in "$steam_userdata_dir"/*/config/localconfig.vdf; do
                    if [ -f "$localconfig" ]; then
                        sed -i 's/"NotifyAvailableGames"\s*"\([0-9]\)"/"NotifyAvailableGames"     "0"/g' "$localconfig"
                    fi
                done
            fi

            echo -e "${GREEN}Steam Native configuration completed.${NC}"
            ;;
        2)
            echo -e "${YELLOW}Configuring Steam Flatpak setup...${NC}"

            # Install Steam and MangoHud via Flatpak
            if flatpak list | grep -q "com.valvesoftware.Steam"; then
                echo -e "${GREEN}Steam Flatpak is already installed.${NC}"
            else
                echo -e "${YELLOW}Installing Steam Flatpak...${NC}"
                flatpak install -y app/com.valvesoftware.Steam/x86_64/stable
            fi

            if flatpak list | grep -q "org.freedesktop.Platform.VulkanLayer.MangoHud"; then
                echo -e "${GREEN}MangoHud Flatpak is already installed.${NC}"
            else
                echo -e "${YELLOW}Installing MangoHud Flatpak...${NC}"
                flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
            fi

            # Fix MangoHud permissions
            sudo flatpak override --filesystem=xdg-config/MangoHud:ro com.valvesoftware.Steam

            echo -e "${GREEN}Disabling Shader Pre-Cache, enabling Proton Experimental, and setting default tab to Library...${NC}"

            steam_flatpak_config="$HOME/.var/app/com.valvesoftware.Steam/data/Steam/config/config.vdf"
            steam_flatpak_userdata="$HOME/.var/app/com.valvesoftware.Steam/data/Steam/userdata"

            # Ensure config directory exists
            mkdir -p "$(dirname "$steam_flatpak_config")"

            # Modify config.vdf
            if [ ! -f "$steam_flatpak_config" ]; then
                echo -e "${YELLOW}Creating new config.vdf for Flatpak...${NC}"
                echo -e "{\n\t\"Steam\" {}\n}" > "$steam_flatpak_config"
            fi

            # Add Proton Experimental
            if ! grep -q "CompatToolMapping" "$steam_flatpak_config"; then
                line_number=$(grep -n '"Rate"' "$steam_flatpak_config" | cut -d: -f1)
                if [ -z "$line_number" ]; then
                    line_number=$(wc -l < "$steam_flatpak_config")
                fi
                content='
                    "CompatToolMapping"
                    {
                        "0"
                        {
                            "name"        "proton_experimental"
                            "config"        ""
                            "priority"        "75"
                        }
                    }
                '
                { head -n "$line_number" "$steam_flatpak_config"; echo "$content"; tail -n +$((line_number+1)) "$steam_flatpak_config"; } > temp.txt && mv temp.txt "$steam_flatpak_config"
            fi

            # Disable Shader Pre-Cache
            if ! grep -q "DisableShaderCache" "$steam_flatpak_config"; then
                line_number=$(grep -n 'CompatVideoTCMediaV1' "$steam_flatpak_config" | cut -d: -f1)
                if [ -z "$line_number" ]; then
                    line_number=$(wc -l < "$steam_flatpak_config")
                fi
                content='
                        "DisableShaderCache"        "1"
                '
                { head -n "$line_number" "$steam_flatpak_config"; echo "$content"; tail -n +$((line_number+1)) "$steam_flatpak_config"; } | sed '/^$/d' > temp.txt && mv temp.txt "$steam_flatpak_config"
            fi

            # Set Library as default tab
            if [ -d "$steam_flatpak_userdata" ]; then
                for localconfig in "$steam_flatpak_userdata"/*/config/localconfig.vdf; do
                    if [ -f "$localconfig" ]; then
                        sed -i 's/"NotifyAvailableGames"\s*"\([0-9]\)"/"NotifyAvailableGames"     "0"/g' "$localconfig"
                    fi
                done
            fi

            echo -e "${GREEN}Steam Flatpak configuration completed.${NC}"
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please select 1 or 2.${NC}"
            ;;
    esac
}

remove_debounce() {
    echo
    printf "${BLUE}Do you want to remove debounce/double click prevention ${RED}(recommended)${NC}? (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        sudo mkdir -p /etc/libinput
        sudo bash -c 'cat << EOF > /etc/libinput/local-overrides.quirks
[Never Debounce]
MatchUdevType=mouse
ModelBouncingKeys=1
EOF'
    echo -e "${GREEN}Debounce and double click prevention removed${NC}"
    else
    echo "Skipping debounce/double click prevention removal..."
    fi
}

enable_services() {
    echo
    echo -e "${BLUE}Do you want to enable services?${NC}"
    echo -e "It will enable the following services: ${ORANGE}${services[*]}${NC}"
    printf "(y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        for service in "${services[@]}"; do
            # Check if the service is already enabled (system or user)
            if systemctl is-enabled "$service" &>/dev/null || systemctl --user is-enabled "$service" &>/dev/null; then
                echo -e "${GREEN}${service} is already enabled.${NC}"
                continue
            fi

            # Try system-wide enabling first
            echo -e "${YELLOW}Attempting to enable $service system-wide...${NC}"
            if output=$(sudo systemctl enable --now "$service" 2>&1); then
                echo -e "${GREEN}${service} enabled successfully (system-wide).${NC}"
                echo -e "${GREEN}${output}${NC}"
            else
                # If system-wide fails, try user enabling
                echo -e "${YELLOW}System-wide enabling failed for $service. Trying user enabling...${NC}"
                if output=$(systemctl --user enable --now "$service" 2>&1); then
                    echo -e "${GREEN}${service} enabled successfully (user mode).${NC}"
                    echo -e "${GREEN}${output}${NC}"
                else
                    echo -e "${RED}Failed to enable $service in both system and user modes.${NC}"
                fi
            fi
        done
    else
        echo -e "${YELLOW}Skipping services enabling...${NC}"
    fi
}

remove_packages() {
    echo
    printf "${BLUE}Do you want to remove these packages?${NC} "
    # Flush the output buffer
    printf "\n"

    echo -e "It will remove the following packages: ${RED}${remove_packages[*]}${NC}"
    printf "(y/n): "
    read choice

    if [[ "$choice" == "y" ]]; then
    for pkg in "${remove_packages[@]}"; do
        if yay -Qq "$pkg" > /dev/null 2>&1; then
            echo "$pkg is installed. Removing..."
            yay -R --noconfirm "$pkg"
        else
            echo "$pkg is not installed. Nothing to do."
        fi
    done
        else
        echo "Skipping package removal..."
    fi
}

configure_printer()
{
    echo
    printf "${BLUE}Do you want to enable printer support?${NC} (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        # Enable scan support
        for pkg in "iscan" "iscan-data"; do # "iscan-plugin-network"
            if ! yay -Qq "$pkg" > /dev/null 2>&1; then
                echo "Installing $pkg..."
                yay -Sy --noconfirm "$pkg"
            else
                echo -e "${GREEN}$pkg is already installed.${NC}"
            fi
        done

        # Enable printing support
        for pkg in  "cups" "system-config-printer"; do # "epson-inkjet-printer-201101w"
            if ! yay -Qq "$pkg" > /dev/null 2>&1; then
                echo "Installing $pkg..."
                yay -Sy --noconfirm "$pkg"
            else
                echo -e "${GREEN}$pkg is already installed.${NC}"
            fi
        done

        # Enable and start the CUPS service
        sudo systemctl enable --now cups
        echo -e "${GREEN}CUPS service has been enabled and started.${NC}"

        # Source of download for Epson: https://download.ebz.epson.net/dsc/search/01/search/
    fi
}

# Function to enable user theme (most likely dark theme) into root
darkmode_on_root() {
    echo
    echo -e "${BLUE}Do you want to enable user theme into root${NC}? (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        yay -S konsave
        konsave -s user && konsave -e user
        sudo konsave -i ~/user.knsv
        sudo konsave -a user
        rm -rf ~/user.knsv
    fi
}

bootloader_customizer() {
    echo
    echo -e "${BLUE}Do you want to configure and update the grub bootloader${NC}? "
    echo -e "- It will install ${ORANGE}grub-customizer${NC}, ${ORANGE}grub-btrfs${NC} and update the grub entries"
    printf "(y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        if [ -d "/boot/grub" ]; then
            echo "GRUB detected."
            for pkg in grub-customizer grub-btrfs; do
                if yay -Qq "$pkg" > /dev/null 2>&1; then
                    echo -e "$pkg ${GREEN}is already installed.${NC}"
                else
                    echo "$pkg is not installed. Installing..."
                    yay -S --noconfirm "$pkg"
                fi
            done
            sudo update-grub
        elif sudo [ -d "/etc/kernel/cmdline" ] && [ "$(sudo ls -A /etc/kernel/cmdline)" ]; then
            echo "systemd-boot detected. No action needed."
        else
            echo -e "${RED}Unknown bootloader. No action taken.${NC}"
        fi
    elif [[ "$choice" != "y" ]]; then
        echo "Skipping grub configuration..."
    fi
}


waydroid() {
    echo
    printf "${BLUE}Do you want to install and configure Waydroid${NC}? (y/n): "
    read choice
    if [[ "$choice" == "y" ]]; then
        # Lock file to prevent multiple instances
        LOCK_FILE="/tmp/waydroid_script.lock"
        if [ -f "$LOCK_FILE" ]; then
            echo -e "${RED}Waydroid setup is already running. Exiting.${NC}"
            return 1
        fi

        # Create the lock file
        touch "$LOCK_FILE"
        echo -e "${GREEN}Lock file created.${NC}"

        # Trap to ensure lock file is removed and script exits on interrupt
        trap 'echo -e "${RED}Interrupted. Removing lock file and exiting...${NC}"; rm -f "$LOCK_FILE"; exit 1' SIGINT SIGTERM

        echo -e "${BLUE}Starting Waydroid setup...${NC}"

        # Step 1: Check if Waydroid and waydroid-script-git are installed
        for pkg in "waydroid" "waydroid-script-git"; do
            if yay -Qq "$pkg" > /dev/null 2>&1; then
                echo -e "$pkg ${GREEN}is already installed.${NC}"
            else
                echo -e "$pkg is not installed. Installing..."
                yay -S --noconfirm "$pkg"
                if [ $? -ne 0 ]; then
                    echo -e "${RED}Failed to install $pkg.${NC}"
                    rm -f "$LOCK_FILE"
                    return 1
                fi
            fi
        done

        # Step 2: Check if Waydroid is initialized or prompt for reinitialization
        echo -e "${BLUE}Checking Waydroid status...${NC}"
        if ! sudo waydroid status > /dev/null 2>&1 || sudo waydroid status | grep -q "ERROR: WayDroid is not initialized"; then
            echo -e "${YELLOW}Waydroid is not initialized. Initializing now...${NC}"
            if sudo waydroid init -f -s GAPPS; then
                echo -e "${GREEN}Waydroid initialized successfully.${NC}"
            else
                echo -e "${RED}Failed to initialize Waydroid.${NC}"
                rm -f "$LOCK_FILE"
                return 1
            fi
        else
            echo -e "${GREEN}Waydroid is already initialized.${NC}"
            printf "${BLUE}Do you want to reinitialize Waydroid${NC}? (y/n): "
            read -r reinitialize
            if [[ "$reinitialize" == "y" || "$reinitialize" == "Y" ]]; then
                echo -e "${YELLOW}Forcing Waydroid reinitialization...${NC}"
                if sudo waydroid init -f -s GAPPS; then
                    echo -e "${GREEN}Waydroid reinitialized successfully.${NC}"
                else
                    echo -e "${RED}Failed to reinitialize Waydroid.${NC}"
                    rm -f "$LOCK_FILE"
                    return 1
                fi
            else
                echo -e "${GREEN}Skipping reinitialization.${NC}"
            fi
        fi

        # Step 3: Configure firewall
        if systemctl is-active --quiet firewalld; then
            echo -e "${BLUE}Configuring FirewallD...${NC}"
            if ! sudo firewall-cmd --zone=trusted --query-interface=waydroid0 > /dev/null 2>&1; then
                sudo firewall-cmd --zone=trusted --add-interface=waydroid0 --permanent
                sudo firewall-cmd --reload
                echo -e "${GREEN}FirewallD configured for Waydroid.${NC}"
            else
                echo -e "${GREEN}FirewallD already configured for Waydroid.${NC}"
            fi
        elif sudo ufw status | grep -q "active"; then
            echo -e "${BLUE}Configuring UFW...${NC}"
            if ! sudo ufw status | grep -q "waydroid0"; then
                sudo ufw allow in on waydroid0
                echo -e "${GREEN}UFW configured for Waydroid.${NC}"
            else
                echo -e "${GREEN}UFW already configured for Waydroid.${NC}"
            fi
        else
            echo -e "${YELLOW}No firewall detected or firewall not active, ignoring...${NC}"
        fi

        # Step 4: Enable and start Waydroid service
        if ! systemctl is-enabled --quiet waydroid-container; then
            echo -e "${BLUE}Enabling Waydroid service...${NC}"
            sudo systemctl enable waydroid-container
        else
            echo -e "${GREEN}Waydroid service is already enabled.${NC}"
        fi

        if ! systemctl is-active --quiet waydroid-container; then
            echo -e "${BLUE}Starting Waydroid service...${NC}"
            sudo systemctl start waydroid-container
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to start Waydroid service.${NC}"
                rm -f "$LOCK_FILE"
                return 1
            fi
        else
            echo -e "${GREEN}Waydroid service is already running.${NC}"
        fi

        # Step 5: Start Waydroid session if not already running
        if ! pgrep -f "waydroid session" > /dev/null; then
            echo -e "${BLUE}Starting Waydroid session in the background...${NC}"
            nohup waydroid session start > /dev/null 2>&1 &
            sleep 2  # Brief pause to allow session to start
        else
            echo -e "${GREEN}Waydroid session is already running.${NC}"
        fi

        # Step 6: Show full UI
        #echo -e "${BLUE}Showing full UI...${NC}"
        #nohup waydroid show-full-ui > /dev/null 2>&1 &

        # Step 7: Display Google registration instructions
        echo -e "${GREEN}Waydroid setup completed successfully.${NC}"
        echo -e "${YELLOW}Please register your device with Google:${NC}"
        echo -e "1. Run ${ORANGE}sudo waydroid shell${NC} to access the shell."
        echo "2. Execute this command to get your Android ID:"
        echo -e "${ORANGE}   ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db \"select * from main where name = \\\"android_id\\\";\"${NC}"
        echo -e "3. ${NC}Copy the ID and paste it on:${BLUE} https://www.google.com/android/uncertified${NC}"
        echo -e "4. Run the following command upon registration: ${ORANGE}sudo systemctl restart waydroid-container.service${NC}"
    else
        echo -e "Skipping Waydroid installation and configuration...${NC}"
    fi
}

install_firewall() {
    echo
    echo -e "${BLUE}Do you want to install and enable a firewall manager?${NC}"
    echo -e "1) Install ${ORANGE}UFW${NC} (Uncomplicated Firewall) ${RED}(recommended)${NC}"
    echo -e "2) Install ${ORANGE}Firewalld${NC} (Dynamic firewall manager)${NC}"
    read -p "Please choose an option (1, 2): " choice

    case "$choice" in
        1)
            if ! yay -Qq ufw &>/dev/null; then
                echo "Installing UFW..."
                yay -S --noconfirm ufw
                echo -e "${GREEN}Enabling services....${NC}"
                sudo systemctl enable --now firewalld
                sudo systemctl disable --now ufw
            else
                echo -e "${GREEN}UFW is already installed.${NC}"
                echo -e "${GREEN}Enabling services....${NC}"
                sudo systemctl enable --now ufw
                sudo systemctl disable --now firewalld
            fi
            ;;
        2)
            if ! yay -Qq firewalld &>/dev/null; then
                echo "Installing Firewalld..."
                yay -S --noconfirm firewalld
                echo -e "${GREEN}Enabling services....${NC}"
                sudo systemctl enable --now firewalld
                sudo systemctl disable --now ufw
            else
                echo -e "${GREEN}Firewalld is already installed.${NC}"
                echo -e "${GREEN}Enabling services....${NC}"
                sudo systemctl enable --now firewalld
                sudo systemctl disable --now ufw
            fi
            ;;
        *)
            echo -e "${YELLOW}Invalid choise. Please choose 1 or 2.${NC}"
            ;;
    esac
}

setup_plymouth() {
  echo -e "${BLUE}Checking if Plymouth is installed...${NC}"
  if ! yay -Qq plymouth &>/dev/null; then
    echo -e "${RED}Plymouth is not installed. Installing Plymouth...${NC}"
    yay -S --noconfirm plymouth
    echo -e "${GREEN}Plymouth has been installed.${NC}"
  else
    echo -e "${GREEN}Plymouth is already installed.${NC}"
  fi

  # Ask if the user wants a default or custom theme
  echo -e "${BLUE}Do you want to choose a default theme or a custom one from AUR?${NC}"
  echo -e "1) Choose a default theme"
  echo -e "2) Set a custom theme from AUR (requires a valid theme package input)"
  read -p "Please choose an option (1, 2): " choice

  custom_theme_installed=false
  default_theme_set=false
  theme_changed=false  # Flag to track if any theme change happened

  case "$choice" in
    1)
      echo -e "${BLUE}Listing available Plymouth themes:${NC}"
      plymouth-set-default-theme -l

      echo -e "${ORANGE}Enter the name of the Plymouth theme you want to set:${NC}"
      read -r theme_name

      if [[ -z "$theme_name" ]]; then
        echo -e "${RED}No theme name entered. Skipping default theme setting...${NC}"
      else
        echo -e "${BLUE}Setting Plymouth theme to ${ORANGE}'$theme_name'${NC}..."
        sudo plymouth-set-default-theme "$theme_name"

        echo -e "${BLUE}Updating /etc/plymouth/plymouthd.conf...${NC}"
        sudo sed -i "s/^#Theme=/Theme=$theme_name/" /etc/plymouth/plymouthd.conf
        default_theme_set=true
        theme_changed=true
      fi
      ;;
    2)
    echo -e "${ORANGE}Enter the package name for the custom theme (e.g., plymouth-theme-endeavouros):${NC}"
    read -r package_name

    if [[ -z "$package_name" ]]; then
        echo -e "${RED}No package name entered. Skipping custom theme installation...${NC}"
        custom_theme_installed=false
    else
    # Check if the package is already installed
    if pacman -Q "$package_name" &>/dev/null; then
        echo -e "${GREEN}Custom theme ${NC}'${package_name}' ${GREEN}is already installed.${NC}"
        custom_theme_installed=true
        theme_changed=true
    else
    # Install the package using yay (it will install print "successfully installed" for whatever package the user inputs, no matter if it is not a valid package)
        yay -S --noconfirm "$package_name"
        echo -e "${GREEN}Custom theme '${package_name}' has been installed.${NC}"
        custom_theme_installed=true
        theme_changed=true
    fi
fi
      ;;
    *)
      echo -e "${RED}Invalid choice. Please choose 1 or 2.${NC}"
      return 1
      ;;
  esac

  # Check and update /etc/kernel/cmdline if "splash" or "quiet" are not present
  if ! grep -q "quiet" /etc/kernel/cmdline && ! grep -q "splash" /etc/kernel/cmdline; then
    echo -e "${BLUE}Updating kernel command line parameters...${NC}"
    sudo sed -i 's/$/ splash quiet/' /etc/kernel/cmdline
    echo -e "${GREEN}Kernel parameters updated.${NC}"
  else
    echo -e "${GREEN}Kernel parameters already contain 'splash' or 'quiet'. No changes made.${NC}"
  fi

  # Reinstall kernels to apply changes, only if a custom theme was installed or a default theme was successfully set
  if [[ "$theme_changed" == true ]]; then
    echo -e "${BLUE}Reinstalling kernels to apply changes...${NC}"
    sudo reinstall-kernels
    echo -e "${GREEN}Kernels reinstalled successfully.${NC}"
    echo -e "${GREEN}Plymouth setup is complete. Please reboot your system to apply changes.${NC}"
  else
    echo -e "${RED}No theme changes were made, skipping kernel reinstallation...${NC}"
  fi
}

check_and_install_yay() {
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        echo "yay is not installed. Installing yay..."

        # Install dependencies and yay
        sudo pacman -S --needed --noconfirm git base-devel

        # Clone yay from AUR and build it
        git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin || return 1
        makepkg -si --noconfirm
        cd - || return 1
        rm -rf yay-bin
        echo "yay installation complete."
   # else
   #     echo "yay is already installed."
    fi
}


# Main function to call all other functions
main() {
    logo
    check_and_install_yay
    update_mirrorlist
    updatesys
    configure_chaotic_aur
    install_shell
    backup_system
    bootloader_customizer
    z_memory
    install_gui_store
    gaming_dependencies
    choose_driver_installation
    configure_steam # finish this one
    install_firewall
    install_other_software
    install_prog_software
    install_network_tools
    install_flatpak_apps
    remove_debounce
    waydroid
    alacritty
    remove_packages
    configure_printer
    setup_plymouth
    enable_services
   # darkmode_on_root TODO: needs "konsave" into chaotic AUR
}

#set nowrap
#set softwrap
echo "include /usr/share/nano/*.nanorc" > ~/.nanorc

#archlinux-java status
sudo archlinux-java set java-17-openjdk

main
