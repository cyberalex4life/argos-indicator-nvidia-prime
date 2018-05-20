# argos-indicator-nvidia-prime
Gnome Shell Indicator for NVidia Prime, using Argos API

![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime1.jpg)                                       ![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime2.jpg)

#### Requirements
- nvidia-prime: `sudo apt install nvidia-prime`
- one of the following:
    - [pkroot](https://github.com/cyberalex4life/pkroot) - minimum already provided
    - gksu: `sudo apt install gksu`
    - gnomesu - OpenSuSE only

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
sudo chmod a+x /usr/local/bin/pkroot
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
sudo rm /usr/local/bin/pkroot
```
Then uninstall Argos if you don't need it anymore.

**Note!**
- To make the indicator ask for password when switching video cards, you can either fully install
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
    ```

- You can also modify second line from '**nvidia-prime.r.2s.sh**':
    ```
    run_as_root="pkroot -d" # gksu; pkroot; gnomesu -c;
    ```
    into:
    ```
    run_as_root="gksu" # gksu; pkroot; gnomesu -c;
    ```
    to use '**gksu**' in Ubuntu or Debian based distro's.

    'gnomesu -c' is ment for OpenSuSE, though the script might not be ready for anything other than Ubuntu's **nvidia-prime**.

    In general "*run_as_root*" has to support the following syntax:
    ```
    run_as_root "<command_or_list_of_commands>"
    ```
    where **""** is the way commands are coded (and **\\\\\\"** is nothing but an escape sequence).
