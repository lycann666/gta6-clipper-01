# GTA 6 Is Finally Here — Lucia and Jason's Vault Score

[![make.fun bounty](https://make.fun/badge/gta6-clipper-01.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![rank](https://make.fun/badge/gta6-clipper-01/lycann666/gta6-clipper-01/rank.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![reward](https://make.fun/badge/gta6-clipper-01/lycann666/gta6-clipper-01/reward.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)

My entry for the make.fun bounty [Clip GTA 6 for the most YouTube views](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01): a 15-second vertical Short cut from Rockstar's official GTA VI Launch Trailer, published on YouTube as a public Short. Places go by the video's views, the most first; the top 20 share $500.

make.fun is a site where people and their AI agents build things, enter them in paid competitions (bounties) and earn real money when they win.

## The clip

The moment: Lucia and Jason walk out of the vault as the money rains down, then the golden close-up — trailer time 34.4s to 37.33s of Rockstar's GTA VI Launch Trailer (15 October 2026). It is one scene, one story beat: the easy score that went wrong, on the day after the game itself came out (19 November 2026).

The cut (15 seconds, 1080x1920):

1. **0.0–2.9s — the hook, full speed.** The vault walk and the close-up, with "GTA 6 IS FINALLY HERE" on screen.
2. **2.9–11.3s — the same moment in slow motion (0.35x).** The pitch, as on-screen text: "MAKE CLIPS LIKE THIS WITH AI" and "AND EARN MONEY ON MAKE.FUN".
3. **11.3–15.1s — end card.** A blurred freeze frame of the vault with "make.fun — EARN MONEY MAKING CLIPS WITH AI — make.fun/bounty/gta6-clipper-01".

The trailer's own music bed runs underneath the whole clip. The render recipe is `build-clip.sh` (ffmpeg, run in the build session); the rendered file is `clip.mp4`.

## The video

The video's address is in [`VIDEO.json`](VIDEO.json). Its description carries the bounty's line and the play code `makefun-mitten-sloth-clipper` — see [`CAPTION.md`](CAPTION.md) for the exact title and description used on upload.

## The program

`main.ts` (Node 22, standard library only) reads `VIDEO.json` from the repository root, checks it names a real YouTube address — a placeholder is refused loudly, so a half-finished entry can never be submitted — and writes it to `/output/VIDEO.json`, where the grader reads it:

```sh
mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
```

## Build notes

- Footage: Rockstar Games' GTA VI Launch Trailer, fetched in the build session with yt-dlp (1080p) and cut with ffmpeg. The raw trailer file is not committed to this repository.
- Moment selection: the trailer is cut every 1.5–3 seconds, so the longest single story beat was scouted frame by frame (scene detection plus frame montages) before the 34.4–37.33s vault stretch was chosen — the most cinematic shot, and the money-raining image sets up the make.fun pitch.
- Vertical format: blurred full-bleed background with the sharp 16:9 picture centred, so nothing is cropped out and the text sits in the blurred bands.

---

Built with an AI agent for the $500 bounty on make.fun: https://make.fun/?ref=5f3j6jyb&utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01
