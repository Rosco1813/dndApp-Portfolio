<script>
	import { pokemon } from '../stores/pokestore';
	import PokemanCard from '../components/pokemanCard.svelte';

	let searchTerm = '';
	let filteredPokemon = [];

	$: {
		console.log(searchTerm);
		if (searchTerm) {
			filteredPokemon = $pokemon.filter((pokeman) =>
				pokeman.name.toLowerCase().includes(searchTerm.toLowerCase())
			);
		} else {
			filteredPokemon = [...$pokemon];
		}
	}
</script>

<div class="mainPageWrap">
	<h1 class="text-4xl text-center my-8 uppercase">svelte pokedex</h1>
	<div class="piWrap">
		<input class="pokeInput" type="text" placeholder="search pokemon" bind:value={searchTerm} />
	</div>
	<div class="doubleWrap">
		<div class="pokemonCardWrap">
			{#each filteredPokemon as pokeman}
				<PokemanCard pokemancard={pokeman} />
			{/each}
		</div>
	</div>
</div>

<style>
	.mainPageWrap {
		padding: 0px 16px;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	.doubleWrap {
		display: flex;
		width: 100%;
		justify-content: center;
	}

	.pokeInput {
		width: 50dvw;
		border-radius: 8px;
		font-size: 16px;
		padding: 0px 4px;
		border: 2px solid lightcoral;
	}
	.piWrap {
		display: flex;
		justify-content: center;
		height: 50px;
	}
	.pokemonCardWrap {
		padding: 0px 4px;
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
		width: 100dvw;
		max-width: 1000px;
	}
</style>
