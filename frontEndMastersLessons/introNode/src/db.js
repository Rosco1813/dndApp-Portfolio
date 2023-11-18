import {readFile, writeFile} from 'node:fs/promises';

const DB_PATH = new URL('../db.json', import.meta.url);

export const getDB = async () => {
    try {
        const db = await readFile(DB_PATH, {encoding:'utf8'});
        console.log('data base = ', db )
        //do i need json parse ? 
        return JSON.parse(db)
    } catch (error) {
        console.log('error = ',error)
    }
}

export const saveDB = async (db) =>{
    await writeFile(DB_PATH, JSON.stringify(db, null, 2))
}

export const insertDB = async (note) =>{
    const db = await getDB()
    db.notes.push(note)
    await saveDB(db)
    return note
}