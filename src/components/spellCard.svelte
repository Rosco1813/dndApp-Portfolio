<script>
	export let spellcard;
</script>

<a class="limitCardSize " href={`/spells/${spellcard.index}`}>
	<h2 class="uppercase text-2xl">{spellcard.name}</h2>
</a>

<style>
	.limitCardSize {
		padding: 6px;
		background-color: #f0f0f0;
		color: black;
		text-align: center;
		border-radius: 8px;
		height: 100%;
		/* box-shadow: 5px 5px 10px #b3b3b3, -5px -5px 10px #ffffff; */
		width: 300px;
		/* box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2), inset 0 -2px 5px rgba(255, 255, 255, 0.4); */
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.1), 0 0 10px rgba(0, 0, 0, 0.2);
		display: flex;
		flex-direction: column;
		justify-content: center;
		margin: 4px;
	}
	.limitCardSize:hover {
		box-shadow: 0 0 10px rgba(255, 87, 34, 0.7);
		/* box-shadow: 0 0 10px rgba(255, 0, 0, 0.7), 0 0 20px rgba(255, 165, 0, 0.7); */
		/* box-shadow: 0 0 10px rgba(0, 123, 255, 0.7); */
	}
	a {
		all: unset;
	}
</style>
