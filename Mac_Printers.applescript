###  Matt Levin - 7/15/17  ###

# Data for printers in the form: {{InternalName, DisplayName, Location, IPAddress}}
set printerData to {�
	{"Simon_Lab_1", "Simon Lab 1", "Schlegel 404 (Collaboration Lab)", "123456789.1"}, �
	{"Simon_Lab_2", "Simon Lab 2", "Schlegel 404 (Collaboration Lab)", "123456789.2"}, �
	{"Simon_Lab_3", "Simon Lab 3", "Schlegel 404 (Collaboration Lab)", "123456789.3"}, �
	{"Schlegel_1st_Floor", "Schlegel 1st Floor", "Schlegel Hall", "123456789.4"}, �
	{"Schlegel_4th_Floor", "Schlegel 4th Floor", "Schlegel Hall", "123456789.5"}, �
	{"Gleason_3rd_Floor", "Gleason 3rd Floor", "Gleason Hall", "123456789.6"}, �
	{"Gleason_Room_126", "Gleason Room 126", "Gleason Hall", "123456789.7"} �
		}

# Loop through each of the printers
repeat with printer in printerData
	# Run shell script to add printer with HP Protocol (socket) 
	do shell script "lpadmin" & �
		" -p " & quoted form of item 1 of printer & �
		" -D " & quoted form of item 2 of printer & �
		" -L " & quoted form of item 3 of printer & �
		" -E -v " & quoted form of ("socket://" & item 4 of printer) & �
		" -P /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" & �
		" -o printer-is-shared=false" & �
		" -o APOptionalDuplexer=true"
	# They're already shared on network so don't need to share again
	# Allows double sided printing (duplex), uses Generic PostScript Driver
end repeat

# Open System Preferences > Printers & Scanners to check that it worked
tell application "System Preferences"
	activate # Open System Preferences
	set current pane to pane id "com.apple.preference.printfax" # Go to Printers tab
end tell