<script language="ts">
	import Map from '$lib/Map/Map.svelte';
	// import { mapInfo } from '../../stores/index';
	// import { size, slice } from 'lodash-es';

	let mode = 'map';
	let filteredLocations;

	// $: filteredLocations = slice($mapInfo, 0, 60);
</script>

<div class="bg-red-500 text-white">MAP MAP MAP</div>
<span class="h-60">
	<Map mapData={filteredLocations} />
</span>

<style language="postcss">
</style>
