#!/usr/bin/env node

const { execSync, spawn } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');

// Colors
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
};

const log = {
  info: (msg) => console.log(`${colors.blue}ℹ${colors.reset} ${msg}`),
  success: (msg) => console.log(`${colors.green}✓${colors.reset} ${msg}`),
  warn: (msg) => console.log(`${colors.yellow}⚠${colors.reset} ${msg}`),
  error: (msg) => console.log(`${colors.red}✗${colors.reset} ${msg}`),
};

const HELP = `
${colors.cyan}╔════════════════════════════════════════════╗
║  🚀 Codora - Expo Build & Deploy CLI       ║
╚════════════════════════════════════════════╝${colors.reset}

${colors.yellow}Usage:${colors.reset}
  codora <command> [options]

${colors.yellow}Commands:${colors.reset}
  preview [platform]    Start local dev server
  android               Build Android APK
  ios                   Build iOS IPA
  all                   Build all platforms
  submit <platform>     Submit to app store
  update [message]      OTA hot update
  status                Check EAS login status
  help                  Show this help

${colors.yellow}Examples:${colors.reset}
  codora preview           # Start dev server
  codora preview ios       # iOS simulator
  codora android           # Build APK
  codora ios               # Build IPA
  codora submit ios        # Submit to TestFlight
  codora update "Bug fix"  # OTA update

${colors.yellow}Prerequisites:${colors.reset}
  1. npm install -g eas-cli
  2. eas login
  3. eas build:configure (in project)
`;

function run(cmd, options = {}) {
  try {
    return execSync(cmd, {
      stdio: options.silent ? 'pipe' : 'inherit',
      encoding: 'utf-8',
      ...options
    });
  } catch (err) {
    if (!options.ignoreError) {
      log.error(`Command failed: ${cmd}`);
      process.exit(1);
    }
    return null;
  }
}

function runAsync(cmd, args = []) {
  return new Promise((resolve, reject) => {
    const child = spawn(cmd, args, { stdio: 'inherit', shell: true });
    child.on('close', (code) => {
      if (code === 0) resolve();
      else reject(new Error(`Exit code: ${code}`));
    });
  });
}

function checkPrerequisites() {
  // Check EAS CLI
  const easPath = run('which eas', { silent: true, ignoreError: true });
  if (!easPath) {
    log.error('EAS CLI not installed');
    log.info('Install with: npm install -g eas-cli');
    process.exit(1);
  }

  // Check login
  const whoami = run('eas whoami', { silent: true, ignoreError: true });
  if (!whoami) {
    log.error('Not logged in to Expo');
    log.info('Login with: eas login');
    process.exit(1);
  }

  // Check eas.json
  if (!fs.existsSync('eas.json') && !fs.existsSync('app.json')) {
    log.error('Not in an Expo project directory');
    log.info('Run this command in your Expo project root');
    process.exit(1);
  }

  return whoami.trim();
}

function getProjectName() {
  try {
    if (fs.existsSync('app.json')) {
      const appJson = JSON.parse(fs.readFileSync('app.json', 'utf-8'));
      return appJson.expo?.name || appJson.name || 'app';
    }
  } catch (e) {}
  return 'app';
}

async function preview(platform) {
  log.info('Starting development server...');
  const platformArg = platform ? `--${platform}` : '';
  await runAsync(`npx expo start ${platformArg}`);
}

async function build(platform) {
  const user = checkPrerequisites();
  log.info(`Logged in as: ${user}`);
  log.info(`Building ${platform}...`);

  await runAsync(`eas build --platform ${platform} --profile production --non-interactive`);

  log.success(`${platform} build completed!`);
  log.info('Check https://expo.dev for download link');
}

async function submit(platform) {
  checkPrerequisites();
  log.info(`Submitting ${platform} to store...`);

  await runAsync(`eas submit --platform ${platform} --latest --non-interactive`);

  log.success('Submission completed!');
}

async function update(message) {
  checkPrerequisites();
  const msg = message || 'OTA update';
  log.info(`Publishing OTA update: ${msg}`);

  await runAsync(`eas update --branch production --message "${msg}"`);

  log.success('Update published!');
}

function status() {
  log.info('Checking status...');

  const easPath = run('which eas', { silent: true, ignoreError: true });
  if (easPath) {
    log.success(`EAS CLI: ${easPath.trim()}`);
  } else {
    log.error('EAS CLI: Not installed');
  }

  const whoami = run('eas whoami', { silent: true, ignoreError: true });
  if (whoami) {
    log.success(`Logged in as: ${whoami.trim()}`);
  } else {
    log.warn('Not logged in');
  }

  if (fs.existsSync('eas.json')) {
    log.success('eas.json: Found');
  } else {
    log.warn('eas.json: Not found (run: eas build:configure)');
  }

  if (fs.existsSync('app.json')) {
    const name = getProjectName();
    log.success(`Project: ${name}`);
  }
}

// Main
async function main() {
  const args = process.argv.slice(2);
  const command = args[0];
  const arg1 = args[1];

  if (!command || command === 'help' || command === '--help' || command === '-h') {
    console.log(HELP);
    return;
  }

  try {
    switch (command) {
      case 'preview':
        await preview(arg1);
        break;
      case 'android':
        await build('android');
        break;
      case 'ios':
        await build('ios');
        break;
      case 'all':
        await build('all');
        break;
      case 'submit':
        if (!arg1) {
          log.error('Platform required: codora submit ios|android');
          process.exit(1);
        }
        await submit(arg1);
        break;
      case 'update':
        await update(arg1);
        break;
      case 'status':
        status();
        break;
      default:
        log.error(`Unknown command: ${command}`);
        console.log(HELP);
        process.exit(1);
    }
  } catch (err) {
    log.error(err.message);
    process.exit(1);
  }
}

main();
