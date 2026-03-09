# ecoworthy-rpi
RPi scripts that read metrics from two versions of the EcoWorthy 100Ah 12V batteries, and publish to MQTT  

ewbatlog-mqtt.py mainly a copy from https://github.com/mike805/eco-worthy-battery-logger with mqtt publish added  
ewbatlog-random.py based off above but heavily modified as these batteries use a completely different protocol - lots of dead code that can be removed in here  
