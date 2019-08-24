# cnc_gcode_stripper
Ruby utility to remove some unwanted gcode commands for use at the Roswell Fire Labs machine setup.

This script looks for and removes:
+ G28 (homing) commands to keep us from starting/returning in a direct path through our work piece 
+ Txx Mx (Tool change) commands, that potentially stop the job and await human interaction

# How do I run it?
Install ruby in a manner that suits your OS 
https://www.ruby-lang.org/en/documentation/installation/

Execute the clean program and give it the path to your gcode file
`ruby clean.rb test.nc`

This will run the script, outputting the lines it strips, and saving a new file named 'cleaned.<your_file>`
```
Cleaning File: test.nc
Dropping line #6: G28 G91 Z0
Dropping line #11: T11 M6
Dropping line #6599: G28 G91 Z0
Dropping line #6601: G28 G91 X0 Y0
Completed with 4 lines removed
Wrote File: cleaned.test.nc
```
