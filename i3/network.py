from i3pystatus import IntervalModule
import subprocess

def current_network_interface():
    default_ni = 'down'
    command = "nmcli device status |grep -E -v 'disconnected|docker|bridge' |grep connected |awk '{print $4}'"
    cmd_ni = subprocess.Popen(command,shell=True, stdout=subprocess.PIPE).stdout.read().strip().decode('utf-8')
    if not cmd_ni:
        return default_ni
    return cmd_ni

class CurrentNetworkInterface(IntervalModule):
    """
    Shows current network interface

    .. rubric:: Available formatters

    * {current_network_interface}

    Requires psutil (from PyPI)
    """

    format = "{current_network_interface}"
    divisor = 1024 ** 2
    color = "#00FF00"
    warn_color = "#FFFF00"
    alert_color = "#FF0000"
    round_size = 1

    settings = (
        ("format", "format string used for output."),
        ("divisor",
         "divide all byte values by this value, default is 1024**2 (megabytes)"),
        ("warn_percentage", "minimal percentage for warn state"),
        ("alert_percentage", "minimal percentage for alert state"),
        ("color", "standard color"),
        ("warn_color",
         "defines the color used when warn percentage is exceeded"),
        ("alert_color",
         "defines the color used when alert percentage is exceeded"),
        ("round_size", "defines number of digits in round"),

    )

    def run(self):
        ni = current_network_interface()

        if ni == 'down':
            color = self.alert_color
        else:
            color = self.color

        cdict = {
            "current_network_interface": ni,
        }
        self.data = cdict
        self.output = {
            "full_text": self.format.format(**cdict),
            "color": color
        }
