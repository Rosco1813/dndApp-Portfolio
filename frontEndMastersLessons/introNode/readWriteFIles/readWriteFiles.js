import {readFile, writeFile} from 'node:fs/promises';
import path from 'node:path';


const readTestPack = async () => {

try {
    const filePath = new URL('./demo.js', import.meta.url);
    console.log('file path = ', filePath)
    const contents = await readFile(filePath, { encoding: 'utf8' });
    console.log(contents);
  } catch (err) {
    console.error(err.message);
  }

}

const writingFile = async ()=>{
    let blurb = 'I am creating a file then executing the code';


    try {
        const fileToWrite = new URL('./demo.js', import.meta.url);
        // const codeToWrite =
         await writeFile(fileToWrite, `console.log('${blurb}')`);
   
    } catch (error) {
        console.error(error.message)
    }
}

// await writingFile().then(readTestPack());
