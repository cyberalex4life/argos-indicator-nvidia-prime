# argos-indicator-nvidia-prime
Gnome Shell Indicator for NVidia Prime, using Argos API

![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime1.jpg)

![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime2.jpg)

#### Installation
Install [Argos](https://extensions.gnome.org/extension/1176/argos/) Gnome-Shell extension.

Create directory `~/.local/share/icons` if it does not exist:
```
! [ -d "~/.local/share/icons" ] && mkdir --parents ~/.local/share/icons || true
```

Then:
```
git clone https://github.com/cyberalex4life/argos-indicator-nvidia-prime.git
cd argos-indicator-nvidia-prime
cp -v icons/* ~/.local/share/icons/
cp -v nvidia-prime.r.2s.sh ~/.config/argos/
sudo cp org.freedesktop.policykit.pkexec.prime-select.policy /usr/share/polkit-1/actions/
sudo cp pkroot /usr/local/bin/
```
**Note!**
Further info to be added soon...
