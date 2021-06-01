/**
 * Given a list of file names and a directory with files
 * find all the files matching in the directory matching the file name in the list
 */

const fs = require('fs');
const readline = require('readline');

const askQuestion = query => {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  return new Promise(resolve =>
    rl.question(query, ans => {
      rl.close();
      resolve(ans);
    })
  );
};

const parseInput = async () => {
  let [, , filesList, inputDir, outputDir] = process.argv;
  let promptConfirm = false;
  if (!filesList) {
    console.log('ERROR: please provide a list of files');
    process.exit();
  }
  if (!inputDir) {
    promptConfirm = true;
    inputDir = './';
    console.log(`WARNING: no input directory provided. "${inputDir}" will be used.`);
  }
  if (!outputDir) {
    promptConfirm = true;
    outputDir = './found_files';
    console.log(`WARNING: no input directory provided. "${outputDir}" will be used.`);
  }
  if (promptConfirm) {
    const ans = await askQuestion('Are you sure you want to proceed? ');
    if (ans.toLowerCase() !== 'y' && ans.toLowerCase() !== 'yes') {
      process.exit();
    }
  }

  console.log(
    `Proceeding searching for files in ${inputDir} as defined in list ${filesList}, and moving them to ${outputDir}`
  );
  const ans = await askQuestion('Are you sure you want to proceed? ');
  if (ans.toLowerCase() !== 'y' && ans.toLowerCase() !== 'yes') {
    process.exit();
  }
  return {filesList, inputDir, outputDir};
};

const getFullPath = (file, dir) => {
  let found = false;
  const walkSync = dir => {
    const files = fs.readdirSync(dir);
    for (let i = 0; i < files.length; i++) {
      const f = files[i];
      const path = `${dir}/${f}`;
      if (fs.statSync(path).isDirectory()) {
        if (!found) {
          walkSync(path);
        }
      } else if (file.trim() === f.trim()) {
        found = path;
        return;
      }
    }
  };
  walkSync(dir);
  return found;
};

const moveFileToDir = (filePath, fileName, dir) => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir);
  }
  return fs.copyFile(filePath, `${dir}/${fileName}`, () => {});
};

const run = async () => {
  const {filesList, inputDir, outputDir} = await parseInput();

  const readInterface = readline.createInterface({
    input: fs.createReadStream(filesList)
  });
  const promises = [];
  console.log('Starting reading files list...');
  const readInterval = setInterval(() => {
    console.log('.');
  }, 1000);
  readInterface
    .on('line', file => {
      const path = getFullPath(file, inputDir);
      if (path) {
        promises.push(moveFileToDir(path, file, outputDir));
      }
    })
    .on('close', async () => {
      clearInterval(readInterval);
      console.log('Copying files list...');
      const copyInterval = setInterval(() => {
        console.log('.');
      }, 1000);
      await Promise.all(promises);
      clearInterval(copyInterval);
      console.log('Done!');
    });
};

run();
