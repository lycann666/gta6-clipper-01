// main.ts — gta6-clipper-01 entry program (Node 22, standard library only).
//
// Reads VIDEO.json from the repository root, checks that its url is a real
// YouTube video address (a Short, a watch link, or a youtu.be link), and
// copies it to the output directory so the grader can read it.
//
//   MAKEFUN_BOT_DIR     repository root (default ".")
//   MAKEFUN_OUTPUT_DIR  where VIDEO.json is written (default "out")
//
// Exit 0 prints the video address. Anything else exits 1 with a clear
// message on stderr.

import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const botDir = process.env.MAKEFUN_BOT_DIR ?? ".";
const outDir = process.env.MAKEFUN_OUTPUT_DIR ?? "out";

// A YouTube video id is exactly 11 characters of letters, digits, _ and -.
const YOUTUBE_URL =
  /^https:\/\/(?:www\.|m\.)?(?:youtube\.com\/(?:shorts\/|watch\?v=)|youtu\.be\/)([A-Za-z0-9_-]{11})(?:[?&#].*)?$/;

function fail(message: string): never {
  console.error(`error: ${message}`);
  process.exit(1);
}

const inputPath = join(botDir, "VIDEO.json");

let raw: string;
try {
  raw = readFileSync(inputPath, "utf8");
} catch {
  fail(`cannot read ${inputPath}`);
}

let parsed: unknown;
try {
  parsed = JSON.parse(raw);
} catch {
  fail("VIDEO.json is not valid JSON");
}

const url = (parsed as { url?: unknown } | null)?.url;
if (typeof url !== "string" || url.length === 0) {
  fail("VIDEO.json must hold an object with a non-empty string url");
}

if (url.includes("REPLACE_AFTER_UPLOAD") || url.includes("<id>")) {
  fail("VIDEO.json still holds a placeholder URL; put the published video's address in it");
}

const match = YOUTUBE_URL.exec(url);
if (match === null) {
  fail(`not a YouTube video address: ${url}`);
}

mkdirSync(outDir, { recursive: true });
writeFileSync(join(outDir, "VIDEO.json"), `${JSON.stringify({ url })}\n`, "utf8");
console.log(url);
