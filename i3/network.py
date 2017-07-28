import subprocess
from i3pystatus import IntervalModule


def run_command(cmd):
    return subprocess.Popen(cmd,shell=True, stdout=subprocess.PIPE).stdout.read().strip().decode('utf-8')

def current_network_interface():
    default_ni = 'down'
    command = "nmcli device status |grep -E -v 'disconnected|docker|bridge' |grep connected |awk '{print $4}'"
    cmd_ni = run_command(command)
    if not cmd_ni:
        return default_ni
    return cmd_ni

def connect_to_network():
    command = "nmcli c up bitmain-download"
    run_command(command)

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
    down_time = 0

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
        result = ni
        if ni == 'down':
            color = self.alert_color
            self.down_time = self.down_time + 1
            if self.down_time == 8:
                connect_to_network()
        else:
            self.down_time = 0
            color = self.color

        if self.down_time != 0:
            result = ni + "," + str(self.down_time)

        cdict = {
            "current_network_interface": " " + result,
        }

        self.data = cdict
        self.output = {
            "full_text": self.format.format(**cdict),
            "color": color
        }
