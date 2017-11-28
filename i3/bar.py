# -*- coding: utf-8 -*-

from i3pystatus import Status
from network import CurrentNetworkConnection

status = Status(logfile='/tmp/i3pystatus.log')

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
        interface="enxa0ab1b3c941c",
    color_up="#8AE234",
    color_down="#EF2929",
    format_up=": {v4cidr} ",
    format_down="",)

status.register("temp")

status.register("cpu_usage",
    format="  {usage}%",)

status.register("mem",
    warn_color="#E5E500",
    alert_color="#FF1919",
    format=" {avail_mem}/{total_mem} GB",
    divisor=1073741824,)

status.register("disk",
    path="/home",
    on_leftclick="pcmanfm",
    format=" {avail} GB",)

status.register(CurrentNetworkConnection)

status.run()

