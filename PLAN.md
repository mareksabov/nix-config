# NixOS Migration Plan: Arch → NixOS

## Cieľ
Replikovat aktuálny Arch Linux setup na NixOS tak, aby bol na pocit identický.
Najprv vo VM, potom rovnaká konfigurácia na bare metal.

---

## Aktuálny Arch Setup (zhrnutie)

| Komponent | Aktuálne |
|-----------|----------|
| WM | Hyprland 0.54 + Wayland |
| Bar | Waybar |
| Launcher | Wofi |
| Lock | Hyprlock + Hypridle |
| Wallpaper | Hyprpaper |
| Notifications | Dunst |
| Terminal | Kitty (primary) + Ghostty |
| Shell | Bash (vi mode) + Atuin history |
| Editor | Neovim |
| GPU | NVIDIA RTX 4070 SUPER (nvidia-open 590) |
| Audio | PipeWire + Wireplumber |
| Network | NetworkManager |
| Login | greetd + tuigreet |
| Browser | Brave |
| File Manager | Dolphin |
| Clipboard | wl-clipboard + cliphist + wl-clip-persist |
| Screenshots | grim + slurp |
| Monitory | 3x (DP-2, DP-1, HDMI-A-1) všetky 1080p |
| Tablet | OpenTabletDriver (Wacom) |
| Dev | .NET 10, Node 25, Python 3.14, JDK 17 |
| Virtualizácia | Docker, QEMU/libvirt |
| VPN | ProtonVPN, OpenVPN, WireGuard |
| Dotfiles | Bare git repo (~/.dotfiles) |
| Fonts | JetBrains Mono Nerd Font, Inter, Noto Emoji |
| Theme | Catppuccin Macchiato (Ghostty), KDE/Qt integrácia |

---

## Architektúra NixOS Konfigurácie

```
~/nix-config/                          # Git repo (flake)
├── flake.nix                          # Entry point
├── flake.lock
├── hosts/
│   ├── vm/                            # VM-specific
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── desktop/                       # Bare metal (neskôr)
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/
│   ├── system/
│   │   ├── boot.nix                   # Bootloader, kernel
│   │   ├── nvidia.nix                 # NVIDIA driver + env vars
│   │   ├── network.nix                # NetworkManager, firewall
│   │   ├── audio.nix                  # PipeWire + Wireplumber
│   │   ├── bluetooth.nix
│   │   ├── locale.nix                 # Timezone, locale, keyboard
│   │   ├── services.nix               # Docker, libvirt, cups, SSH
│   │   └── users.nix                  # User marky
│   └── desktop/
│       ├── hyprland.nix               # Hyprland + portals + polkit
│       ├── greetd.nix                 # greetd + tuigreet
│       └── fonts.nix                  # Systémové fonty
├── home/
│   ├── default.nix                    # Home Manager entry
│   ├── shell.nix                      # Bash, Atuin, aliases
│   ├── terminals.nix                  # Kitty, Ghostty config
│   ├── hyprland.nix                   # Hyprland dotfiles
│   ├── waybar.nix                     # Waybar config + style
│   ├── wofi.nix                       # Wofi config
│   ├── dunst.nix                      # Dunst config
│   ├── neovim.nix                     # Neovim setup
│   ├── git.nix                        # Git config
│   ├── packages.nix                   # User-level packages
│   └── scripts.nix                    # Custom scripts (~/.local/bin/)
└── overlays/                          # Package overrides ak treba
```

---

## Stratégia pre Dotfiles

### Rozhodnutie: Home Manager vs. Surové dotfiles

**Odporúčanie: Hybridný prístup**

- **Home Manager** na inštaláciu user balíkov a správu jednoduchých configov
  (git, bash, atuin, dunst, wofi)
- **Surové dotfile súbory** (cez `home.file` alebo `xdg.configFile`) pre komplexné
  konfigurácie kde nechceš písať Nix (hyprland.conf, kitty.conf, waybar/, etc.)
- Aktuálny bare git repo (`~/.dotfiles`) sa nahradí flake repom - všetky
  konfigurácie budú na jednom mieste

**Prečo hybridný:**
- Hyprland/Kitty/Waybar configs sú rozsiahle a menia sa často → jednoduchšie
  mať raw config files než ich prepisovať do Nix syntaxe
- Jednoduché veci (git, bash aliases) → Home Manager ich natívne podporuje
- Všetko v jednom git repo = reproducible

---

## Fázy Migrácie

### Fáza 1: Základ systému (VM)
1. Vytvoriť flake s basic NixOS konfiguráciou
2. Boot, locale, timezone, user marky
3. NetworkManager
4. SSH (pre prípad vzdialenébo prístupu do VM)

### Fáza 2: Desktop prostredie (VM)
1. Hyprland + XDG portals
2. greetd + tuigreet
3. PipeWire + Wireplumber
4. Fonty (JetBrains Mono NF, Inter, Noto Emoji)
5. NVIDIA modul (preskočiť vo VM, pripraviť pre bare metal)

### Fáza 3: Home Manager + Dotfiles (VM)
1. Integrovať Home Manager do flake
2. Bash config (vi mode, aliases, PATH)
3. Atuin
4. Kitty + Ghostty terminály
5. Neovim
6. Git config
7. Hyprland config (3-monitor, keybinds, autostart)
8. Waybar config + CSS
9. Wofi config
10. Dunst config
11. Hyprlock + Hypridle + Hyprpaper
12. Clipboard setup (wl-clipboard, cliphist, wl-clip-persist)
13. Screenshot tools (grim, slurp)
14. Custom scripts (~/.local/bin/)

### Fáza 4: Aplikácie (VM)
1. Brave browser
2. Dolphin file manager + KDE integrácia
3. Komunikácia (Vesktop, Evolution)
4. Media (mpv, vlc)
5. Kancelária (LibreOffice)
6. Utilities (btop, fzf, jq, trash-cli, nnn)
7. Wacom/OpenTabletDriver
8. Solaar (Logitech)

### Fáza 5: Development tools (VM)
1. .NET SDK
2. Node.js + npm
3. Python
4. JDK 17
5. Docker + docker-compose
6. QEMU/libvirt/virt-manager
7. VS Code
8. Unity Hub (ak je v nixpkgs)
9. Blender
10. Android SDK
11. Git LFS, GitHub CLI

### Fáza 6: VPN & Bezpečnosť (VM)
1. ProtonVPN
2. OpenVPN
3. WireGuard tools
4. GNOME Keyring

### Fáza 7: Finálne doladenie (VM)
1. GTK/Qt témy (Catppuccin)
2. Zram swap
3. fstrim timer
4. Custom systemd user services/timers
5. XDG autostart (NextCloud, Vesktop)
6. Testovanie celého workflow

### Fáza 8: Bare Metal Deployment
1. Nainštalovať NixOS na desktop (nvme0n1p5 - 200GB partícia)
2. Vygenerovať hardware-configuration.nix pre desktop
3. Pridať host `desktop` do flake s NVIDIA modulom
4. Nakonfigurovať mount points (HDD /mnt/praca_hry, etc.)
5. nixos-rebuild switch
6. Otestovať 3-monitor setup, GPU, tablet, audio

---

## Kritické body / Riziká

| Riziko | Mitigácia |
|--------|-----------|
| NVIDIA + Hyprland na NixOS | Dobre podporené, nvidia-open v nixpkgs |
| OpenTabletDriver | Existuje v nixpkgs, treba overiť verziu |
| Brave browser | V nixpkgs ako `brave` |
| Unity Hub | V nixpkgs, ale môže byť problematické |
| Vesktop | V nixpkgs |
| ProtonVPN GUI | Treba overiť, možno flatpak fallback |
| 3-monitor setup | Config je v hyprland.conf, prenositeľné |
| Bare git dotfiles | Nahradíme flake repom, žiadna strata |
| AUR balíky | Niektoré nemusia byť v nixpkgs → overlays/flatpak |

---

## AUR Balíky na Overenie v nixpkgs

- brave-bin → `brave` (v nixpkgs)
- vesktop → `vesktop` (v nixpkgs)
- qt6ct-kde → treba overiť
- mirage → treba overiť
- opentabletdriver → `opentabletdriver` (v nixpkgs)
- unity-hub → `unityhub` (v nixpkgs)
- visual-studio-code-bin → `vscode` (v nixpkgs)
- watchman → treba overiť
- greetd-tuigreet → `greetd.tuigreet` (v nixpkgs)
- timeshift → treba overiť

---

## Ďalší krok

Začneme **Fázou 1** - vytvoríme flake a základnú konfiguráciu systému.
Budem potrebovať prístup do VM (alebo pošleš výstup z `nixos-generate-config`).
