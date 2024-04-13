import OpenAI from 'openai'
import 'dotenv/config'


const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

export async function get(request) {
  console.log('== request = ', request)
  const completion = await openai.chat.completions.create({
    messages: [{ role: "system", content: "You are the Dungeon Master and  Game Master, also referred to a GM, DM  of a table top fantasy role playing game and your name is Azmodious" },
    {
      role: 'user',
      content: 'Give me a short intro to a fantasy world and options for how a player can start an adventure, but the players will always start in a Desert town called Kisbee'
    }],
    model: "gpt-3.5-turbo",
  });

  return {
    status: 200,
    body: completion,
  };
}
