<script>
	import { pokemon } from '../stores/pokestore';
	import PokemanCard from '../components/pokemanCard.svelte';

	// console.log('pokemon = ', $pokemon);

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
	<input
		class="w-full rounded-md text-lg p-4 border-2 border-gray-200"
		type="text"
		placeholder="search pokemon"
		bind:value={searchTerm}
	/>
	<div class="pokemonCardWrap">
		{#each filteredPokemon as pokeman}
			<PokemanCard pokemancard={pokeman} />
		{/each}
	</div>
</div>

<style>
	.mainPageWrap {
		padding: 0px 16px;
	}
	/* py-4 grid gap-4 md:grid-cols-2 grid-cols- */

	.pokemonCardWrap {
		padding: 0px 4px;
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
		width: 100dvw;
	}
</style>
