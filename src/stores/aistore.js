
import { onMount } from 'svelte';
import { writable } from 'svelte/store';

// This store will hold the fetched data
export const openaiResponse = writable(null);


async function fetchOpenAIData() {
  try {
    const response = await fetch('/api/openai');
    if (!response.ok) {
      throw new Error(`Error: ${response.statusText}`);
    }
    const data = await response.json();
    console.log('data ', data)
    openaiResponse.set(data);
    // localStorage.setItem('aiResponse', data)
  } catch (error) {
    console.error('Failed to fetch OpenAI data:', error.message);
    openaiResponse.set(null);
  }
}
await fetchOpenAIData();

// Fetch data when the component mounts
// onMount( async () => {
  // const storedValue = localStorage.getItem('aiResponse');
  // if(storedValue){
  //   console.log('check local storage aiResponse')
  // }else{
  // }
// });




// import 'dotenv/config'
// import { openai } from '../routes/api/openai.js'



// const openai = new OpenAI({ apiKey: process.env.VITE_OPENAI_API_KEY });

// export async function get(request) {
//     const completion = await openai.chat.completions.create({
//         messages: [{ role: "system", content: "You are the Game Master of a table top fantasy role playing game and your name is Azmodious" },
//         {
//             role: 'user',
//             content: 'Give me a short intro to a fantasy world and options for how a player can start an adventure'
//         }],
//         model: "gpt-3.5-turbo",
//     });
  
//     return {
//         status: 200,
//         body: completion,
//     };
// }

// import { writable } from "svelte/store";
// auto importing env varible



// const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
// export const results = writable([]);

// async function main() {
//     const completion = await openai.chat.completions.create({
//         messages: [{ role: "system", content: "You are the Game Master of a table top fantasy role playing game and your name is Azmodious" },
//         {
//             role: 'user',
//             content: 'Give me a short intro to a fantasy world and options for how a player can start an adventure'
//         }],
//         model: "gpt-3.5-turbo",
//     });

//     results.set(completion)
//     console.log('Completion choices : ', completion.choices[0].message);
// }

// await main();


//Roles : [assistant, function, system, user]