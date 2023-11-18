<script>
	// import * as _ from 'lodash';
	// import { session } from '$app/stores';
	import mapboxgl from 'mapbox-gl';
	import { onMount } from 'svelte';
	import customWorldMap from './fullMap.jpg';

	const DEFAULT_ZOOM = 5;
	const DEFAULT_LNG = 37.015;
	const DEFAULT_LAT = 39.7505;
	const CONTAINER_ID = 'directory-map';

	const geojson = {
		type: 'FeatureCollection',
		features: [
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [37.015, 39.7505]
				},
				properties: {
					title: 'Mapbox',
					description: 'Kisbee',
					notes:
						'1st main city of the heroes, ransacked by a hored or Were-Jackles in order to kidnap the local leaders son and a precious magical relic, the leader: Anas, kidnapped son: Vaylor who was rescued by the party but is now currently in a dark magic coma caused by Azmodious and an ancient demon thirsty for freedom'
				}
			},
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [36.336, 41.2797]
				},
				properties: {
					title: 'Mapbox',
					description: 'Tyr',
					notes: 'major northern  city of Mir-aq on the coast of the Sea of Alexandrite'
				}
			},
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [36.1756, 36.5847]
				},
				properties: {
					title: 'Mapbox',
					description: 'Ank.',
					notes:
						'The twin city gate to the Gemini River large bridge stretches accross to block all traffic'
				}
			},
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [35.482, 38.7205]
				},
				properties: {
					title: 'Mapbox',
					description: 'Bedlum.',
					notes:
						'swampy city home to the theives guild final port at the end of the Gemini River. Home to the merchant prince donavin found to be one of Azmodiouses henchmen along with salazar and cranston, Donavin was  put in charge of housing the were jackals, donavin was killed by the party and his pearl ring was taken by chodling which can control the were-jackals'
				}
			},
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [33.211, 32.524]
				},
				properties: {
					title: 'Mapbox',
					description: 'Carthog.',
					notes: 'last known location of the Evil Wizard Azmodious'
				}
			},
			{
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [29.2842, 40.6549]
				},
				properties: {
					title: 'Mapbox',
					description: 'An-kara.',
					notes: 'capital city of Mir-aq home to the kingdoms young empress'
				}
			}
		]
	};

	export let mapData = [];

	let map;
	let innerWidth;
	let show = false;
	// let capital = geojson.features[0];
	// $: capital;
	let mainPoint = { type: 'FeatureCollection', features: [geojson.features[0]] };

	let click = () => {
		show = !show;
	};

	onMount(async () => {
		mapboxgl.accessToken =
			'pk.eyJ1Ijoicm9zY28yMzQyIiwiYSI6ImNsMm00ZWp3ZDB0eHMza214emhsZnpoem8ifQ.HWX6QvBKVAqQcPa8MCM7gQ';
		map = new mapboxgl.Map({
			container: CONTAINER_ID,
			style: 'mapbox://styles/mapbox/satellite-v9',
			center: [37.015, 39.7505],
			zoom: 4.5
		});

		/////////////////////////////////////////////////////////	/////////////////

		///////////////////////////////////////////////////////////////////////////

		map.on('load', async () => {
			// add markers to map
			// Add a GeoJSON source with 3 points.
			map.addSource('points', {
				type: 'geojson',
				data: geojson
			});
			map.addSource('mainPoint', {
				type: 'geojson',
				data: mainPoint
			});
			// Add a circle layer
			map.addLayer({
				id: 'circle',
				type: 'circle',
				source: 'points',
				paint: {
					'circle-color': '#4264fb',
					'circle-radius': 8,
					'circle-stroke-width': 2,
					'circle-stroke-color': '#ffffff'
				}
			});

			let locations = geojson.features;
			// console.log('locations == ', locations);
			locations.forEach((cities) => {
				// console.log('cities', cities);
				if (cities.properties.description === 'Kisbee') {
					// capital = cities;
					// setTimeout(() => {
					map.addLayer({
						id: 'kisbee',
						type: 'circle',
						source: 'mainPoint',
						paint: {
							'circle-color': 'green',
							'circle-radius': 10,
							'circle-stroke-width': 3,
							'circle-stroke-color': 'red'
						}
					});
					// }, 500);

					// console.log('capital', capital);
					// console.log('main point ', mainPoint);
				}
			});

			//////////////////////////////////////
			// Center the map on the coordinates of any clicked circle from the 'circle' layer.
			map.on('click', 'circle', (e) => {
				map.flyTo({
					center: e.features[0].geometry.coordinates
				});
				console.log('e == ', e);
				// If the user clicked on one of your markers, get its information.
				const features = map.queryRenderedFeatures(e.point, {
					layers: ['circle'] // replace with your layer name
				});
				if (!features.length) {
					return;
				}
				const feature = features[0];
				console.log('feature == ', feature);
				const popup = new mapboxgl.Popup({ offset: [0, -15] })
					.setLngLat(feature.geometry.coordinates)
					.setHTML(
						`<div class="p-4 bg-[#171c1e] border-4 border-[#deba6f]  ">
						<p class='text-red-500 font-bold text-lg'> 
						${feature.properties.description}
						</p>
					
					<p class='text-white text-md'>
						${feature.properties.notes}</p>
						</div>
						`
					)
					.addTo(map);
			});

			// Change the cursor to a pointer when the it enters a feature in the 'circle' layer.
			map.on('mouseenter', 'circle', () => {
				map.getCanvas().style.cursor = 'pointer';
			});

			// Change it back to a pointer when it leaves.
			map.on('mouseleave', 'circle', () => {
				map.getCanvas().style.cursor = '';
			});
		});
	});
</script>

<svelte:window bind:innerWidth />
<svelte:head>
	<link href="https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css" rel="stylesheet" />
</svelte:head>
<div class="flex flex-col justify-center">
	<div id={CONTAINER_ID} style="height:600px; width:80%;" class="self-center" />
	<span>
		<button on:click={click} class="bg-blue-500 p-4 rounded h-18 w-20 ">show map</button>
	</span>
	{#if show}
		<div>
			<img src={customWorldMap} alt="" />
		</div>
	{/if}
</div>

<style language="postcss">
	.city {
		@apply text-[#deba6f]-400 color-[#171c1e];
	}
</style>
