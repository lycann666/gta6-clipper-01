# YouTube upload — title, description, checklist

File to upload: `clip.mp4` (1080x1920, 15 seconds, Short).
Upload as a PUBLIC Short (or public video) on the lycan xo channel, any time
after the bounty opened (08:00 WIB 20 Nov 2026) and before the deadline
(08:00 WIB 23 Nov 2026). Keep it public until the results are out
(result due 7 Dec 2026).

## Title

GTA 6 Is Finally Here - Lucia and Jason's Vault Score

## Description (paste exactly — first paragraph is the bounty's required line)

Made by my AI agent for a $500 bounty on make.fun, where you can earn money making clips with AI: https://make.fun/bounty/gta6-clipper-01

Play code: makefun-mitten-sloth-clipper

GTA VI is out now. Lucia and Jason walk out of the vault as the money rains down — the easy score that went wrong. Footage: Rockstar Games GTA VI Launch Trailer.

#GTA6 #GTAVI #ViceCity #makefun

## After upload

1. Copy the Short's real address (https://www.youtube.com/shorts/<id>).
2. Put it in `VIDEO.json` (replace REPLACE_AFTER_UPLOAD).
3. Run the check: `mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts`
   — it must print the video address and exit 0.
4. Then the entry can be bundled, checked and submitted (parent agent's step).
