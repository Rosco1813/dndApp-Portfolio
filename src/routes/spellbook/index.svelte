<script>
	import { spells } from '../../stores/spellstore';
	import SpellCard from '../../components/spellCard.svelte';

	let searchTerm = '';
	let filteredSpells = [];

	$: {
		console.log(searchTerm);
		if (searchTerm) {
			filteredSpells = $spells.filter((spell) =>
				spell.name.toLowerCase().includes(searchTerm.toLowerCase())
			);
		} else {
			filteredSpells = [...$spells];
		}
	}
</script>

<div class="spellBookPageWrap">
	<h1 class="sbTitle">svelte pokedex</h1>

	<div class="ssInputWrap">
		<input
			class="spellSearchInput "
			type="text"
			placeholder="search spells"
			bind:value={searchTerm}
		/>
	</div>

	<div class="spellCardWrap">
		{#each filteredSpells as spell}
			<SpellCard spellcard={spell} />
		{/each}
	</div>
</div>

<style>
	/* py-4 grid gap-4 md:grid-cols-2 grid-cols-1 */
	.spellBookPageWrap {
		padding: 0px 16px;
	}
	.spellCardWrap {
		padding: 4px 0px;
		display: flex;
		flex-wrap: wrap;
		justify-content: space-evenly;
		align-items: center;
		width: 97vw;

		/* display: inline-block; */
	}

	.sbTitle {
		font-size: 24px;
		text-align: center;
		margin: 8px 0px;
		text-transform: uppercase;
	}
	/* w-96 rounded-md text-lg p-4 border-2 border-gray-200 */
	.spellSearchInput {
		width: 96px;
		border-radius: 8px;
		font-size: 16px;
		padding: 4px;
		border: 2px solid lightcoral;
		width: 33%;
	}
	@media only screen and (max-width: 640px) {
		/* Styles for screens smaller than 640px go here */
		.spellSearchInput {
			width: 50%;
		}
	}
	.ssInputWrap {
		display: flex;
		justify-content: center;
		width: 100dvw;
	}
</style>
