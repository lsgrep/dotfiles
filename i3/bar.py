# -*- coding: utf-8 -*-

from network import CurrentNetworkInterface
from i3pystatus import Status
from i3pystatus.network import Network, sysfs_interface_up
from i3pystatus.updates import pacman, cower


class MyNetwork(Network):
    """
    Modified Network class that automatic switch interface in case of
    the current interface is down.
    """
    on_upscroll = None
    on_downscroll = None

    def run(self):
        super().run()
        if not sysfs_interface_up(self.interface, self.unknown_up):
            self.cycle_interface()

status = Status(logfile='/tmp/i3pystatus.log')

status.register("updates",
    format = "Updates: {count}",
    format_no_updates = "",
    on_leftclick="termite --geometry=1200x600 --title=updates -e 'pacaur --needed --noconfirm --noedit -Syu'",
    backends = [pacman.Pacman(), cower.Cower()])

status.register("clock",
    format=" %H:%M",
    color='#C678DD',
    interval=1,
    on_leftclick="/usr/bin/gsimplecal",)

status.register("clock",
    format=" %Y-%m-%d   %a",
    color='#61AEEE',
    interval=1,)

status.register("pulseaudio",
    color_unmuted='#98C379',
    color_muted='#E06C75',
    format_muted=' [muted]',
    format=" {volume}%")

status.register("network",
    interface="wlxa0ab1b3c941c",
    color_up="#8AE234",
    color_down="#EF2929",
    format_up=": {v4cidr} ",
    format_down="",)

status.register("temp")

status.register("cpu_usage",
    on_leftclick="termite --title=htop -e 'htop'",
    format="  {usage}%",)

status.register("mem",
    warn_color="#E5E500",
    alert_color="#FF1919",
    format=" {avail_mem}/{total_mem} GB",
    divisor=1073741824,)

status.register("disk",
    path="/home",
    on_leftclick="pcmanfm",
    format=" {avail} GB",)

status.register("text",
    text="|",
    color="#222222")

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register('ping',
    format_disabled='',
    host='dex.top',
    interval=10,
    color='#61AEEE')

status.register(CurrentNetworkInterface)

status.run()

