# ANSI Art and Video Player (`digits.sh`)

A lightweight Bash script that plays any video directly in your terminal by rendering frames as real-time 24-bit ANSI truecolor digits (`0`–`9`) mapped to pixel brightness.

## How It Works

1. **Terminal Setup:** Captures the video file path (`$1`) and target frame rate (`$2`, defaulting to `10` FPS), detects terminal width (`W`) and usable height (`H`), hides the cursor, and registers an exit trap to restore terminal state cleanly.
2. **Video Decoding (`ffmpeg`):** Decodes the input video at the specified FPS, scales frames to `WxH`, and streams raw `rgb24` pixel data to standard output.
3. **Byte Conversion (`od`):** Converts the raw byte stream into unsigned decimal `R G B` triplets.
4. **ANSI Rendering (`awk`):** Calculates pixel luminance (`0.3*R + 0.59*G + 0.11*B`), maps brightness to a digit (`0`–`9`), prints each character using 24-bit ANSI truecolor escape codes (`\033[38;2;R;G;Bm`), and resets the cursor to the top-left (`\033[H`) after every frame.

## Requirements

- `bash`
- `ffmpeg`
- `od` (GNU coreutils)
- `awk`
- `tput` (`ncurses`)
- A terminal emulator with 24-bit truecolor support (e.g., Windows Terminal, iTerm2, GNOME Terminal, Kitty, Alacritty)

## Setup

Make the script executable before running:

```bash
chmod +x digits.sh
```

## Usage

```bash
./digits.sh <path-to-video> [fps]
```

### Examples

```bash
# Play at the default 10 FPS
./digits.sh sample.mp4

# Play at 15 FPS
./digits.sh sample.mp4 15
```

Press `Ctrl+C` at any time to stop playback—the exit trap will automatically restore your cursor, reset colors, and clear the terminal.

<img width="1600" height="769" alt="image" src="https://github.com/user-attachments/assets/148fae6c-9db9-4e46-b3f4-d796b57fc550" />
<img width="1125" height="541" alt="image" src="https://github.com/user-attachments/assets/51f6ade4-6f96-4acd-9eee-51a9aaaf8b14" />

