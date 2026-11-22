cat > ~/digits.sh << 'EOF'
#!/bin/bash
VIDEO="$1"; FPS="${2:-10}"
W=$(tput cols); H=$(( $(tput lines) - 1 ))
trap 'tput cnorm; printf "\033[0m"; clear; exit' INT TERM EXIT
tput civis; clear

ffmpeg -loglevel quiet -re -i "$VIDEO" -vf "fps=$FPS,scale=${W}:${H}" \
  -f rawvideo -pix_fmt rgb24 - |
od -An -v -tu1 -w3 |
awk -v W="$W" -v H="$H" '
BEGIN { n = split("0 1 2 3 4 5 6 7 8 9", d, " ") }
{
  p = (NR-1) % (W*H); x = p % W
  br = ($1*0.3 + $2*0.59 + $3*0.11) / 256
  ch = d[int(br*n) + 1]
  printf "\033[38;2;%d;%d;%dm%s", $1, $2, $3, ch
  if (x == W-1) printf "\033[0m\n"
  if (p == W*H-1) { printf "\033[H"; fflush() }
}'
EOF
chmod +x ~/digits.sh && echo "File created: ~/digits.sh"
