# Tauon Music Box Player Control
A simple script to control Tauon Music Box from the polybar.
The script is able to:
- Display the current song
- Pause/unpause the currently selected song
- Skip to the previous/next song

![player](screenshots/player.png)

# Installation
Copy the bash script to your usual polybar scripts location, and set it up in your Polybar configuration.\
The script uses `playerctl`, [Font Awesome](https://fontawesome.com/), and, obviously, [Tauon Music Box](https://tauonmusicbox.rocks/).

# Polybar module setup
```ini
[module/tauon-playerctl]
type = custom/script
exec = <path_to_script> display
interval = 1

click-left = <path_to_script> previous
click-middle = <path_to_script> playpause
click-right = <path_to_script> next
scroll-up = <path_to_script> volumeup
scroll-down = <path_to_script> volumedown
```

# Divider
By default the divider between the artist and the song is `-`, however it can be changed by using the `-d` flag.\
`<path_to_script> -d "//" ACTION`

# Max characters
By default the script will display 80 characters at max, this can be changed with the `-c` flag
