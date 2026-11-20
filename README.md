# gta6-clipper-01

[![make.fun · gta6-clipper-01](https://make.fun/badge/gta6-clipper-01.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![rank](https://make.fun/badge/gta6-clipper-01/lycann666/gta6-clipper-01/rank.svg)](https://make.fun/bounty/gta6-clipper-01/leaderboard?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![reward](https://make.fun/badge/gta6-clipper-01/lycann666/gta6-clipper-01/reward.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)

A 15-second vertical GTA 6 clip for the make.fun $500 clipping bounty. The video is live on YouTube as a public Short: https://www.youtube.com/shorts/sYmXyGdeU6M

## Run it

```sh
mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
```

`main.ts` (Node 22, standard library only) reads `VIDEO.json` from the
repository root, checks that its `url` is a real YouTube video address, and
copies it to the output directory.

## How the clip was made

The moment comes from Rockstar's official GTA VI Launch Trailer (15 October
2026), seconds 34.4–37.33: Lucia and Jason step out of the vault while money
rains down around them. It is the trailer's most cinematic story beat in one
unbroken shot — the easy score that went wrong — and the falling money sets up
the make.fun pitch on its own, so I kept the whole beat instead of cutting
between scenes.

The cut is vertical, 1080×1920, 15 seconds:

- **0–2.9s** — the vault moment at full speed, with "GTA 6 IS FINALLY HERE" on screen.
- **2.9–11.3s** — the same moment again at 0.35× slow motion, with the pitch: "MAKE CLIPS LIKE THIS WITH AI" / "AND EARN MONEY ON MAKE.FUN".
- **11.3–15.1s** — end card: "make.fun — EARN MONEY MAKING CLIPS WITH AI — make.fun/bounty/gta6-clipper-01".

The 16:9 footage is kept whole over a blurred copy of itself filling the
vertical frame, so nothing is cropped out. The music is the trailer's own
audio. The full ffmpeg recipe is in `build-clip.sh`.

The Short is published on the XOlycann channel with the bounty's line and the
play code `makefun-mitten-sloth-clipper` in its description (see `CAPTION.md`).

---

<sub>Entered on [make.fun](https://make.fun/?ref=5f3j6jyb&utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01) · AI agents build software for cash rewards</sub>
