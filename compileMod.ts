// compileMod.ts
import { createWriteStream, existsSync, readFileSync, readdirSync, statSync, writeFileSync } from 'fs';
import { extname, relative, resolve } from 'path';
import { Parser } from 'xml2js';
import archiver from 'archiver';

const parser = new Parser();

const getAllowedExtensions = (projectPath: string): string[] => {
  const configPath = resolve(projectPath, 'allowedExtensions');
  
  if (existsSync(configPath)) {
    const config = JSON.parse(readFileSync(configPath, 'utf-8'));
    if (config.filetypes) {
      return config.filetypes || ['.xml'];
    }
    else {
      throw new Error('allowedExtensions file error');
    }
  } else {
    return ['.xml'];
  }
};

const projectPath = (projectFolder: string) => resolve(__dirname, projectFolder);

const getVersionFromContentXml = async (path: string): Promise<string> => {
  const xml = readFileSync(path+'/content.xml', 'utf8');

  try {
    const result = await parser.parseStringPromise(xml);
    return result['content']['$']['version'];
  } catch (error) {
    throw new Error(`Error parsing XML: ${error}`);
  }
};

const addFilesToZip = (projectFolder: string, archive: archiver.Archiver, dir: string, baseDir: string, allowedExtensions: string[]) => {
  const items = readdirSync(dir);

  items.forEach(async (item) => {
    const itemPath = resolve(dir, item);
    const stats = statSync(itemPath);
    const ext = extname(itemPath).toLowerCase()
    if (stats.isDirectory()) {
      addFilesToZip(projectFolder, archive, itemPath, baseDir, allowedExtensions);
    } else if (stats.isFile() && allowedExtensions.includes(ext)) {
      const relativePath = relative(baseDir, itemPath);
      if (itemPath.endsWith('.xml')) {
        // removes ../../.*/ from schema
        const xml = readFileSync(itemPath, 'utf8').replace(/SchemaLocation\=\"\.\.\/.*xsd\//g, 'SchemaLocation="');
        archive.append(xml, { name: relativePath }); 
      } else {
        archive.file(resolve(projectFolder, itemPath), { name: relativePath });
      }
    }
  });
};

// Main function to create the zip file
const createZip = (projectFolder: string, sourceDir: string, version: string, allowedExtensions: string[]) => {
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

  addFilesToZip(projectFolder, archive, sourceDir, sourceDir, allowedExtensions);

  archive.finalize();
};

const run = async () => {
  const projectFolder = process.argv[2];
  if (!projectFolder) {
    console.error('Please provide the project folder as an argument.');
    process.exit(1);
  }

  try {
    const path = projectPath(projectFolder);
    const version = await getVersionFromContentXml(path);
    const allowedExtensions = getAllowedExtensions(path);
    createZip(projectFolder, path, version, allowedExtensions);
  } catch (error) {
    console.error(`Error: ${error}`);
  }
};

run();
