#!/bin/bash

#==================== COLORS ====================#
P="\033[1;31m"   # Purple
G="\033[1;32m"   # Green
C="\033[1;36m"   # Cyan
W="\033[1;37m"   # White
R="\033[1;31m"   # Red

clear

#==================== ASCII ART (PLACEHOLDERS) ====================#
echo -e "${P}"
cat << "EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠀⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂
⠈⠉⠁⠀⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁⠀
⠀⠀⠀⢀⣴⣿⣿⣿⡿⠁⠀⢀⣀⣤⣤⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖⠀⠀⠀
⠀⠀⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀
⠀⠀⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⠀⠀⢀⣾⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⢿⣿⣿⣷⣄⡀⠀⠀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠿⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀
EOF

echo -e "${W}"
cat << "EOF"
▀█████████▄   ▄██████▄      ███        ▄████████ ▀████    ▐████▀    ▄███████▄ 
  ███    ███ ███    ███ ▀█████████▄   ███    ███   ███▌   ████▀    ███    ███ 
  ███    ███ ███    ███    ▀███▀▀██   ███    █▀     ███  ▐███      ███    ███ 
 ▄███▄▄▄██▀  ███    ███     ███   ▀   ███           ▀███▄███▀      ███    ███ 
▀▀███▀▀▀██▄  ███    ███     ███     ▀███████████    ████▀██▄     ▀█████████▀  
  ███    ██▄ ███    ███     ███              ███   ▐███  ▀███      ███        
  ███    ███ ███    ███     ███        ▄█    ███  ▄███     ███▄    ███        
▄█████████▀   ▀██████▀     ▄████▀    ▄████████▀  ████       ███▄  ▄████▀      
                                          
EOF
sleep 1

# reset on exit
trap "echo -e \"${W}\"; tput cnorm; exit" INT TERM EXIT
tput civis 2>/dev/null || true

#==================== PASSWORD ====================#
while true; do
    echo -e "${W}Enter password to continue:"
    read -p "> " pass

    if [ "$pass" = "free:lvl" ]; then
        break
    else
        echo -e "${R}Wrong password! Try again..."
        echo
        sleep 1
    fi
done

clear
echo -e "${C}Initializing system modules..."
sleep 0.8

# ==================== FAKE PATHS VISUAL ==================== #
print_paths() {
  local total=$1
  local i=1
  while [ $i -le $total ]; do
    # make a believable fake path
    local rnd=$(( (RANDOM % 9000) + 1000 ))
    local branch=$(( (RANDOM % 5) + 1 ))
    printf "${G}[%3d] -> Root/linx/enforce/freefire${branch}/trace_%s\n" "$i" "$rnd"
    i=$((i+1))
    sleep 0.05
  done
}

# Print a lot of green paths (more than 12)
echo -e "${G}Generating secure trace paths..."
print_paths 30
sleep 0.4

# ==================== PROGRESS BAR 1..100 (GREEN) ==================== #
echo
echo -ne "${C}Finalizing traces: ${W}"
for p in $(seq 1 100); do
  # simple percentage display, with a short pause to look visual
  printf "\r${G}Finalizing traces: %3d%% ${W}" "$p"
  sleep 0.02
done
echo
echo -e "${G}Success. Traces complete.${W}"
sleep 0.6

# ==================== REQUEST RIP & LONG CODES ==================== #
echo
echo -e "${C}Enter your RIP:" 
read -p "> " rip

echo -e "${C}Preparing secure payloads...${W}"
sleep 0.6

# print many very long green "codes" (visual only)
for i in $(seq 1 40); do
  # generate a long pseudo-random hex-like string
  code=$(tr -dc 'A-F0-9' </dev/urandom | head -c 160)
  printf "${G}[%03d] %s\n" "$i" "$code"
  sleep 0.03
done

echo
echo -e "${G}Payloads generated. Attempting to launch game(s)...${W}"
sleep 0.8

# ==================== LAUNCH GAME: try Max then normal ==================== #
# Approach: try am start for Free Fire Max; if it fails try Free Fire normal.
# These commands work on Android (device shell / emulator). If running on a non-Android system,
# the script will inform you that auto-launch isn't available.
launch_game() {
  # try start Free Fire Max
  if command -v am >/dev/null 2>&1; then
    if am start -n com.dts.freefiremax/com.dts.freefireth.MainActivity >/dev/null 2>&1; then
      echo -e "${G}Launched Free Fire MAX.${W}"
      return 0
    fi

    # try normal Free Fire
    if am start -n com.dts.freefireth/com.dts.freefireth.MainActivity >/dev/null 2>&1; then
      echo -e "${G}Launched Free Fire (standard).${W}"
      return 0
    fi

    # fallback: try to detect packages then start
    if command -v pm >/dev/null 2>&1; then
      if pm list packages | grep -q 'com.dts.freefiremax'; then
        am start -n com.dts.freefiremax/com.dts.freefireth.MainActivity >/dev/null 2>&1 && echo -e "${G}Launched Free Fire MAX.${W}" && return 0
      fi
      if pm list packages | grep -q 'com.dts.freefireth'; then
        am start -n com.dts.freefireth/com.dts.freefireth.MainActivity >/dev/null 2>&1 && echo -e "${G}Launched Free Fire (standard).${W}" && return 0
      fi
    fi

    echo -e "${R}Auto-launch failed: Free Fire packages not found or 'am' could not start them.${W}"
    return 1
  else
    echo -e "${R}'am' command not available on this system. Auto-launch requires Android shell (emulator/device).${W}"
    return 2
  fi
}

launch_game

# done
tput cnorm 2>/dev/null || true
echo -e "${W}Visual session finished."
