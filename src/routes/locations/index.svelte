<script language="ts">
	import Map from '$lib/Map/Map.svelte';
	// import { mapInfo } from '../../stores/index';
	// import { size, slice } from 'lodash-es';

	let mode = 'map';
	let filteredLocations;

	// $: filteredLocations = slice($mapInfo, 0, 60);
</script>

<!-- <div class="bg-red-500 text-white">MAP MAP MAP</div> -->
<div class="h-60 map-wrap">
	<Map mapData={filteredLocations} />
</div>

<style language="postcss">
	.map-wrap {
		/* border: 1px solid black;
		width: 100%; 
		height: 500px; 
		position: relative; 
		overflow: hidden; */
	}
</style>
