if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec dwl -s 'dunst & somebar & someblocks'
fi
