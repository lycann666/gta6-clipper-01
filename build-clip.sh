#!/bin/bash
# gta6-clipper-01 — render the vertical Short from the GTA VI Launch Trailer.
# Moment (one scene, one story beat): the vault walk + golden close-up,
# trailer time 34.4s -> 37.33s (Lucia and Jason walk out of the vault as
# money rains down, then the close-up in golden light). Structure:
#   A (0-2.93s)  moment at full speed, hook text on top
#   B (2.93-11.3s) same moment in slow motion (0.35x), pitch text lines
#   C (11.3-15.1s) end card on a blurred freeze frame of the vault
# Audio: the trailer's own music bed, 34.4s -> 49.4s, faded out at the end.
# Output: 1080x1920, 30fps, h264 + aac, file clip.mp4 in this directory.
set -euo pipefail
cd "$(dirname "$0")"
SRC=source-launch-trailer-1080p.mp4
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
# Vertical canvas: blurred full-bleed background + sharp 16:9 foreground
# centred (foreground 1080x607 at y=656). Text lives in the blurred bands.
VERT="split[a][b];[a]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40,eq=brightness=-0.18[bg];[b]scale=1080:607[fg];[bg][fg]overlay=0:656"

# --- Segment A: moment, full speed, hook text ---
ffmpeg -v error -y -ss 34.4 -i "$SRC" -t 2.93 -filter_complex \
  "$VERT,drawtext=fontfile=$FONT:text='GTA 6 IS FINALLY HERE':fontsize=76:fontcolor=white:borderw=3:bordercolor=black:box=1:boxcolor=black@0.55:x=(w-text_w)/2:y=300" \
  -c:v libx264 -preset medium -crf 21 -pix_fmt yuv420p -an segA.mp4

# --- Segment B: same moment, slow motion, pitch text lines ---
# NOTE: -t must sit BEFORE -i here (input option): as an output option it
# would cut the stretched output back to 2.93s instead of 2.93/0.35 = 8.37s.
ffmpeg -v error -y -ss 34.4 -t 2.93 -i "$SRC" -filter_complex \
  "[0:v]setpts=PTS/0.35,split[a][b];[a]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40,eq=brightness=-0.18[bg];[b]scale=1080:607[fg];[bg][fg]overlay=0:656,drawtext=fontfile=$FONT:text='MAKE CLIPS LIKE THIS':fontsize=62:fontcolor=white:borderw=3:bordercolor=black:box=1:boxcolor=black@0.55:x=(w-text_w)/2:y=240:enable='between(t,0.3,4.0)',drawtext=fontfile=$FONT:text='WITH AI':fontsize=62:fontcolor=white:borderw=3:bordercolor=black:box=1:boxcolor=black@0.55:x=(w-text_w)/2:y=330:enable='between(t,0.3,4.0)',drawtext=fontfile=$FONT:text='AND EARN MONEY':fontsize=62:fontcolor=white:borderw=3:bordercolor=black:box=1:boxcolor=black@0.55:x=(w-text_w)/2:y=240:enable='between(t,4.3,8.0)',drawtext=fontfile=$FONT:text='ON MAKE.FUN':fontsize=62:fontcolor=white:borderw=3:bordercolor=black:box=1:boxcolor=black@0.55:x=(w-text_w)/2:y=330:enable='between(t,4.3,8.0)'" \
  -c:v libx264 -preset medium -crf 21 -pix_fmt yuv420p -an segB.mp4

# --- Segment C: end card on a blurred freeze frame of the vault (35.5s) ---
ffmpeg -v error -y -ss 35.5 -i "$SRC" -frames:v 1 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=45,eq=brightness=-0.35" -q:v 2 endcard-bg.jpg -y
ffmpeg -v error -y -loop 1 -i endcard-bg.jpg -t 3.8 -filter_complex \
  "drawtext=fontfile=$FONT:text='make.fun':fontsize=150:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=620,drawtext=fontfile=$FONT:text='EARN MONEY MAKING':fontsize=54:fontcolor=white:borderw=3:bordercolor=black:x=(w-text_w)/2:y=900,drawtext=fontfile=$FONT:text='CLIPS WITH AI':fontsize=54:fontcolor=white:borderw=3:bordercolor=black:x=(w-text_w)/2:y=980,drawtext=fontfile=$FONT:text='make.fun/bounty/gta6-clipper-01':fontsize=40:fontcolor=white:borderw=2:bordercolor=black:x=(w-text_w)/2:y=1150" \
  -c:v libx264 -preset medium -crf 21 -pix_fmt yuv420p -r 30 -an segC.mp4

# --- Audio bed: trailer music 34.4s -> 49.4s, fade out in the last second ---
ffmpeg -v error -y -ss 34.4 -i "$SRC" -t 15.1 -af "afade=t=out:st=14.1:d=1.0" -c:a aac -b:a 128k -vn audio-bed.m4a

# --- Concat video segments, attach the audio bed ---
printf "file 'segA.mp4'\nfile 'segB.mp4'\nfile 'segC.mp4'\n" > concat.txt
ffmpeg -v error -y -f concat -safe 0 -i concat.txt -i audio-bed.m4a \
  -map 0:v -map 1:a -c:v libx264 -preset medium -crf 21 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -movflags +faststart -shortest clip.mp4
rm -f segA.mp4 segB.mp4 segC.mp4 audio-bed.m4a concat.txt endcard-bg.jpg
ffprobe -v error -show_entries format=duration,size -show_entries stream=width,height,codec_name -of default=nw=1 clip.mp4
echo "RENDER DONE: clip.mp4"
