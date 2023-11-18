<script>
	export let pokemancard;

	let isHovered = false;

	function handleHover() {
		isHovered = !isHovered;
	}
</script>

<a
	on:mouseenter={handleHover}
	on:mouseleave={handleHover}
	class=" bg-gray-100  pokemonCard"
	href={`/pokemon/${pokemancard.id}`}
>
	<img class="h-40 w-40" src={pokemancard.image} alt={pokemancard.name} />
	{#if isHovered}
		<h2 class="uppercase text-2xl name">{pokemancard.name}</h2>
	{/if}
</a>

<style>
	.pokemonCard {
		padding: 6px;
		color: black;
		text-align: center;
		border-radius: 8px;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.1), 0 0 10px rgba(0, 0, 0, 0.2);
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: fit-content;
		min-width: 200px;
		margin: 5px;
		position: relative;
	}
	.pokemonCard:hover {
		box-shadow: 0 0 10px rgba(0, 123, 255, 0.7);
	}
	.name {
		position: absolute;
		bottom: 0;
		width: 100%;
	}
	a {
		text-decoration: none;
	}
</style>
