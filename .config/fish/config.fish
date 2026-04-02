source /usr/share/cachyos-fish-config/cachyos-config.fish

if test -z "$WAYLAND_DISPLAY" -a (tty) = "/dev/tty1"
  exec dwl -s 'dunst & somebar & someblocks'
end
