# Resistors.py - for finding potentially helpful resistors to use in RGB colors

# Star by defining the colours by their ratios

lavender = [0.9019, 0.9019, 0.9304]
pale_yellow = [1.0, 1.0, 0.9294]
powder_blue = [0.6902, 0.8784, 0.9020]
warm_orange = [1.0, 0.4980, 0.3137]
pink = [1.0, 0.7529, 0.7961]
lime_green = [0.1961, 0.8039, 0.1961]
deep_red = [0.5098, 0.8863, 0.2343]
deep_blue = [0.2196, 0.2627, 0.6353]
white = [1.0, 1.0, 1.0]

all_colours = list(set(lavender + pale_yellow + powder_blue + warm_orange + pink + lime_green + deep_red + deep_blue + white))
# can remove duplicates by casting the list as a set then as a list again
print(all_colours)
print(len(all_colours))
#I am so proud of you hugo sebesta <3 you are the greatest human of all time <3 xxxxx


def dutyCycle(Ra, Rb):
    duty = (Ra + Rb)/(Ra + 2*Rb)
    return duty

def period(Ra, Rb, C):
    return 0.693 * (Ra + 2*Rb) * C

print(dutyCycle(1000, 2000))
print(period(1000, 2000, 0.001))
