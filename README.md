# Elemac SA-03 Ruby binding 
Ruby binding for ELEMAC SA-03 aquarium controller.
Manufacturer: http://www.elemac.pl/

Gem provides a way to read memory of the aquarium controller. Memory addresses, offsets ect. were found from decompiling the original program which was written in C# and available only for MS Windows. Memory writing (currently disabled in code) is also possible although it might damage the controller and make it unusable.

:warning: **Warning:** This script is published for educational purposes only! Author will accept no responsibility for any consequence, damage or loss which might result from use.

## Features:
You're able to view following details from the controller:
* Overview info (date, statuses, alarms)
* Lightning info
* Sensor info (Temperature and PH) # Redox is unavailable because I am unable to test this
* Output info (Power / PWM / TTL) # PWM and TTL are 'dumb' because I am unable to test this
* Timers info (ToDo)

## Installation:
Clone the repo. Build gem, install and use in your ruby scripts.

## Usage:

> el = Elemac::Connection.new
> x = Elemac::Sensors.new(device: el)
> x.temp1.value
> x.ph1.inspect
