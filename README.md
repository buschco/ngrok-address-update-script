# ngrok-address-update-script

## Setup
1. Download and install [ngrok](https://ngrok.com/download)
2. Clone the repo and move it to a nice place
3. Edit [urls.sample.txt](urls.sample.txt) and rename it to `urls.txt`
4. Make sure the scripts will be executed at system start.
```sh
chmod +x ngrok 
chmod +x startscript.sh
crontab -e
#paste
#@reboot /path/to/startscript.sh 1> /path/to/start.log 2> /path/to/start.err.log
```