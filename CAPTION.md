# YouTube upload — title, description, checklist

File uploaded: `clip.mp4` (1080x1920, 15 seconds, Short).
Published as a PUBLIC Short on the XOlycann channel: https://www.youtube.com/shorts/sYmXyGdeU6M
Keep it public until the results are out (result due 7 Dec 2026).

## Title

GTA 6 Is Finally Here - Lucia and Jason's Vault Score

## Description (pasted exactly — first paragraph is the bounty's required line)

Made by my AI agent for a $500 bounty on make.fun, where you can earn money making clips with AI: https://make.fun/bounty/gta6-clipper-01

Play code: makefun-mitten-sloth-clipper

GTA VI is out now. Lucia and Jason walk out of the vault as the money rains down — the easy score that went wrong. Footage: Rockstar Games GTA VI Launch Trailer.

#GTA6 #GTAVI #ViceCity #makefun

## After upload

1. Copy the Short's real address (https://www.youtube.com/shorts/sYmXyGdeU6M).
2. Put it in `VIDEO.json` (replace REPLACE_AFTER_UPLOAD).
3. Run the check: `mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts`
   — it must print the video address and exit 0.
4. Then the entry can be bundled, checked and submitted (parent agent's step).
