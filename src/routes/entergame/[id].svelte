<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { pokemon } from '../../stores/pokestore.js';
	import { openaiResponse } from '../../stores/aistore.js';
	import wizard from './openSourcerer.jpg';
	import GameInput from '../../components/gameInput/gameInput.svelte';
	import PokemanCard from '../../components/pokemanCard.svelte';
	import { load } from '../pokemon/[id].svelte';

	let name = '';
	let correct_Answer = 'Rosco';
	let correct = false;
	let random = randomInteger(1, 898);
	let loaded = false;
	let startingMessage = $openaiResponse.choices[0].message.content;
	let guess = 0;
	let adventureOptions = '';
	let title = '';
	let descriptionParts = '';
	let description = '';
	let introduction = '';
	let storySelected = '';
	let fighterOptions = ['fight', 'examine', 'catch', 'run'];
	let selectedStory = '';
	let showSubmit = false;

	//TODO : Inventory, Weapon
	//select story start, send that to open api and get a new response
	// allow typing into Input to ask DM questions

	let reset = (number) => {
		if (number >= 100) {
			let number = 0;
			console.log('number reset = ', number);
		}
	};

	function randomInteger(min, max) {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	function submitStartingStory(story, title) {
		storySelected = story;
		showSubmit = !showSubmit;

		selectedStory = title;
		console.log('selcted st = ', selectedStory);
		console.log('story selected = ', storySelected);
	}

	onMount(() => {
		const sections = startingMessage.split('\n\n');
		introduction = sections[0]; // Introduction text
		const optionsText = sections.slice(1).join('\n\n'); // Join the remaining
		let options = optionsText.split(/\d+\.\s+/).slice(1);

		adventureOptions = options.map((option) => {
			[title, ...descriptionParts] = option.split(':');
			description = descriptionParts.join(':').trim(); // Rejoin in case
			if (title.startsWith('**')) {
				title = title.substring(2);
			}
			if (description.startsWith('**')) {
				description = description.substring(2);
			}
			return { title: title.trim(), description };
		});
		loaded = true;
	});
</script>

<div class="background">
	{#if !correct}
		<h1 class="enterTitle">Enter the Endless Adventure</h1>
		<div>But First, Submit My Name</div>
	{/if}

	<div class="content">
		{#if !correct}
			<GameInput bind:correct_Answer bind:name bind:guess bind:correct />

			<div class="myName">
				{name}
			</div>
		{/if}

		{#if correct}
			<div class="container">
				{#if loaded}
					<button class="option-button">
						{introduction}
					</button>
					{#each adventureOptions as { title, description }}
						<button on:click={submitStartingStory(description, title)} class="btn">
							<h2 class="title">{title}</h2>
							<div class="description">{description}</div>
						</button>
						{#if selectedStory === title && showSubmit}
							<div class="myName">
								{name}
							</div>

							<GameInput bind:correct_Answer bind:name bind:guess bind:correct />
						{/if}
					{/each}
				{/if}
			</div>

			<p class="fightTime">time to fight</p>
			<div class="fightArena">
				{#each $pokemon as pokeman}
					{#if pokeman.id === random}
						<div class="creatures">
							<div class="character-wrap">
								<img src={wizard} alt="" width="100" height="100" />
							</div>

							<div class="monster">
								<img src={pokeman.image} alt="" width="100" height="100" />
							</div>
						</div>

						<div class="flex  character-controls">
							{#each fighterOptions as option}
								<button class="btn fight-options">
									{option}
								</button>
							{/each}
						</div>
					{/if}
				{/each}
			</div>
		{/if}
		{#if guess >= 1 && !correct}
			<div class="text-red-50">
				X
				{#if guess >= 2}
					X
					{#if guess >= 3}
						X
					{/if}
				{/if}
			</div>
		{/if}

		{#if guess >= 1 && !correct}
			<div>thats not my name bro</div>
		{/if}
	</div>
</div>

<style>
	@import '../../../public/fonts.css';

	.container {
		display: flex;
		flex-direction: column;
		font-family: 'MapleMono-Italic', sans-serif;
		justify-content: center;
	}

	.enterTitle {
		margin: 16px 0px;
	}

	.title {
		display: flex;
		width: 100%;
		justify-content: center;
		text-align: center;
		font-family: 'MapleMono-Italic', sans-serif;
		/* border: linear-gradient(to bottom left, #e65054, #f0c33c 70%) 1px solid; */
		color: white;
		/* color: #e65054; */
		/* #f0c33c */
		/* background: linear-gradient(to bottom left, #e65054, #f0c33c 70%); */
	}

	.option-button {
		display: flex;
		flex-direction: column;
		border: 1px solid black;
		border-radius: 12px;
		font-size: 20px;
		margin-bottom: 8px;
		padding: 8px;
		text-align: center;
		background-color: rgba(255, 255, 255, 0.1);
		backdrop-filter: blur(10px);
		-webkit-backdrop-filter: blur(10px);
		cursor: pointer;
		outline: none;
		font-family: 'MapleMono-Italic', sans-serif;
	}

	.character-controls {
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
	}
	.character-wrap {
		height: fit-content;
	}

	.monster {
		height: fit-content;
	}
	.creatures {
		display: flex;
		width: 100%;
		justify-content: space-evenly;
	}

	.fight-options {
		font-family: 'MapleMono-Italic', sans-serif;
	}
	.btn {
		margin: 10px;
		padding: 10px;
		font-size: 1.1em;
		cursor: pointer;
		border: none;
		border-radius: 5px;
		transition: all 0.4s;
	}

	.btn:hover {
		border-radius: 5px;
		transform: translateY(-10px);
		box-shadow: 0 7px 0 -2px #f85959, 0 15px 0 -4px #39a2db, 0 16px 10px -3px #39a2db;
	}

	.btn:active {
		transition: all 0.2s;
		transform: translateY(-5px);
		box-shadow: 0 2px 0 -2px #f85959, 0 8px 0 -4px #39a2db, 0 12px 10px -3px #39a2db;
	}

	.option-button:hover {
		box-shadow: 0 0 10px rgba(0, 123, 255, 0.7);
		cursor: pointer;
	}

	@keyframes typing {
		from {
			width: 0;
		}
	}
	.fightArena {
		width: 100%;
		display: flex;
		justify-content: space-evenly;
		flex-direction: column;
		margin-bottom: 40px;
	}
	.myName {
		display: flex;
		justify-content: center;
		/* Set the width of the container */
		overflow-wrap: break-word; /* Ensures words break to prevent overflow */
		word-wrap: break-word; /* Older browsers support, same as overflow-wrap */
		white-space: normal; /* Ensures whitespace is handled normally, allowing wrapping */
	}

	.fightTime {
		padding: 20px 0px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-family: 'MapleMono-Italic', sans-serif;
	}

	h1 {
		color: white;
	}

	.background {
		background-color: black;
		background-image: radial-gradient(rgba(0, 150, 0, 0.75), black 120%);
		height: 100vh;
		width: 100%;
		color: white;
		font: 1.3rem Inconsolata, monospace;
		text-shadow: 0 0 5px #c8c8c8;
	}

	.content {
		min-height: calc(100vh - 120px);
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		padding: 16px 32px;
	}

	:global(*) {
		box-sizing: border-box;
	}

	.background {
		background-image: radial-gradient(rgba(0, 150, 0, 0.75), black 120%);
		display: flex;
		flex-direction: column;
		height: 100%;
		justify-content: center;
		align-items: center;
		touch-action: none;
	}
</style>
