# argos-indicator-nvidia-prime
Gnome Shell Indicator for NVidia Prime, using Argos API

![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime1.jpg)                                       ![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime2.jpg)

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

# copy icons
cp -v icons/* ~/.local/share/icons/

# copy 'nvidia-prime.r.2s.sh' to 'argos' folder
cp -v nvidia-prime.r.2s.sh ~/.config/argos/

# copy polkit policy in place
sudo cp org.freedesktop.policykit.pkexec.prime-select.policy /usr/share/polkit-1/actions/

# copy pkroot to '/usr/local/bin' and make sure it is executable
sudo cp pkroot /usr/local/bin
```
#### Uninstall
```
# remove icons
rm ~/.local/share/icons-to-delete/{nvidia-active-symbolic.svg,nvidia-inactive-symbolic.svg,prime-indicator-intel.svg,prime-indicator-intel-symbolic.svg,prime-indicator-nvidia.svg}

# remove policy
sudo rm org.freedesktop.policykit.pkexec.prime-select.policy /usr/share/polkit-1/actions/

# remove argos extension script
rm ~/.config/argos/nvidia-prime.r.2s.sh

# remove pkroot script
sudo cp /usr/local/bin/pkroot
```
Then uninstall Argos if you don't need it anymore.

**Note!**
To make the indicator ask for password when switching video cards, you can either fully install
['pkroot'](https://github.com/cyberalex4life/pkroot) or edit '**org.freedesktop.policykit.pkexec.prime-select.policy**' such that these lines:
```
<defaults>
    <allow_any>yes</allow_any>
    <allow_inactive>yes</allow_inactive>
    <allow_active>yes</allow_active>
</defaults>
```
look like this:
```
<defaults>
    <allow_any>auth_admin</allow_any>
    <allow_inactive>auth_admin</allow_inactive>
    <allow_active>auth_admin</allow_active>
</defaults>
