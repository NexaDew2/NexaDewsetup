#!/usr/bin/env node
import { execSync } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const args = process.argv.slice(2);
const componentName = args[0];

if (!componentName) {
  console.error('❌ Please provide a component name.');
  process.exit(1);
}

const setupScript = join(__dirname, '../setup.sh');

try {
  execSync(`bash "${setupScript}" "${componentName}"`, { stdio: 'inherit' });
} catch (error) {
  console.error('❌ Error running setup script:', error.message);
  process.exit(1);
}
