# argos-indicator-nvidia-prime
Gnome Shell Indicator for NVidia Prime, using Argos API

![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime1.jpg)                                       ![NVidia Prime Argos Indicator](https://github.com/cyberalex4life/argos-indicator-nvidia-prime/blob/master/screenshots/argos-nvidia-prime2.jpg)

#### Requirements
- [Argos](https://extensions.gnome.org/extension/1176/argos/) Gnome Shell extension.
- nvidia-prime: `sudo apt install nvidia-prime`
- one of the following:
    - [pkroot](https://github.com/cyberalex4life/pkroot) - minimum already provided in github repository
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

    'gnomesu -c' is meant for OpenSuSE, though the script might not be ready for anything other than Ubuntu's **nvidia-prime**.

    In general "*run_as_root*" has to support the following syntax:
    ```
    run_as_root "<command_or_list_of_commands>"
    ```
    where **""** is the way commands are coded (and **\\\\\\"** is nothing but an escape sequence).

- To further modify position and execution timings read:

    #### [Filename format](https://github.com/p-e-w/argos#filename-format) (for Argos plugins)


    A plugin file may be named anything (it only needs to be executable), but if its name has the special form

    ```
    NAME.POSITION.INTERVAL[+].EXTENSION
    ```

    where

    * `POSITION` consists of an integer (optional) + one of `l` (left), `c` (center) or `r` (right), and
    * `INTERVAL` consists of an integer + one of `s` (seconds), `m` (minutes), `h` (hours) or `d` (days)

    then

    * the dropdown menu button is placed in the panel at `POSITION`, and
    * the plugin is re-run and its output re-rendered every `INTERVAL`, and
    * if `INTERVAL` is followed by `+`, the plugin is additionally re-run each time the dropdown menu is opened.

    `POSITION` may be omitted entirely (in which case the button is placed before all other buttons on the right-hand side of the panel) while `INTERVAL` can be left empty. For example, a script named `plugin.10s.sh` is updated every 10 seconds, the button belonging to `plugin.1c..sh` is positioned just right of the GNOME Shell clock, and `plugin.l.1m.sh` is displayed left of the "Activities" button and updated every minute.
