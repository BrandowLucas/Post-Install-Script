#!/bin/bash

# SCRIPT MADE BY STRIKER -> github.com/BrandowLucas

iteration="1.0.2"

# MODIFY YOUR PACKAGES HERE !!!
packages=(
flatpak shared-mime-info dolphin-plugins p7zip unzip zenity qbittorrent htop ncdu dhclient corectrl firejail flatpak-kcm protontricks inotify-tools fast eog discord system-monitoring-center hardinfo debtap webapp-manager zerotier-one zerotier-gui-git distrobox podman q4wine-git yt-dlp obs-studio hunspell-en_us klassy brave eza lunar-client kio-admin gpu-screen-recorder-ui mission-center lshw qemu-desktop virt-manager protonplus libinput-tools evtest signal-desktop darkly-bin hmcl-beta-bin drm-info kdebugsettings losslesscut-bin cloudflare-warp-bin wgcf tesseract tesseract-data-eng xorg-server-xvfb # xorg-xkill plasma-x11-session quickemu keepassxc notion-app-electron detect-it-easy-bin telegram-desktop obsidian kwalletmanager jackett orca lightly-qt session-desktop-bin swapspace kwin-effect-rounded-corners-git proton-vpn-gtk-app mongodb-compass vesktop piper gemini-cli claude-code kilo-bin opencode openai-codex-bin

# xorg-xeyes (use kwin debug window instead)
# haguichi (its most of the time unrealible to connect, use zerotier instead)

# wgcf register && wgcf generate && nmcli connection import type wireguard file wgcf-profile.conf
#
# For NEW IP:
#
# nmcli connection down wgcf-profile 2>/dev/null; nmcli connection delete wgcf-profile 2>/dev/null; rm -f wgcf-account.toml wgcf-profile.conf && wgcf register --accept-tos && wgcf generate && nmcli connection import type wireguard file wgcf-profile.conf && nmcli connection up wgcf-profile


# XFCE: xfce4 xfce4-goodies xfce4-clipman-plugin xfce4-taskmanager xfce4-pulseaudio-plugin gvfs-mtp gvfs-afc gvfs-smb udisks2 xfce4-screenshooter bluez bluez-utils blueman file-roller network-manager-applet
)

prog_packages=(
python-pip cmake maven meson jdk21-openjdk jdk8-openjdk go rust valkey mongo
sourcegit zed github-cli git-credential-manager recaf gdb strace ltrace
# helix intellij-idea-community-edition #clion visual-studio-code-bin trash-cli github-desktop
glfw glew extra-cmake-modules mingw-w64-gcc #opencl-headers
cabextract innoextract-git #official innoextract package not enough (i had problems), use git 
innounp-bin
php #needed for ifpstools
)

# set: export GCM_CREDENTIAL_STORE=secretservice
# for sourcegit be able to log in into your account

# git config --global user.email "email@gmail.com"
# git config --global user.name "BrandowLucas"

pentest_packages=(
wireshark-qt whois gnu-netcat nmap mtr nmap bind bind-tools geoip doggo zaproxy
tcpdump macchanger scapy masscan arp-scan
hping httptunnel httrack hashcat
binwalk radare2 radare2-r2ghidra
mhash aircrack-ng socat
sleuthkit mitmproxy #maltego
)

gaming_packages=(
wine-staging winetricks lib32-vulkan-icd-loader vkbasalt lib32-vkbasalt
mangohud-git lib32-mangohud-git goverlay-git gamemode lib32-gamemode lutris latencyflex-bin #
heroic-games-launcher-bin ttf-arimo-nerd lib32-freetype2 freetype2
lib32-alsa-plugins lib32-pipewire gamescope lib32-sdl sdl sdl2 lib32-sdl2 #bottles
umu-launcher # (use proton via commandline)
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
    app/org.vinegarhq.Sober/x86_64/stable                        # Sober (Roblox android frontend)
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
    'alias lt="eza -T"'
    'alias la="eza -la"'
    'alias l="eza"'
    'alias ls="eza"'
    'alias nested="QT_QPA_PLATFORM=wayland dbus-launch -- kwin_wayland plasmashell"'
    'alias fwine="firejail --profile=/etc/firejail/wine.profile wine"'
    'alias fwinecfg="firejail --profile=/etc/firejail/wine.profile winecfg"'
    'alias fwine32="WINEARCH=win32 WINEPREFIX=~/.wine32 firejail --profile=/etc/firejail/wine32.profile wine"'
    'alias fwinecfg32="WINEARCH=win32 WINEPREFIX=~/.wine32 firejail --profile=/etc/firejail/wine32.profile winecfg"'
    'alias myip="echo -e \"IPv4: \$(curl -s -4 icanhazip.com)\nIPv6: \$(curl -s -6 icanhazip.com)\" && curl -s http://ip-api.com/json/ | jq '\''{isp, org, city, regionName, country, zip, timezone, lat, lon}'\''"'
    'alias newip="nmcli connection down wgcf-profile 2>/dev/null; nmcli connection delete wgcf-profile 2>/dev/null; rm -f wgcf-account.toml wgcf-profile.conf && wgcf register --accept-tos && wgcf generate && nmcli connection import type wireguard file wgcf-profile.conf && nmcli connection up wgcf-profile"'
)

# Put ZSH-specific functions/bindings here
read -r -d '' shell_func_config_zsh << 'EOF' || true
# Example: custom ZSH functions/bindings can go here
EOF

# Open Bash temporarily for pasting Bash/Zsh-style commands
read -r -d '' fish_bp_function << 'EOF' || true
function bp --description 'Open Bash for pasting Bash commands'
    bash
end
EOF

# Detect Bash-only syntax before Fish parses the command entered by the user
read -r -d '' fish_bash_enter_fallback_function << 'EOF' || true
function __bash_fallback_execute
    # Let Fish accept pager/search selections without applying or executing the Bash fallback
    if commandline --paging-mode; or commandline --search-mode
        commandline -f execute
        return
    end

    set -l commandline_text (commandline | string collect)
    set -l use_bash 0

    if string match -rq '<\([^)]+\)' -- "$commandline_text"
        set use_bash 1
    else if string match -rq '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=' -- "$commandline_text"; and not fish -n -c "$commandline_text" 2>/dev/null
        set use_bash 1
    end

    if test "$use_bash" -eq 1
        if bash -n -c "$commandline_text"
            set -l escaped_command (string escape -- "$commandline_text")
            commandline --replace "bash -c $escaped_command"
        end
    end

    commandline -f execute
end
EOF

# Retry Bash-style variable-assignment commands in a temporary Bash process
read -r -d '' fish_bash_fallback_function << 'EOF' || true
function __bash_fallback --on-event fish_posterror
    set -l commandline_text $argv[1]

    if string match -rq '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=' -- "$commandline_text"
        if bash -n -c "$commandline_text"
            bash -c "$commandline_text"
        end
    end
end
EOF

# Put FISH-specific functions/bindings here
read -r -d '' shell_func_config_fish << 'EOF' || true
function fish_user_key_bindings
    # Run recognized Bash syntax through a temporary Bash process before Fish parses it
    bind enter __bash_fallback_execute

    # Make Ctrl+C behave like Zsh (keep canceled command visible, print ^C, and start a new line)
    bind \cc 'echo -n "^C"; echo; commandline ""; commandline -f repaint'

    # Make Ctrl+Backspace delete path components (stopping at slashes, spaces, and punctuation)
    bind ctrl-backspace backward-kill-path-component
    bind ctrl-h backward-kill-path-component

    # Make Ctrl+Left/Right move by path components (stopping at slashes, spaces, and punctuation)
    bind ctrl-left backward-path-component
    bind ctrl-right forward-path-component
end
EOF

# ZRAM configuration (generator settings)
zram_config=(
    # Use 'ram' for 100% or 'ram / 2' for 50%.
    # On 6GB RAM, 100% is recommended for better multitasking.
    '[zram0]'
    'compression-algorithm = %ALGO%'
    'zram-size = ram'
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

# Groups to add the current user to after installation (group must exist on the system)
user_groups=(
    zerotier-one  # for zerotier-gui to work
)

# Fix ZeroTier-Gui:
# sudo chown -R root:zerotier-one /var/lib/zerotier-one
# sudo chmod 660 /var/lib/zerotier-one/authtoken.secret
# newgrp zerotier-one (this one only if u haven't rebooted after adding username to zerotier group, albeit it will only work the current shel so im not sure if this would work properly). Use "id" command to see if u are already on zerotier group

# Custom repositories to configure in /etc/pacman.conf
# Format: "name|mirrorlist_path|keyring_pkg|mirrorlist_pkg|key_id|keyserver|keyring_url|mirrorlist_url"
# - mirrorlist_path: the actual path used in the pacman.conf Include directive
# - key_id + keyserver: used for pacman-key --recv-key / --lsign-key
# - keyring_url / mirrorlist_url: remote .pkg.tar.zst to install via pacman -U

# Leave a field empty (but keep the |) if not needed.
custom_repos=(
    "chaotic-aur|/etc/pacman.d/chaotic-mirrorlist|chaotic-keyring|chaotic-mirrorlist|3056513887B78AEB|keyserver.ubuntu.com|https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst|https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"
)


### SOURCE CODE ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- SOURCE CODE ###

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

# Helper: prompt y/n with consistent lowercase handling
# Usage: if confirm "prompt text"; then ...
confirm() {
    local choice
    echo -ne "$1 (y/n): "
    read choice
    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
    [[ "$choice" == "y" || "$choice" == "yes" ]]
}

# Helper: join array elements with ", "
# Usage: join_list "${array[@]}"
join_list() {
    local result=""
    for item in "$@"; do
        if [ -z "$result" ]; then
            result="$item"
        else
            result="$result, $item"
        fi
    done
    echo "$result"
}

# Helper: install packages from an array (handles both AUR and official via yay)
# All queries use pacman -Qq (local db only)
# Usage: install_pkg_list "${array[@]}"
install_pkg_list() {
    for pkg in "$@"; do
        if pacman -Qq "$pkg" > /dev/null 2>&1; then
            echo -e "$pkg ${GREEN}is already installed.${NC}"
        else
            echo "$pkg is not installed. Installing..."
            yay -Sy --noconfirm "$pkg"
        fi
    done
}

# Helper: add user to groups that exist on the system
add_user_groups() {
    if [ ${#user_groups[@]} -eq 0 ]; then
        return
    fi

    echo
    echo -e "${BLUE}Do you want to add your user to the following groups?${NC}"
    echo -e "It will add you to: ${ORANGE}$(join_list "${user_groups[@]}")${NC}"
    if confirm ""; then
        local current_user
        current_user=$(whoami)

        for group in "${user_groups[@]}"; do
            if getent group "$group" > /dev/null 2>&1; then
                if id -nG "$current_user" | grep -qw "$group"; then
                    echo -e "${GREEN}User $current_user is already in group $group.${NC}"
                else
                    sudo usermod -aG "$group" "$current_user"
                    echo -e "${GREEN}Added $current_user to group $group.${NC}"
                fi
            else
                echo -e "${YELLOW}Group $group does not exist on this system, skipping...${NC}"
            fi
        done
    else
        echo "Skipping user group configuration..."
    fi
}

logo() {
    local art=(
        '__________               __    .___                 __         .__  .__   '
        '\______   \____  _______/  |_  |   | ____   _______/  |______  |  | |  | '
        ' |     ___/  _ \/  ___/\   __\ |   |/    \ /  ___/\   __\__  \ |  | |  | '
        ' |    |  (  <_> )___ \  |  |   |   |   |  \\___ \  |  |  / __ \|  |_|  |__'
        ' |____|   \____/____  > |__|   |___|___|  /____  > |__| (____  /____/____/'
        '                    \/                  \/     \/            \/           '
        '                                                                           '
        '          ___.             _________ __         .__ __                    '
        '          \_ |__ ___.__.  /   _____//  |________|__|  | __ ___________    '
        '  ______   | __ <   |  |  \_____  \\   __\_  __ \  |  |/ // __ \_  __ \  '
        ' /_____/   | \_\ \___  |  /        \|  |  |  | \/  |    <\  ___/|  | \/  '
        '           |___  / ____| /_______  /|__|  |__|  |__|__|_ \\___  >__|      '
        '               \/\/              \/                     \/    \/          '
    )

    local rainbow=(
        '\033[31m'   # red
        '\033[33m'   # yellow
        '\033[32m'   # green
        '\033[36m'   # cyan
        '\033[34m'   # blue
        '\033[35m'   # magenta
    )
    local nc='\033[0m'
    local bold='\033[1m'
    local n=${#rainbow[@]}

    # Find max art line length
    local max_w=0
    for line in "${art[@]}"; do
        (( ${#line} > max_w )) && max_w=${#line}
    done

    # Meta line: version + author
    local meta="  ver ${iteration}  |  github.com/BrandowLucas  "
    (( ${#meta} > max_w )) && max_w=${#meta}

    local inner=$(( max_w + 2 ))  # 1 space padding each side

    # Build border string
    local border="+"
    for ((i=0; i<inner; i++)); do border+="-"; done
    border+="+"

    local ci=0

    printf "${bold}${rainbow[$ci]}%s${nc}\n" "$border";  ci=$(( (ci+1) % n ))
    printf "${rainbow[$ci]}| %-${max_w}s |${nc}\n" "";   ci=$(( (ci+1) % n ))

    for line in "${art[@]}"; do
        printf "${rainbow[$ci]}| %-${max_w}s |${nc}\n" "$line"
        ci=$(( (ci+1) % n ))
    done

    printf "${rainbow[$ci]}| %-${max_w}s |${nc}\n" "";   ci=$(( (ci+1) % n ))
    printf "${bold}${rainbow[$ci]}| %-${max_w}s |${nc}\n" "$meta"; ci=$(( (ci+1) % n ))
    printf "${rainbow[$ci]}| %-${max_w}s |${nc}\n" "";   ci=$(( (ci+1) % n ))

    printf "${bold}${rainbow[$ci]}%s${nc}\n\n" "$border"
}

update_mirrorlist() {
    echo
    if confirm "${BLUE}Do you want to update mirrorlist${RED} (recommended at least once)${NC}?"; then
        local temp_file
        temp_file=$(mktemp)

        # Check if we're running Manjaro
        if grep -q "Manjaro" /etc/os-release; then
            echo -e "${YELLOW}You are running Manjaro, updating mirrorlist using pacman-mirrors, please wait... ${NC}"
            sudo pacman-mirrors --fasttrack
            echo -e "${GREEN}Updated Manjaro mirrorlist.${NC}"
        else
            # Otherwise, update Arch/EndeavourOS mirrors
            echo -e "${YELLOW}Updating Arch Linux repositories, please wait... ${NC}"
            reflector --verbose -c "$countries" --protocol https --sort rate --latest 10 --download-timeout 3 --threads 5 --save "$temp_file"

            sudo cp "$temp_file" /etc/pacman.d/mirrorlist

            rm "$temp_file"

            echo -e "${GREEN}Updated /etc/pacman.d/mirrorlist with the top 10 Arch Linux mirrors in $countries.${NC}"

            if grep -q "EndeavourOS" /etc/os-release; then
                echo -e "${YELLOW}Updating EndeavourOS repositories, please wait... ${NC}"
                eos-rankmirrors --sort rate -t 3 --list-only
                echo -e "${GREEN}Updated /etc/pacman.d/endeavouros-mirrorlist with top fastest EOS mirrors${NC}"
            fi
        fi

        yay -Sy
    else
        echo "Skipping mirrorlist update..."
    fi
}

updatesys() {
    echo
    if confirm "${BLUE}Do you want to update your system${RED} (Highly advised after install — skipping may break the system)${NC}?"; then
        echo "Installing archlinux-keyring..."
        yay -Sy --noconfirm archlinux-keyring

        # Update system
        echo "Updating system..."
        yay -Syu --noconfirm
    else
        echo "Skipping system update..."
    fi
}

# Generic function to configure a custom repo from the custom_repos array
# Format: "name|mirrorlist_path|keyring_pkg|mirrorlist_pkg|key_id|keyserver|keyring_url|mirrorlist_url"
configure_repo() {
    local entry="$1"
    local name mirrorlist_path keyring_pkg mirrorlist_pkg key_id keyserver keyring_url mirrorlist_url
    IFS='|' read -r name mirrorlist_path keyring_pkg mirrorlist_pkg key_id keyserver keyring_url mirrorlist_url <<< "$entry"

    local escaped_mirrorlist
    escaped_mirrorlist=$(echo "$mirrorlist_path" | sed 's/\//\\\//g')

    echo -e "${YELLOW}Configuring ${name}...${NC}"

    # Comment out existing section temporarily to avoid conflicts during setup
    if grep -q "^\[${name}\]" /etc/pacman.conf; then
        sudo sed -i "s/^\[${name}\]/#\[${name}\]/" /etc/pacman.conf
        sudo sed -i "s/^Include = ${escaped_mirrorlist}/#Include = ${escaped_mirrorlist}/" /etc/pacman.conf
    fi

    # Install keyring
    if ! pacman -Qq "$keyring_pkg" > /dev/null 2>&1; then
        if [[ -n "$key_id" && -n "$keyserver" ]]; then
            sudo pacman-key --init
            sudo pacman-key --recv-key "$key_id" --keyserver "$keyserver"
            sudo pacman-key --lsign-key "$key_id"
        fi
        echo "${keyring_pkg} is not installed. Installing..."
        sudo rm -rf "/etc/pacman.d/${name}"*
        sudo pacman -U --noconfirm "$keyring_url"
    else
        echo -e "${GREEN}${keyring_pkg} is already installed.${NC}"
    fi

    # Install mirrorlist
    if ! pacman -Qq "$mirrorlist_pkg" > /dev/null 2>&1; then
        echo "${mirrorlist_pkg} is not installed. Installing..."
        sudo pacman -U --noconfirm "$mirrorlist_url"
        sudo pacman -Sy
    else
        echo -e "${GREEN}${mirrorlist_pkg} is already installed.${NC}"
    fi

    # Verify mirrorlist is readable
    if [ ! -r "$mirrorlist_path" ]; then
        echo -e "${RED}Error: ${mirrorlist_path} could not be read or does not exist.${NC}"
        return 1
    fi

    # Enable the section in pacman.conf
    if grep -q "^#\[${name}\]" /etc/pacman.conf; then
        sudo sed -i "s/^#\[${name}\]/\[${name}\]/" /etc/pacman.conf
        sudo sed -i "s/^#Include = ${escaped_mirrorlist}/Include = ${escaped_mirrorlist}/" /etc/pacman.conf
        echo -e "${GREEN}${name} section uncommented in /etc/pacman.conf.${NC}"
    elif ! grep -q "\[${name}\]" /etc/pacman.conf; then
        printf "\n[%s]\nInclude = %s\n" "$name" "$mirrorlist_path" | sudo tee -a /etc/pacman.conf > /dev/null
        echo -e "${GREEN}${name} configuration has been added to /etc/pacman.conf.${NC}"
    else
        echo -e "${GREEN}${name} is already configured in /etc/pacman.conf.${NC}"
    fi
}

configure_custom_repos() {
    if [ ${#custom_repos[@]} -eq 0 ]; then
        return
    fi

    echo
    local repo_names=()
    for entry in "${custom_repos[@]}"; do
        repo_names+=("${entry%%|*}")
    done
    echo -e "${BLUE}Do you want to configure custom repositories ${RED}(recommended)${NC}?"
    echo -e "It will configure the following repos: ${ORANGE}$(join_list "${repo_names[@]}")${NC}"
    if confirm ""; then
        for entry in "${custom_repos[@]}"; do
            configure_repo "$entry"
        done
    else
        echo "Skipping custom repository configuration..."
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
    echo -e "0. Skip"

    read -p "Enter your choice [0-2]: " choice

    case "$choice" in
        1)
            if pacman -Qq timeshift &> /dev/null; then
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

            if pacman -Qq btrfs-assistant &> /dev/null; then
                echo -e "${GREEN}Btrfs Assistant is already installed.${NC}"
            else
                echo "Installing Btrfs Assistant..."
                sudo pacman -S --noconfirm btrfs-assistant boost-libs
            fi
            ;;
        0)
            echo "Skipping backup system installation..."
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please enter 0, 1, or 2.${NC}"
            ;;
    esac
}

install_gui_store() {
    echo
    echo -e "${BLUE}Do you want to install a GUI store/package manager?${NC}"
    echo -e "1) Install ${ORANGE}Pamac${NC} (Native and Flatpak) ${RED}(recommended)${NC}"
    echo -e "2) Install ${ORANGE}Discover${NC} (Flatpak packages only)${NC}"
    echo -e "3) Install ${ORANGE}Octopi${NC} (Native packages only)${NC}"
    echo -e "0) Skip"
    read -p "Please choose an option (0-3): " choice

    case "$choice" in
        1)
            if ! pacman -Qq pamac-flatpak &>/dev/null; then
                echo "Installing Pamac..."
                yay -Sy --noconfirm pamac-flatpak
            else
                echo -e "${GREEN}Pamac is already installed.${NC}"
            fi
            ;;
        2)
            if ! pacman -Qq discover &>/dev/null; then
                echo "Installing Discover..."
                sudo pacman -Sy --noconfirm discover
            else
                echo -e "${GREEN}Discover is already installed.${NC}"
            fi
            ;;
        3)
            if ! pacman -Qq octopi &>/dev/null; then
                echo "Installing Octopi..."
                yay -Sy --noconfirm octopi
            else
                echo -e "${GREEN}Octopi is already installed.${NC}"
            fi
            ;;
        0)
            echo "Skipping GUI store installation..."
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please select 0-3.${NC}"
            return 1
            ;;
    esac
}

# Function to install other software
install_other_software() {
    echo
    echo -e "${BLUE}Do you want to install other software?${NC}"
    echo -e "It will install the following packages: ${ORANGE}$(join_list "${packages[@]}")${NC}"
    if confirm ""; then
        install_pkg_list "${packages[@]}"
    else
        echo "Skipping installation of other software..."
    fi
}

install_flatpak_apps() {
    echo
    echo -e "${BLUE}Do you want to install Flatpak applications?${NC}"
    echo -e "It will install the following flatpak apps: ${ORANGE}$(join_list "${flatpak_apps[@]}")${NC}"
    if confirm ""; then
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
    echo -e "${BLUE}Do you want to install programming/debugging software?${NC}"
    echo -e "It will install the following packages: ${ORANGE}$(join_list "${prog_packages[@]}")${NC}"
    if confirm ""; then
        install_pkg_list "${prog_packages[@]}"
    else
        echo "Skipping programming software installation..."
    fi
}

install_network_tools() {
    echo
    echo -e "${BLUE}Do you want to install network/pentest tools?${NC}"
    echo -e "It will install the following packages: ${ORANGE}$(join_list "${pentest_packages[@]}")${NC}"
    if confirm ""; then
        install_pkg_list "${pentest_packages[@]}"
    else
        echo "Skipping network/pentest tools installation..."
    fi
}

install_gaming_deps() {
    echo
    echo -e "${BLUE}Do you want to install gaming dependencies?${NC}"
    echo -e "It will install the following packages: ${ORANGE}$(join_list "${gaming_packages[@]}")${NC}"
    if confirm ""; then
        install_pkg_list "${gaming_packages[@]}"
    else
        echo "Skipping gaming dependencies installation..."
    fi
}

choose_driver_installation() {
    # Sub-function to install RADV drivers
    install_radv_drivers() {
        local radv_packages=(
            "vulkan-radeon" "lib32-vulkan-radeon"
        )
        install_pkg_list "${radv_packages[@]}"
    }

    # Sub-function to install NVIDIA drivers
    install_nvidia_drivers() {
        local nvidia_packages=(
            "nvidia-utils" "lib32-nvidia-utils" "nvidia" "nvidia-dkms" "nvidia-settings"
        )
        install_pkg_list "${nvidia_packages[@]}"
    }

    echo
    echo -e "${BLUE}Which drivers do you want to install? ${NC}"
    echo -e "1. ${RED}RADV AMD drivers${NC}"
    echo -e "2. ${LIGHT_GREEN}NVIDIA Proprietary ${NC}drivers"
    echo -e "3. Both ${RED}RADV ${NC}and ${LIGHT_GREEN}NVIDIA ${NC}drivers"
    echo -e "0. Skip"

    read -p "Please choose an option (0-3): " choice
    case "$choice" in
        1) install_radv_drivers ;;
        2) install_nvidia_drivers ;;
        3) install_radv_drivers; install_nvidia_drivers ;;
        0) echo "Skipping driver installation..." ;;
        *) echo -e "${YELLOW}Invalid choice. Please enter a number between 0 and 3.${NC}" ;;
    esac
}

install_shell() {

    # Sub-function to install and configure ZSH
    install_zsh() {
        if ! pacman -Qq zsh > /dev/null 2>&1; then
            echo "Installing ZSH..."
            sudo pacman -Sy --noconfirm zsh
        else
            echo -e "ZSH ${GREEN}is already installed.${NC}"
        fi

        if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
            echo "Installing Oh My Zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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
            if ! grep -qF "$setting" "$ZSH_CONFIG_FILE"; then
                echo "$setting" >> "$ZSH_CONFIG_FILE"
            fi
        done

        # Add shell_func_config_zsh to .zshrc
        if [[ -n "$shell_func_config_zsh" ]]; then
            if ! grep -q "# Added by Post-Install-Script (Zsh functions)" "$ZSH_CONFIG_FILE"; then
                echo -e "\n# Added by Post-Install-Script (Zsh functions)" >> "$ZSH_CONFIG_FILE"
                echo "$shell_func_config_zsh" >> "$ZSH_CONFIG_FILE"
            fi
        fi

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
        if ! pacman -Qq fzf > /dev/null 2>&1; then
            echo "Installing fzf..."
            sudo pacman -Sy --noconfirm fzf
        else
            echo -e "fzf ${GREEN}is already installed.${NC}"
        fi

        # Install query-aware history ranking for Ctrl-R.
        mkdir -p "$HOME/.local/bin"
        cat << 'EOF' > "$HOME/.local/bin/zsh-history-candidates"
#!/usr/bin/env python3
import os
import re
import shlex
import sys
from dataclasses import dataclass
from pathlib import Path


HISTORY_PATH = Path.home() / ".zsh_history"
OPERATORS = {"&&", "||", "|", ";", "&"}


@dataclass(frozen=True)
class SearchTerm:
    text: str
    raw_text: str
    role_rank: int
    source_rank: int


def query_parts(query: str) -> list[str]:
    return [part for part in re.findall(r"[a-z0-9]+", query.lower()) if part]


def parts_in_order(parts: list[str], text: str) -> int | None:
    search_start = 0
    first_index: int | None = None
    for part in parts:
        index = text.find(part, search_start)
        if index < 0:
            return None
        if first_index is None:
            first_index = index
        search_start = index + len(part)
    return first_index


def segment_start_index(text: str, query: str) -> int | None:
    match = re.search(rf"(^|[^a-z0-9]){re.escape(query)}", text)
    if match is None:
        return None
    return match.start() + (0 if match.group(1) == "" else 1)


def is_assignment(token: str) -> bool:
    return re.match(r"^[A-Za-z_][A-Za-z0-9_]*=.*$", token) is not None


def is_url_like(token: str) -> bool:
    return "://" in token or token.startswith("git@")


def split_command(command: str) -> list[str]:
    try:
        tokens = shlex.split(command, posix=True)
    except ValueError:
        tokens = re.split(r"\s+", command.strip())
    return [token.rstrip("\\").strip() for token in tokens if token.rstrip("\\").strip()]


def primary_token_index(tokens: list[str]) -> int | None:
    for index, token in enumerate(tokens):
        if token in OPERATORS:
            continue
        if is_assignment(token):
            continue
        return index
    return None


def build_terms(command: str) -> list[SearchTerm]:
    tokens = split_command(command)
    primary_index = primary_token_index(tokens)
    terms: list[SearchTerm] = []
    seen: set[tuple[str, int, int]] = set()

    for index, token in enumerate(tokens):
        if token in OPERATORS:
            continue

        role_rank = 2
        if primary_index is not None and index < primary_index and is_assignment(token):
            role_rank = 0
        elif primary_index is not None and index == primary_index:
            role_rank = 0
        elif "/" in token:
            role_rank = 1

        candidates = [(token.lower(), token, 1, role_rank)]
        if "/" in token:
            basename_raw = os.path.basename(token)
            basename = basename_raw.lower()
            if basename:
                basename_role = 2 if is_url_like(token) else 0
                candidates.append((basename, basename_raw, 0, basename_role))

        for text, raw_text, source_rank, candidate_role in candidates:
            key = (text, candidate_role, source_rank)
            if key in seen:
                continue
            seen.add(key)
            terms.append(SearchTerm(text=text, raw_text=raw_text, role_rank=candidate_role, source_rank=source_rank))

    return terms


def match_term(query: str, parts: list[str], term: SearchTerm) -> tuple[int, int, int, int, int, int] | None:
    text = term.text
    raw_text = term.raw_text
    has_uppercase_query = any(character.isupper() for character in query)

    if has_uppercase_query and raw_text == query:
        return (0, 0, term.role_rank, 0, term.source_rank, len(text))

    if has_uppercase_query and raw_text.startswith(query):
        return (1, 0, term.role_rank, 0, term.source_rank, len(text))

    if has_uppercase_query and "." in query and raw_text.endswith(query):
        return (2, 0, term.role_rank, 0, term.source_rank, len(text))

    raw_segment_index = segment_start_index(raw_text, query)
    if has_uppercase_query and raw_segment_index is not None:
        return (3, 0, term.role_rank, raw_segment_index, term.source_rank, len(text))

    raw_substring_index = raw_text.find(query)
    if has_uppercase_query and raw_substring_index >= 0:
        return (4, 0, term.role_rank, raw_substring_index, term.source_rank, len(text))

    if text == query:
        return (0, 1, term.role_rank, 0, term.source_rank, len(text))

    if text.startswith(query):
        return (1, 1, term.role_rank, 0, term.source_rank, len(text))

    if "." in query and text.endswith(query):
        return (2, 1, term.role_rank, 0, term.source_rank, len(text))

    segment_index = segment_start_index(text, query)
    if segment_index is not None:
        return (3, 1, term.role_rank, segment_index, term.source_rank, len(text))

    substring_index = text.find(query)
    if substring_index >= 0:
        return (4, 1, term.role_rank, substring_index, term.source_rank, len(text))

    ordered_index = parts_in_order(parts, text)
    if ordered_index is not None:
        return (5, 1, term.role_rank, ordered_index, term.source_rank, len(text))

    return None


def command_rank(query: str, command: str, recency_index: int) -> tuple[int, int, int, int, int, int, int, int] | None:
    if not query:
        return (9, 9, 9, 9, 9, len(command), recency_index)

    lowered_parts = query_parts(query)
    best_match: tuple[int, int, int, int, int, int] | None = None

    for term in build_terms(command):
        match = match_term(query, lowered_parts, term)
        if match is None:
            continue
        if best_match is None or match < best_match:
            best_match = match

    if best_match is None:
        return None

    return (recency_index, best_match[0], best_match[1], best_match[2], best_match[3], best_match[4], best_match[5], len(command))


def load_unique_history() -> list[str]:
    if not HISTORY_PATH.exists():
        return []

    with HISTORY_PATH.open("r", encoding="utf-8", errors="ignore") as history_file:
        commands = []
        for line in history_file:
            parts = line.rstrip("\n").split(";", 1)
            if len(parts) != 2:
                continue
            commands.append(parts[1])

    unique_commands: list[str] = []
    seen: set[str] = set()
    for command in reversed(commands):
        if command in seen:
            continue
        seen.add(command)
        unique_commands.append(command)

    return unique_commands


def main() -> int:
    query = (sys.argv[1] if len(sys.argv) > 1 else "").strip()
    history_commands = load_unique_history()

    if not query:
        for command in history_commands:
            print(command)
        return 0

    ranked_commands: list[tuple[tuple[int, int, int, int, int, int, int, int], str]] = []
    for recency_index, command in enumerate(history_commands):
        rank = command_rank(query, command, recency_index)
        if rank is None:
            continue
        ranked_commands.append((rank, command))

    ranked_commands.sort()
    for _, command in ranked_commands:
        print(command)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
EOF
        chmod +x "$HOME/.local/bin/zsh-history-candidates"

        # Configure Ctrl-R history search with query-aware ranking.
        sed -i '/^export FZF_DEFAULT_OPTS=/d' "$ZSH_CONFIG_FILE"
        sed -i '/^export FZF_CTRL_R_OPTS=/d' "$ZSH_CONFIG_FILE"
        sed -i '/^bindkey '\''\^R'\'' fzf-history-widget$/d' "$ZSH_CONFIG_FILE"
        sed -i '/^bindkey '\''\^R'\'' customFzfHistoryWidget$/d' "$ZSH_CONFIG_FILE"
        sed -i '/^zle -N customFzfHistoryWidget$/d' "$ZSH_CONFIG_FILE"
        sed -i '/^customFzfHistoryWidget() {$/,/^}$/d' "$ZSH_CONFIG_FILE"

        if ! grep -q '^source /usr/share/fzf/key-bindings.zsh$' "$ZSH_CONFIG_FILE"; then
            cat << 'EOF' >> "$ZSH_CONFIG_FILE"
source /usr/share/fzf/key-bindings.zsh
EOF
        fi

        cat << 'EOF' >> "$ZSH_CONFIG_FILE"
export FZF_CTRL_R_OPTS="--height 40% --reverse --border --bind 'ctrl-r:toggle-sort,ctrl-y:accept'"

customFzfHistoryWidget() {
    local selected=""
    local query="$LBUFFER"
    local -a fzfCmd
    fzfCmd=(${(z)$(__fzfcmd)})
    selected="$(
        ~/.local/bin/zsh-history-candidates "$query" |
            FZF_DEFAULT_OPTS='' \
            FZF_DEFAULT_OPTS_FILE='' \
            "${fzfCmd[@]}" \
                --height 40% \
                --reverse \
                --border \
                --no-sort \
                --disabled \
                --query="$query" \
                --bind "start:reload:$HOME/.local/bin/zsh-history-candidates {q}" \
                --bind "change:reload:$HOME/.local/bin/zsh-history-candidates {q} || true" \
                --bind "ctrl-r:toggle-sort,ctrl-y:accept" \
                --preview 'printf "%s\n" {}'
    )"

    local result=$?
    if [[ -n "$selected" ]]; then
        LBUFFER="$selected"
    fi

    zle reset-prompt
    return $result
}

zle -N customFzfHistoryWidget
bindkey '^R' customFzfHistoryWidget
EOF

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
        if pacman -Qq fish > /dev/null 2>&1; then
            echo -e "${GREEN}FISH is already installed.${NC}"
        else
            echo "Installing FISH..."
            sudo pacman -Sy --noconfirm fish || { echo "Failed to install FISH"; return 1; }
        fi

        # Check if starship is installed
        if pacman -Qq starship > /dev/null 2>&1; then
            echo -e "${GREEN}Starship is already installed.${NC}"
        else
            echo "Installing Starship..."
            sudo pacman -Sy --noconfirm archlinux-keyring starship || { echo "Failed to install Starship"; return 1; }
        fi

        # Check and set default shell
        if [[ "$SHELL" != "$(which fish)" ]]; then
            echo "Changing the default shell to FISH..."
            chsh -s "$(which fish)" || { echo "Failed to change shell"; return 1; }
        else
            echo -e "${GREEN}FISH is already the default shell.${NC}"
        fi

        FISH_CONFIG_FILE="$HOME/.config/fish/config.fish"

        # Create fish config directory
        mkdir -p "$HOME/.config/fish" || { echo "Failed to create fish config directory"; return 1; }

        # Check if Starship initialization line exists
        if ! grep -qF "starship init fish | source" "$FISH_CONFIG_FILE"; then
            echo "starship init fish | source" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Starship"; return 1; }
        fi

        # Add shell_config to config.fish
        for setting in "${shell_config[@]}"; do
            if ! grep -qF "$setting" "$FISH_CONFIG_FILE"; then
                echo "$setting" >> "$FISH_CONFIG_FILE" || { echo "Failed to add setting to config.fish"; return 1; }
            fi
        done

        # Add the Bash paste shortcut to config.fish
        if ! grep -qF "function bp --description 'Open Bash for pasting Bash commands'" "$FISH_CONFIG_FILE"; then
            echo -e "\n$fish_bp_function" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Fish Bash paste shortcut"; return 1; }
        fi

        # Add Enter-time Bash syntax detection to config.fish
        if ! grep -qF "function __bash_fallback_execute" "$FISH_CONFIG_FILE"; then
            echo -e "\n$fish_bash_enter_fallback_function" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Fish Bash syntax detection"; return 1; }
        fi

        # Add the automatic Bash syntax fallback to config.fish
        if ! grep -qF "function __bash_fallback --on-event fish_posterror" "$FISH_CONFIG_FILE"; then
            echo -e "\n$fish_bash_fallback_function" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Fish Bash syntax fallback"; return 1; }
        fi

        # Add shell_func_config_fish to config.fish
        if [[ -n "$shell_func_config_fish" ]]; then
            if ! grep -q "function fish_user_key_bindings" "$FISH_CONFIG_FILE"; then
                echo -e "\n$shell_func_config_fish" >> "$FISH_CONFIG_FILE" || { echo "Failed to configure Fish keybindings"; return 1; }
            fi
        fi

        # Add the Bash fallback binding to an existing fish_user_key_bindings function
        if ! grep -qF "bind enter __bash_fallback_execute" "$FISH_CONFIG_FILE"; then
            sed -i "/^function fish_user_key_bindings$/a\\    # Run recognized Bash syntax through a temporary Bash process before Fish parses it\\n    bind enter __bash_fallback_execute\\n" "$FISH_CONFIG_FILE" || { echo "Failed to bind Fish Bash syntax detection"; return 1; }
        fi

        # Configure Starship
        echo "Configuring Starship..."
        starship preset gruvbox-rainbow -o ~/.config/starship.toml || { echo "Failed to configure Starship"; return 1; }

        echo -e "${GREEN}FISH installation and configuration complete.${NC}"
    }

    echo
    echo -e "${BLUE}Do you want to install and configure ${NC}ZSH ${BLUE}or ${NC}FISH ${BLUE}shell${NC}?"
    echo -e "1. ${ORANGE}ZSH${NC}"
    echo -e "2. ${ORANGE}FISH${NC}"
    echo -e "0. Skip"

    read -p "Please choose an option (0-2): " choice

    case "$choice" in
        1) install_zsh ;;
        2) install_fish ;;
        0) echo "Skipping shell installation..." ;;
        *) echo -e "${YELLOW}Invalid choice. Please choose 0, 1, or 2.${NC}" ;;
    esac
}

alacritty() {
    echo
    if confirm "${BLUE}Do you want to install and configure Alacritty?${NC}"; then
        if pacman -Qq alacritty > /dev/null 2>&1; then
            echo -e "alacritty ${GREEN}is already installed.${NC}"
        else
            echo "alacritty is not installed. Installing..."
            sudo pacman -Sy --noconfirm alacritty
        fi
        mkdir -p "$HOME/.config/alacritty/"
        cat << 'EOF' > "$HOME/.config/alacritty/alacritty.toml"
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
EOF
        echo -e "${GREEN}Alacritty successfully configured.${NC}"
    else
        echo "Skipping Alacritty installation..."
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

    if ! pacman -Qq zram-generator > /dev/null 2>&1; then
        sudo pacman -Sy --noconfirm zram-generator
    fi

    # Write generator configuration
    printf "%s\n" "${zram_config[@]}" | sed "s/%ALGO%/$compression_algo/g" | sudo tee "$generator_path" > /dev/null

    # Write sysctl/udev configuration
    printf "%s\n" "${par_config[@]}" | sudo tee "$params_path" > /dev/null

    if grep -q "cachyos" /etc/os-release; then
        echo -e "${YELLOW}Applying ZRAM changes...${NC}"
        sudo systemctl unmask systemd-zram-setup@zram0.service
        sudo systemctl disable --now systemd-zram-setup@zram0.service
        sudo systemctl enable --now systemd-zram-setup@zram0.service
    fi

    echo -e "${GREEN}ZRAM configuration completed.${NC}"

# Troubleshoot: journalctl -xe | grep zram
}

# Function to update GRUB with ZSWAP parameters
enable_grub_zswap() {
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
enable_systemdboot_zswap() {
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
        sudo kernel-install add "$(uname -r)" "/boot/vmlinuz-$(uname -r)"
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
        echo "/swapfile                                 none           swap    defaults  0 0" | sudo tee -a /etc/fstab
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
        sudo kernel-install add "$(uname -r)" "/boot/vmlinuz-$(uname -r)"
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
        sudo systemctl mask systemd-zram-setup@zram0.service
        # called on line z_memory "2)" choice
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
    echo -e "0) Skip"
    read -p "Please choose an option (0-2): " choice

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

            # Disable and remove the swapfile now that we have a confirmed choice
            if sudo swapon --show=NAME | grep -q '/swapfile'; then
                echo "Swapfile detected. Removing..."
                sudo swapoff /swapfile
                sudo rm /swapfile
                sudo sed -i '/\/swapfile/d' /etc/fstab
                echo "Swapfile removed."
            fi

            # Update bootloader with Zswap parameters
            if [ -f /etc/kernel/cmdline ]; then
                enable_systemdboot_zswap "$zswap_compressor"
                configure_swap
            elif [ -f /etc/default/grub ]; then
                enable_grub_zswap "$zswap_compressor"
                configure_swap
            else
                echo -e "${RED}Neither /etc/kernel/cmdline nor /etc/default/grub found. Skipping bootloader update...${NC}"
            fi
            ;;
        0)
            echo "Skipping memory configuration..."
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please select 0, 1, or 2.${NC}"
            return 1
            ;;
    esac

    case "$choice" in
        1)
            # Poll up to 5s for systemd to activate the zram device
            local i
            for i in 1 2 3 4 5; do
                grep -q '/dev/zram' /proc/swaps 2>/dev/null && break
                sleep 1
            done
            if grep -q '/dev/zram' /proc/swaps 2>/dev/null; then
                echo -e "${GREEN}ZRAM is active, no need to reboot.${NC}"
            else
                echo -e "${YELLOW}ZRAM is not active yet, please reboot to apply changes.${NC}"
            fi
            ;;
        2)
            local zswap_enabled
            zswap_enabled=$(cat /sys/module/zswap/parameters/enabled 2>/dev/null)
            if [[ "$zswap_enabled" == "Y" ]]; then
                echo -e "${GREEN}Zswap is enabled, no need to reboot your system.${NC}"
            else
                echo -e "${YELLOW}Zswap is not enabled, please reboot the system to enable it.${NC}"
            fi
            ;;
    esac
}

remove_debounce() {
    echo
    if confirm "${BLUE}Do you want to remove debounce/double click prevention ${RED}(recommended)${NC}?"; then
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
    echo -e "It will enable the following services: ${ORANGE}$(join_list "${services[@]}")${NC}"
    if confirm ""; then
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
    echo -e "${BLUE}Do you want to remove these packages?${NC}"
    echo -e "It will remove the following packages: ${RED}$(join_list "${remove_packages[@]}")${NC}"
    if confirm ""; then
        for pkg in "${remove_packages[@]}"; do
            if pacman -Qq "$pkg" > /dev/null 2>&1; then
                echo "$pkg is installed. Removing..."
                sudo pacman -R --noconfirm "$pkg"
            else
                echo "$pkg is not installed. Nothing to do."
            fi
        done
    else
        echo "Skipping package removal..."
    fi
}

configure_printer() {
    echo
    if confirm "${BLUE}Do you want to enable printer support?${NC}"; then
        # Enable scan support
        local scan_packages=("iscan" "iscan-data") # "iscan-plugin-network"
        install_pkg_list "${scan_packages[@]}"

        # Enable printing support
        local print_packages=("cups" "system-config-printer") # "epson-inkjet-printer-201101w"
        install_pkg_list "${print_packages[@]}"

        # Enable and start the CUPS service
        sudo systemctl enable --now cups
        echo -e "${GREEN}CUPS service has been enabled and started.${NC}"

        # Source of download for Epson: https://download.ebz.epson.net/dsc/search/01/search/
    else
        echo "Skipping printer configuration..."
    fi
}

# Function to enable user theme (most likely dark theme) into root
darkmode_on_root() {
    echo
    if confirm "${BLUE}Do you want to enable user theme into root${NC}?"; then
        yay -Sy konsave
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
    if confirm ""; then
        if [ -d "/boot/grub" ]; then
            echo "GRUB detected."
            local grub_packages=("grub-customizer" "grub-btrfs")
            install_pkg_list "${grub_packages[@]}"
            sudo update-grub
        elif [ -f "/etc/kernel/cmdline" ]; then
            echo "systemd-boot detected. No action needed."
        else
            echo -e "${RED}Unknown bootloader. No action taken.${NC}"
        fi
    else
        echo "Skipping grub configuration..."
    fi
}


waydroid() {
    echo
    if ! confirm "${BLUE}Do you want to install and configure Waydroid${NC}?"; then
        echo -e "Skipping Waydroid installation and configuration..."
        return
    fi

    # Lock file to prevent multiple instances
    local LOCK_FILE="/tmp/waydroid_script.lock"
    if [ -f "$LOCK_FILE" ]; then
        echo -e "${RED}Waydroid setup is already running. Exiting.${NC}"
        return 1
    fi
    touch "$LOCK_FILE"

    # Trap to ensure lock file is removed on interrupt
    trap 'echo -e "${RED}Interrupted. Removing lock file...${NC}"; rm -f "$LOCK_FILE"; trap - SIGINT SIGTERM' SIGINT SIGTERM

    echo -e "${BLUE}Starting Waydroid setup...${NC}"

    # Step 1: Install packages
    local waydroid_packages=("waydroid" "waydroid-script-git")
    for pkg in "${waydroid_packages[@]}"; do
        if pacman -Qq "$pkg" > /dev/null 2>&1; then
            echo -e "$pkg ${GREEN}is already installed.${NC}"
        else
            echo -e "$pkg is not installed. Installing..."
            yay -Sy --noconfirm "$pkg"
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to install $pkg.${NC}"
                rm -f "$LOCK_FILE"; trap - SIGINT SIGTERM; return 1
            fi
        fi
    done

    # Step 2: Configure firewall
    if systemctl is-active --quiet firewalld; then
        echo -e "${BLUE}Configuring FirewallD...${NC}"
        if ! sudo firewall-cmd --zone=trusted --query-interface=waydroid0 > /dev/null 2>&1; then
            sudo firewall-cmd --zone=trusted --add-interface=waydroid0 --permanent
            sudo firewall-cmd --reload
            echo -e "${GREEN}FirewallD configured for Waydroid.${NC}"
        else
            echo -e "${GREEN}FirewallD already configured for Waydroid.${NC}"
        fi
    elif sudo ufw status 2>/dev/null | grep -q "active"; then
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

    # Step 3: Enable and start Waydroid service
    if ! systemctl is-enabled --quiet waydroid-container; then
        echo -e "${BLUE}Enabling Waydroid service...${NC}"
        sudo systemctl enable waydroid-container
    else
        echo -e "${GREEN}Waydroid service is already enabled.${NC}"
    fi

    if ! systemctl is-active --quiet waydroid-container; then
        echo -e "${BLUE}Starting Waydroid service...${NC}"
        if ! sudo systemctl start waydroid-container; then
            echo -e "${RED}Failed to start Waydroid service.${NC}"
            rm -f "$LOCK_FILE"; trap - SIGINT SIGTERM; return 1
        fi
    else
        echo -e "${GREEN}Waydroid service is already running.${NC}"
    fi

    # Step 4: Start Waydroid session if not already running
    if ! pgrep -f "waydroid session" > /dev/null; then
        echo -e "${BLUE}Starting Waydroid session in the background...${NC}"
        nohup waydroid session start > /dev/null 2>&1 &
        sleep 2
    else
        echo -e "${GREEN}Waydroid session is already running.${NC}"
    fi

    # Step 5: Initialize — ask only now that services are running
    echo
    echo -e "${BLUE}Checking Waydroid initialization status...${NC}"
    if ! sudo waydroid status 2>/dev/null | grep -q "RUNNING"; then
        echo -e "${YELLOW}Waydroid is not initialized. Initializing now...${NC}"
        if ! sudo waydroid init -f -s GAPPS; then
            echo -e "${RED}Failed to initialize Waydroid.${NC}"
            rm -f "$LOCK_FILE"; trap - SIGINT SIGTERM; return 1
        fi
        echo -e "${GREEN}Waydroid initialized successfully.${NC}"
    else
        echo -e "${GREEN}Waydroid is already initialized.${NC}"
        if confirm "${BLUE}Do you want to reinitialize Waydroid${NC}?"; then
            echo -e "${YELLOW}Forcing Waydroid reinitialization...${NC}"
            if ! sudo waydroid init -f -s GAPPS; then
                echo -e "${RED}Failed to reinitialize Waydroid.${NC}"
                rm -f "$LOCK_FILE"; trap - SIGINT SIGTERM; return 1
            fi
            echo -e "${GREEN}Waydroid reinitialized successfully.${NC}"
        else
            echo -e "${GREEN}Skipping reinitialization.${NC}"
        fi
    fi

    # Step 6: Display Google registration instructions
    echo
    echo -e "${GREEN}Waydroid setup completed successfully.${NC}"
    echo -e "${YELLOW}Please register your device with Google:${NC}"
    echo -e "1. Run ${ORANGE}sudo waydroid shell${NC} to access the shell."
    echo -e "2. Execute this command to get your Android ID:"
    echo -e "${ORANGE}   ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db \"select * from main where name = \\\"android_id\\\";\"${NC}"
    echo -e "3. Copy the ID and paste it on:${BLUE} https://www.google.com/android/uncertified${NC}"
    echo -e "4. Run the following command upon registration: ${ORANGE}sudo systemctl restart waydroid-container.service${NC}"
    echo -e "5. Run ${ORANGE}waydroid show-full-ui${NC} to open Waydroid GUI."

    rm -f "$LOCK_FILE"
    trap - SIGINT SIGTERM
}

install_firewall() {
    echo
    echo -e "${BLUE}Do you want to install and enable a firewall manager?${NC}"
    echo -e "1) Install ${ORANGE}UFW${NC} (Uncomplicated Firewall) ${RED}(recommended)${NC}"
    echo -e "2) Install ${ORANGE}Firewalld${NC} (Dynamic firewall manager)${NC}"
    echo -e "0) Skip"
    read -p "Please choose an option (0-2): " choice

    case "$choice" in
        1)
            if ! pacman -Qq ufw &>/dev/null; then
                echo "Installing UFW..."
                sudo pacman -Sy --noconfirm ufw
            else
                echo -e "${GREEN}UFW is already installed.${NC}"
            fi
            echo -e "${GREEN}Enabling UFW...${NC}"
            sudo systemctl disable --now firewalld 2>/dev/null
            sudo systemctl enable --now ufw
            ;;
        2)
            if ! pacman -Qq firewalld &>/dev/null; then
                echo "Installing Firewalld..."
                sudo pacman -Sy --noconfirm firewalld
            else
                echo -e "${GREEN}Firewalld is already installed.${NC}"
            fi
            echo -e "${GREEN}Enabling Firewalld...${NC}"
            sudo systemctl disable --now ufw 2>/dev/null
            sudo systemctl enable --now firewalld
            ;;
        0)
            echo "Skipping firewall installation..."
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please choose 0, 1, or 2.${NC}"
            ;;
    esac
}

setup_plymouth() {
    echo
    echo -e "${BLUE}Do you want to configure Plymouth boot splash?${NC}"
    echo -e "1) Choose a default theme"
    echo -e "2) Set a custom theme from AUR (requires a valid theme package input)"
    echo -e "0) Skip"
    read -p "Please choose an option (0-2): " choice

    local theme_changed=false

    case "$choice" in
        1)
            if ! pacman -Qq plymouth &>/dev/null; then
                echo -e "${YELLOW}Installing Plymouth...${NC}"
                sudo pacman -Sy --noconfirm plymouth
                echo -e "${GREEN}Plymouth has been installed.${NC}"
            fi

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
                theme_changed=true
            fi
            ;;
        2)
            # Install Plymouth only now that we know user wants it
            if ! pacman -Qq plymouth &>/dev/null; then
                echo -e "${YELLOW}Installing Plymouth...${NC}"
                sudo pacman -Sy --noconfirm plymouth
                echo -e "${GREEN}Plymouth has been installed.${NC}"
            fi

            echo -e "${ORANGE}Enter the package name for the custom theme (e.g., plymouth-theme-endeavouros):${NC}"
            read -r package_name

            if [[ -z "$package_name" ]]; then
                echo -e "${RED}No package name entered. Skipping custom theme installation...${NC}"
            else
                if pacman -Qq "$package_name" &>/dev/null; then
                    echo -e "${GREEN}Custom theme ${NC}'${package_name}' ${GREEN}is already installed.${NC}"
                else
                    yay -Sy --noconfirm "$package_name"
                    echo -e "${GREEN}Custom theme '${package_name}' has been installed.${NC}"
                fi
                theme_changed=true
            fi
            ;;
        0)
            echo "Skipping Plymouth setup..."
            return
            ;;
        *)
            echo -e "${RED}Invalid choice. Please choose 0, 1, or 2.${NC}"
            return 1
            ;;
    esac

    # Check and update kernel parameters for both bootloaders
    if [ -f /etc/kernel/cmdline ]; then
        if ! grep -q "quiet" /etc/kernel/cmdline || ! grep -q "splash" /etc/kernel/cmdline; then
            echo -e "${BLUE}Updating kernel command line parameters...${NC}"
            # Add only missing parameters
            if ! grep -q "splash" /etc/kernel/cmdline; then
                echo -n " splash" | sudo tee -a /etc/kernel/cmdline > /dev/null
            fi
            if ! grep -q "quiet" /etc/kernel/cmdline; then
                echo -n " quiet" | sudo tee -a /etc/kernel/cmdline > /dev/null
            fi
            echo -e "${GREEN}Kernel parameters updated.${NC}"
        else
            echo -e "${GREEN}Kernel parameters already contain 'splash' and 'quiet'. No changes made.${NC}"
        fi
    elif [ -f /etc/default/grub ]; then
        local grub_line
        grub_line=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub)
        if ! echo "$grub_line" | grep -q "splash" || ! echo "$grub_line" | grep -q "quiet"; then
            echo -e "${BLUE}Updating GRUB kernel parameters...${NC}"
            if ! echo "$grub_line" | grep -q "splash"; then
                sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ splash"/' /etc/default/grub
            fi
            if ! echo "$grub_line" | grep -q "quiet"; then
                sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ quiet"/' /etc/default/grub
            fi
            sudo update-grub > /dev/null 2>&1
            echo -e "${GREEN}GRUB parameters updated.${NC}"
        else
            echo -e "${GREEN}GRUB parameters already contain 'splash' and 'quiet'. No changes made.${NC}"
        fi
    else
        echo -e "${YELLOW}No known bootloader config found. Skipping kernel parameter update.${NC}"
    fi

    # Reinstall kernels to apply changes, only if a theme was changed
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
    fi
}


# Main function to call all other functions
main() {
    logo
    check_and_install_yay

    # Configure nano syntax highlighting
    echo "include /usr/share/nano/*.nanorc" > ~/.nanorc

    # Set default Java version (if installed)
    if pacman -Qq jdk21-openjdk > /dev/null 2>&1; then
        sudo archlinux-java set java-21-openjdk
    fi

    update_mirrorlist
    updatesys
    configure_custom_repos
    install_shell
    z_memory
    backup_system
    bootloader_customizer
    install_gui_store
    install_gaming_deps
    choose_driver_installation
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
    add_user_groups
   # darkmode_on_root TODO: needs "konsave" into chaotic AUR
}

main

# TODO function to patch KDE (either through kwriteconfig6 or konsave):
# Custom KDE (Workspace and Konsole)
#ALT + V/C for pasting/coping on Konsole
#night light to 5000k Always on
#kde feedback
#gruvbox color theme
#add system measurement widgets
#shortcuts:
#redo = CTRL Y

# TODO add my KeyringFix and Udev Patch script funcs
