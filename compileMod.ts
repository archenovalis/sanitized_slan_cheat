// compileMod.ts
import { createWriteStream, readFileSync, readdirSync, statSync } from 'fs';
import { relative, resolve } from 'path';
import { Parser } from 'xml2js';
import archiver from 'archiver';

// Function to extract the version from content.xml
const contentXmlPath = (projectFolder: string) => resolve(__dirname, projectFolder);

const getVersionFromContentXml = async (path: string): Promise<string> => {
  const xml = readFileSync(path+'/content.xml', 'utf8');
  const parser = new Parser();

  try {
    const result = await parser.parseStringPromise(xml);
    return result['content']['$']['version'];
  } catch (error) {
    throw new Error(`Error parsing XML: ${error}`);
  }
};

const addFilesToZip = (archive: archiver.Archiver, dir: string, baseDir: string) => {
  const items = readdirSync(dir);

  items.forEach((item) => {
    const itemPath = resolve(dir, item);
    const stats = statSync(itemPath);

    if (stats.isDirectory()) {
      // Recurse into directories
      addFilesToZip(archive, itemPath, baseDir);
    } else if (stats.isFile() && itemPath.endsWith('.xml')) {
      // Add file to the zip archive, preserving the directory structure
      const relativePath = relative(baseDir, itemPath);
      archive.file(itemPath, { name: relativePath });
    }
  });
};

// Main function to create the zip file
const createZip = (projectFolder: string, sourceDir: string, version: string) => {
  const dateTime = new Date().toISOString().replace(/[:.-]/g, '_');
  const outDir = resolve(__dirname, 'dist');
  const outputZip = `${outDir}/${projectFolder}-v${version}-${dateTime.split('T')[0]}.zip`;
  const output = createWriteStream(outputZip);
  const archive = archiver('zip', {
    zlib: { level: 9 }
  });

  output.on('close', () => {
    console.log(`Archive created successfully: ${outputZip}`);
  });

  archive.on('error', (err: string) => {
    throw err;
  });

  archive.pipe(output);

  addFilesToZip(archive, sourceDir, sourceDir);

  archive.finalize();
};

// Main function to run the script
const run = async () => {
  const projectFolder = process.argv[2]; // Project folder name passed via command line
  if (!projectFolder) {
    console.error('Please provide the project folder as an argument.');
    process.exit(1);
  }

  try {
    const path = contentXmlPath(projectFolder);
    const version = await getVersionFromContentXml(path);
    createZip(projectFolder, path, version);
  } catch (error) {
    console.error(`Error: ${error}`);
  }
};

run();
