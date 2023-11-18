import {jest} from '@jest/globals';

// https://jestjs.io/docs/getting-started
//link to jest which is industry standard for running tests on code, 
//a wrapper around node that allows for extra global helper functions 
// want a test to be moduler and stateless aka clear out data 
jest.unstable_mockModule('../src/db.js', ()=>({
    insertDB: jest.fn(),
    getDB: jest.fn(),
    saveDB: jest.fn()
}));

const {insertDB, getDB, saveDB} = await import('../src/db.js');
const {newNote, getAllNotes, removeNote} = await import('../src/notes.js');

beforeEach(() =>{
    insertDB.mockClear();
    getDB.mockClear();
    saveDB.mockClear();
})

describe('ROSS CLI NOTES APP TEST', () => {

    test('newNote inserts data and returns it', async () => {
        const note = 'ross notes test';
        const tags = ['yippee', 'boo'];
        const data = {
          tags,
          content: note,
          id: 1,
        };
        insertDB.mockResolvedValue(data);
      
        const result = await newNote(note, tags);
        expect(result.content).toEqual(data.content);
        expect(result.tags).toEqual(data.tags);
      });
      
      test('getAllNotes returns all notes', async () => {
        const db = {
          notes: ['note1', 'note2', 'note3']
        };
        getDB.mockResolvedValue(db);
      
        const result = await getAllNotes();
        expect(result).toEqual(db.notes);
      });
      
      test('removeNote does nothing if id is not found', async () => {
        const notes = [
          { id: 1, content: 'note 1' },
          { id: 2, content: 'note 2' },
          { id: 3, content: 'note 3' },
        ];
        saveDB.mockResolvedValue(notes);
      
        const idToRemove = 4;
        const result = await removeNote(idToRemove);
        expect(result).toBeUndefined();
      });
})
