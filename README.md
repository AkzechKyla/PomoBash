# PomoBash
A simple [Pomodoro](https://en.wikipedia.org/wiki/Pomodoro_Technique) timer you can run on your terminal/command line interface written in Bash, featuring configurable focus and break durations, pause/resume functionality, and voice notifications.
## Features
- Customizable focus time, short break, and long break durations
- Pause (`p`), resume (`r`), and quit (`q`) functionality
- Manual or auto-start Pomodoro sessions and breaks
- Voice notifications using `espeak`
- Interactive configuration script (`configure.sh`)
## Dependencies
- ``espeak`` for voice notifications
## Installation
1. Clone the repository:
   ```bash
   git clone git@github.com:AkzechKyla/PomoBash.git
   cd PomoBash
   ```
2. Make the scripts executable:
   ```bash
   chmod +x configure.sh
   chmod +x pomobash.sh
   ```
3. Install dependency:
   ```bash
   sudo apt update
   sudo apt install espeak
   ```
## Usage
To run pomodoro:
```bash
./pomobash.sh
```
To update pomodoro settings:
```bash
./configure.sh
```
