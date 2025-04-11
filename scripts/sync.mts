#!/usr/bin/env -S yarn tsx

import path from "node:path";
import url from "node:url";
import fs from "node:fs/promises";
import { cleanEnv, str } from "envalid";
import yargs from "yargs";
import consola from "consola";
import { match } from "ts-pattern";

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const args = await yargs(process.argv.slice(2))
  .scriptName("sync")
  .usage('$0 <cmd> [args]')
  .version(false)
  .describe("target", "Sync files: 'remote' = repo & 'local' = local machine")
  .option("target", {
    alias: "t",
    type: "string",
    choices: ["remote", "local"],
    default: "remote",
  })
  .parseAsync();
  
const timeStamp = Date.now();
const env = cleanEnv(process.env, {
	HOME: str({ default: "~" }),
	ZSH: str({ default: "~/.oh-my-zsh" }),
});
const repoRootPath = path.join(__dirname, "..");
const dotFilesPath = path.join(repoRootPath, "dotfiles");
const backupPath = path.join(repoRootPath, '.bak', `sync-${timeStamp}`);

console.log(`---[${timeStamp}]---`);
consola.start(`Syncing files to: ${getTargetHumanReadable(args.target)}`);

await initBackupDir();

const dotfiles = await fs.readdir(dotFilesPath, { withFileTypes: true });
for (const file of dotfiles) {
  if (file.isDirectory()) {
    continue;
  }

  const dotfile = getDotfileConfig(file.name);

  if (!dotfile) {
    continue;
  }

  const sourceFile = match(args.target as "remote" | "local")
    .with("remote", () => dotfile.remote)
    .with("local", () => dotfile.local)
    .exhaustive();

  const destinationFile = match(args.target as "remote" | "local")
    .with("remote", () => dotfile.local)
    .with("local", () => dotfile.remote)
    .exhaustive();

  const sourceFileContents = await fs.readFile(sourceFile, "utf-8");
  const destinationFileContents = await fs.readFile(destinationFile, "utf-8");

  if (sourceFileContents === destinationFileContents) {
    consola.info(`${file.name} is up to date`);
    continue;
  }

  await backupFile(destinationFile);
  await fs.writeFile(destinationFile, sourceFileContents);

  consola.info(`Syncing ${file.name}...`);
}

consola.success(`[${timeStamp}] Syncing complete`);
console.log(`---[${timeStamp}]---`);

// ================================
// ====      Internals         ====
// ================================

async function exists(path: string) {
  try {
    await fs.access(path);
    return true;
  } catch (error) {
    return false;
  }
}

async function backupFile(filePath: string) {
  const backupPath = path.join(repoRootPath, '.bak', `sync-${timeStamp}`);
  await fs.mkdir(backupPath, { recursive: true });
  await fs.cp(filePath, path.join(backupPath, filePath.replace(env.HOME, "(home)")), { recursive: true });
}

async function initBackupDir() {
  const backupPath = path.join(repoRootPath, '.bak', `sync-${timeStamp}`);
  
  if (await exists(backupPath)) {
    throw new Error(`Backup directory already exists: ${backupPath}`);
  }

  await fs.mkdir(backupPath, { recursive: true });
  await fs.writeFile(path.join(backupPath, "args.log"), JSON.stringify(args, null, 2));
}

function getTargetHumanReadable(target: string) {
  return target === "remote" ? "this repo" : "your local machine";
}

function getDotfileConfig(name: string) {
  const dotfileMap = {
    ".zshrc": {
      remote: path.join(env.HOME, ".zshrc"),
      local: path.join(dotFilesPath, ".zshrc"),
    },
  } satisfies Record<string, { remote: string; local: string }>;

  return dotfileMap[name as keyof typeof dotfileMap];
}
