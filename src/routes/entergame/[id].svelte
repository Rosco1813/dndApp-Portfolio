<script>
	import { onMount, onDestroy } from 'svelte';
	import About from '../howto/character.svelte';
	import { pokemon } from '../../stores/pokestore.js';
	import { openaiResponse } from '../../stores/aistore.js';
	import PokemanCard from '../../components/pokemanCard.svelte';
	import wizard from './openSourcerer.jpg';
	import { load } from '../pokemon/[id].svelte';
	// import wizard from '../../../static/openSourcerer.jpg';
	// import { Motion, useMotionValue, useMotionTemplate } from 'svelte-motion';
	let name = '';
	let searchTerm = '';
	let correct_Answer = 'Rosco';
	let correct = false;
	let filteredPokemon = [];
	let random = randomInteger(1, 898);
	let area;
	let loaded = false;
	// let up = 0;
	// let down = 0;
	// let left = 0;
	// let right = 0;
	let number;
	let startingMessage = $openaiResponse.choices[0].message.content;
	// let startingMessage = '';
	let guess = 0;
	let options = '';
	let adventureOptions = '';
	let title = '';
	let descriptionParts = '';
	let description = '';
	let introduction = '';

	// const x = useMotionValue(0);
	// const y = useMotionValue(0);
	// const shadow = useMotionTemplate`drop-shadow(${x}px ${y}px 20px rgba(0,0,0,0.8))`;
	// $: {
	// 	console.log('the name is Rosco you passed puzzle 1');
	// }
	$: if (name === correct_Answer) {
		correct = true;
	}

	const typingDelay = 800;

	// Call the function to start typing effect

	function submit_Answer() {
		if (name != correct_Answer) {
			correct = false;
			guess++;
			if (guess >= 3) {
				window.location.href = '/locations';
			}

			console.log('correct ? ', correct);
		}
	}

	let reset = (number) => {
		if (number >= 100) {
			let number = 0;
			console.log('number reset = ', number);
		}
	};

	function randomInteger(min, max) {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	onMount(() => {
		console.log('loaded ', loaded);
		// Add the event listener when the component mounts
		// localStorage.setItem('aiResponse', startingMessage);
		// startingMessage = localStorage.getItem('aiResponse');
		console.log('starting message = ', $openaiResponse.choices[0]);
		// options = startingMessage.split(/\d+\.\s+\*\*/).slice(1); // Remove the first empty entry
		const sections = startingMessage.split('\n\n');
		introduction = sections[0]; // Introduction text
		const optionsText = sections.slice(1).join('\n\n'); // Join the remaining sections in case there are multiple paragraphs of options

		// Splitting the options section into an array of options
		let options = optionsText.split(/\d+\.\s+/).slice(1);
		console.log('options = ', options);
		adventureOptions = options.map((option) => {
			[title, ...descriptionParts] = option.split(':');
			description = descriptionParts.join(':').trim(); // Rejoin in case there are multiple ":**" in the description
			if (title.startsWith('**')) {
				// Remove the ** characters from the beginning
				title = title.substring(2);
			}
			if (description.startsWith('**')) {
				// Remove the ** characters from the beginning
				description = description.substring(2);
			}
			return { title: title.trim(), description };
		});

		loaded = true;

		// Return a cleanup function that Svelte will run when the component is destroyed
	});
</script>

<div class="background">
	About

	<h1>Enter the Endless Adventure</h1>

	<div class="content">
		<span>
			<div class="form__group field m-12">
				<input
					autocomplete="off"
					bind:value={name}
					type="input"
					class="form__field text-black"
					placeholder="Name"
					name="name"
					id="name"
					required
				/>
				<label for="name" class="form__label" />
				<button on:click={submit_Answer}>submit</button>
			</div>
			<div class="myName">
				{name}
			</div>
			<!-- {#if guess >= 1 && !correct} -->
			<div class="container">
				{#if loaded}
					<!-- <div
						style="display: flex; flex-direction:column; border: 1px solid black; border-radius:12px; font-size:20px; margin-bottom:8px; padding:8px; text-align:center;     background-color: rgba(255, 255, 255, 0.1); 
				backdrop-filter: blur(10px);
				-webkit-backdrop-filter: blur(10px);"
						class="option"
					>
						{introduction}
					</div> -->
					<button class="option-button">
						<!-- {introduction} -->
						{introduction}
					</button>
					{#each adventureOptions as { title, description }}
						<button class="option-button">
							<!-- {introduction} -->
							<h2 class="title">{title}</h2>
							<div class="description">{description}</div>
						</button>

						<!-- <div
							style="display: flex; flex-direction:column; border: 1px solid black; border-radius:12px; font-size:20px; margin-bottom:8px; padding:8px; text-align:center;     background-color: rgba(255, 255, 255, 0.1); 
							backdrop-filter: blur(10px);
							-webkit-backdrop-filter: blur(10px);"
							class="option"
						>
						
							<h2>
								{title}
							</h2>
							<div class="description">{description}</div>
						</div> -->
					{/each}
				{/if}
			</div>
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
		</span>

		{#if correct}
			<div class="">
				Good Guess, oh shit! you have encountered a wild beast, what ever will you do?!
			</div>
			<p class="fightTime">time to fight</p>
			<div class="fightArena">
				{#each $pokemon as pokeman}
					{#if pokeman.id === random}
						<div>
							<img src={wizard} alt="" width="100" height="100" />
							<span class="flex flex-col">
								<button class="bg-slate-500 m-2 h-4 w-24">fight</button>
								<button class="bg-slate-500 m-2 h-4 w-24">examine</button>
								<button class="bg-slate-500 m-2 h-4 w-24">catch</button>
							</span>
						</div>
						<div class="monster">
							<img src={pokeman.image} alt="" width="100" height="100" />
						</div>
						<div class="shadow" style="" />
					{/if}
				{/each}
			</div>
		{/if}
		{#if guess >= 1 && !correct}
			<div>thats not my name bro</div>
		{/if}
	</div>
</div>

<style>
	@import '../../../public/fonts.css';
	/* .typing-animation {
		overflow: hidden;
		white-space: nowrap;
		animation: typing 2s steps(30, end);
	} */
	/* .option:hover {
	
	} */
	.title {
		display: flex;
		width: 100%;
		justify-content: center;
		text-align: center;
		font-family: 'MapleMono', sans-serif;
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
		cursor: pointer; /* Make the button behave like a clickable element */
		outline: none; /* Remove default outline when focused */
		font-family: 'MapleMono-Italic', sans-serif;
	}

	.option-button h2 {
		margin: 0; /* Remove default margin for better alignment */
	}

	.option-button:hover {
		/* Add hover styles if desired */
		box-shadow: 0 0 10px rgba(0, 123, 255, 0.7);
		cursor: pointer;
	}

	@keyframes typing {
		from {
			width: 0;
		}
	}
	.fightArena {
		display: flex;
		width: 100dvw;
		justify-content: space-evenly;
	}
	.myName {
		display: flex;
		justify-content: center;
	}
	.shadow {
		background-image: black;
		padding: 10px;
		height: 5px;
		width: 10px;
		border-radius: 50%;
	}
	.fightTime {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	h1 {
		color: white;
	}
	.background {
		background-color: black;
		background-image: radial-gradient(rgba(0, 150, 0, 0.75), black 120%);
		height: 100vh;
		color: white;
		font: 1.3rem Inconsolata, monospace;
		text-shadow: 0 0 5px #c8c8c8;
	}

	.content {
		min-height: calc(100vh - 120px);
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		padding: 16px;
		width: 100dvw;

		/* 80px header + 40px footer = 120px  */
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

	.box {
		background: radial-gradient(rgba(0, 150, 0, 0.75), black 420%);
		border-radius: 30px;

		position: absolute;
		top: calc(50% - 150px / 2);
		left: calc(50% - 150px / 2);
	}
	.drag-area {
		opacity: 0.2;

		position: absolute;
		width: 400px;
		height: 400px;
		border-radius: 30px;
		top: calc(50% - 150px);
		left: calc(50% - 150px);
	}
	.unselectable {
		-webkit-touch-callout: none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	.center {
		justify-content: center;
		align-items: center;
		display: flex;
	}
</style>
