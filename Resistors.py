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

#print(all_colours)
#print(len(all_colours))

#I am so proud of you hugo sebesta <3 you are the greatest human of all time <3 xxxxx


def dutyCycle(Ra, Rb):
    duty = (Ra + Rb)/(Ra + 2*Rb)
    return duty

def period(Ra, Rb, C):
    return 0.693 * (Ra + 2*Rb) * C


R_A = 0.0
R_B = 1.0
C = 0.0

def help():
    print("--- Resistors.py ---")
    print("Commands: ")
    print("h/help - Displays this menu")
    print("a [float] - Sets the value of R_A to [float] ohms")
    print("b [float] - Sets the value of R_B to [float] ohms")
    print("c [float] - Sets the value of C to [float] farads")
    print("o/out - Ouputs the values of R_A, R_B and C and the final duty cycle and period")
    print("x - Exits")
    print("--- Resistors.py ---")

def p():
    print("Results:")
    print("R_A = " + str(R_A) + " ohms, R_B = " + str(R_B) + " ohms, C = " + str(C) + " farads")
    print("Duty Cycle: " + str(dutyCycle(R_A, R_B)))
    print("Period: " + str(period(R_A, R_B, C)))

def cycle():
    global R_A
    global R_B
    global C

    print("> ", end = "")
    x = (input()).lower()

    if len(x) > 1:
        if x[1] != " ":
            print("Invalid input. Watch your spaces.")
            cycle()
        if len(x) > 2:
            if x[2] == " ":
                print("Invalid input. Watch your spaces.")
                cycle()

    if x == "h" or x == "help":
        help()
    elif x == "o" or x == "out":
        p()
    elif x[0] == "a":
        try:
            R_A = float(x[2:len(x)])
            #print(R_A)
        except:
            print("Invalid input. Type h/help for help.")
    elif x[0] == "b":
        try:
            R_B = float(x[2:len(x)])
            #print(R_B)
        except:
            print("Invalid input. Type h/help for help.")
    elif x[0] == "c":
        try:
            C = float(x[2:len(x)])
            #print(C)
        except:
            print("Invalid input. Type h/help for help.")
    elif x == "x":
        print("Goodbye!")
        quit()
    else:
        print("Invalid input. Type h/help for help.")

    cycle()



print("Welcome to Resistors.py")
print("Type h/help for help.")

cycle()
