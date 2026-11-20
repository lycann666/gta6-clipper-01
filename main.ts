// gta6-clipper-01 entry for make.fun: hand the video's address to the grader.
//
// The entry is the YouTube video itself: a vertical Short cut from Rockstar's
// GTA VI Launch Trailer (the vault walk, trailer time 34.4s -> 37.33s), with a
// make.fun pitch spoken through on-screen text. The clip is made by the
// ffmpeg recipe in build-clip.sh; this program only delivers VIDEO.json.
//
// Run by the grader as:  MAKEFUN_BOT_DIR=<repo> MAKEFUN_OUTPUT_DIR=/output
//   node main.ts
// It reads VIDEO.json from the repository root, refuses a placeholder
// address loudly (so a half-finished entry can never be submitted by
// accident), and writes the validated address to /output/VIDEO.json.
//
// Node 22, standard library only.

import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

const BOT_DIR = process.env.MAKEFUN_BOT_DIR ?? '/bot';
const OUTPUT_DIR = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';
const VIDEO_PATH = join(BOT_DIR, 'VIDEO.json');

function fail(message: string): never {
  console.error(`gta6-clipper-01: ${message}`);
  process.exit(1);
}

let raw: string;
try {
  raw = readFileSync(VIDEO_PATH, 'utf8');
} catch {
  fail(`could not read ${VIDEO_PATH}`);
}

let video: unknown;
try {
  video = JSON.parse(raw);
} catch {
  fail('VIDEO.json is not valid JSON');
}

if (typeof video !== 'object' || video === null) {
  fail('VIDEO.json must be a JSON object with a "url" field');
}
const url = (video as { url?: unknown }).url;
if (typeof url !== 'string' || url.length === 0) {
  fail('VIDEO.json must carry a "url" string');
}

let parsed: URL;
try {
  parsed = new URL(url);
} catch {
  fail(`VIDEO.json url is not a valid URL: ${url}`);
}
const host = parsed.hostname.toLowerCase();
if (host !== 'www.youtube.com' && host !== 'youtube.com' && host !== 'youtu.be') {
  fail(`VIDEO.json url is not a YouTube address: ${url}`);
}
if (url.includes('REPLACE_AFTER_UPLOAD') || url.includes('<id>')) {
  fail(
    'VIDEO.json still holds the placeholder address: upload clip.mp4 to ' +
      'YouTube as a public Short, then put its real address in VIDEO.json',
  );
}

mkdirSync(OUTPUT_DIR, { recursive: true });
writeFileSync(join(OUTPUT_DIR, 'VIDEO.json'), `${JSON.stringify({ url }, null, 2)}\n`);
console.log(`gta6-clipper-01: VIDEO.json -> ${url}`);
