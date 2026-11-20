#!/usr/bin/env bash
# build-clip.sh — ffmpeg recipe for the gta6-clipper-01 clip (clip.mp4).
#
# Source: the official Rockstar GTA VI Launch Trailer (15 Oct 2026),
# seconds 34.4-37.33 — Lucia and Jason walk out of the vault as money rains
# down. One unbroken 2.93 s beat, used twice: once at full speed, once in
# slow motion, then an end card.
#
# Output: 1080x1920 vertical, ~15.07 s, h264 + aac, trailer audio throughout.
# The 16:9 footage is kept whole over a blurred copy of itself, so nothing
# is cropped out of the frame.
#
#   ./build-clip.sh <source-trailer-1080p.mp4> <clip.mp4>
#
# This script documents the render; the published clip was rendered from it.

set -euo pipefail

SRC="${1:-source-launch-trailer-1080p.mp4}"
OUT="${2:-clip.mp4}"

# The beat inside the trailer.
START=34.4
DUR=2.93

# Slow-motion factor for the second pass over the beat.
SLOW=0.35

# Segment timings in the finished clip.
HOOK_END=2.9      # full-speed hook ends here
PITCH_END=11.3    # slow-motion pitch ends here
TOTAL=15.07       # end card runs to here

# Vertical pillarbox: blur a stretched copy of the frame into the background,
# then lay the sharp 16:9 frame (1080 px wide) over its middle.
PILLARBOX="split[a][b];[a]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=28[bg];[b]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2"

# Full-speed hook (0-2.9 s) with the hook text on screen.
HOOK="[0:v]trim=start=${START}:duration=${DUR},setpts=PTS-STARTPTS,${PILLARBOX},drawtext=text='GTA 6 IS FINALLY HERE':fontsize=64:fontcolor=white:borderw=3:bordercolor=black:x=(w-text_w)/2:y=h*0.12,setsar=1[vhook]"

# Slow-motion pass (2.9-11.3 s): the same beat at 0.35x, pitch text on screen.
# setpts stretches the video; atempo stretches the audio (chained, since one
# atempo only reaches 0.5x).
SLOWMO="[0:v]trim=start=${START}:duration=${DUR},setpts=PTS-STARTPTS,setpts=(1/${SLOW})*PTS,${PILLARBOX},drawtext=text='MAKE CLIPS LIKE THIS WITH AI':fontsize=56:fontcolor=white:borderw=3:bordercolor=black:x=(w-text_w)/2:y=h*0.12,drawtext=text='AND EARN MONEY ON MAKE.FUN':fontsize=56:fontcolor=white:borderw=3:bordercolor=black:x=(w-text_w)/2:y=h*0.12+72,setsar=1[vpitch]"
SLOWMO_A="[0:a]atrim=start=${START}:duration=${DUR},asetpts=PTS-STARTPTS,atempo=0.5,atempo=0.7[apitch]"

# End card (11.3-15.1 s): dark card with the make.fun call to action.
# 3.77 s = TOTAL (15.07) - PITCH_END (11.3).
ENDCARD="color=c=0x111111:s=1080x1920:d=3.77,drawtext=text='make.fun':fontsize=96:fontcolor=white:x=(w-text_w)/2:y=h*0.38,drawtext=text='EARN MONEY MAKING CLIPS WITH AI':fontsize=44:fontcolor=white:x=(w-text_w)/2:y=h*0.50,drawtext=text='make.fun/bounty/gta6-clipper-01':fontsize=36:fontcolor=white:x=(w-text_w)/2:y=h*0.58,setsar=1[vcard]"

ffmpeg -y -i "$SRC" -filter_complex "
  ${HOOK};
  ${SLOWMO};
  ${SLOWMO_A};
  ${ENDCARD};
  [vhook][vpitch][vcard]concat=n=3:v=1:a=0[vout]
" -map "[vout]" -map "[apitch]" \
  -c:v libx264 -pix_fmt yuv420p -r 30 \
  -c:a aac -b:a 128k \
  -t "${TOTAL}" "$OUT"

echo "wrote ${OUT}"
