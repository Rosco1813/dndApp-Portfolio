<script>
	// import { createEventDispatcher } from 'svelte';
	import characterPic from './soldier.jpg';
	let character = {
		name: 'bill bob',
		class: 'wizard',
		level: '4',
		race: 'human',
		alignment: 'neutral',
		experience: '2345xp',
		armor_class: {
			armor: '3',
			sheild: '2',
			dex_mod: '0'
		},
		initiative: '3',
		speed: '30',
		hit_points: {
			max: '35',
			current: '35'
		},
		hit_dice: {
			type: '1d4',
			max_dice: '4',
			used_dice: '0'
		},
		death_saves: {
			dead: false,
			successes: 0,
			failure: 0
		},
		spell_save_dc: {
			bonus: '3'
		},
		weapon: {
			name: 'axe',
			type: 'slashing',
			range: '5ft',
			bonus: '3',
			damage_dice: '1d6'
		},
		items: {
			favorite_item: 'crystal ball',
			backpack: {
				item_one: 'stick'
			}
		},
		currencty: {
			copper: '15',
			silver: '20',
			gold: '100',
			platnum: '2'
		},
		features: {
			trait_one: 'blue eyes'
		},
		feats: {
			feat_one: 'lucky'
		},
		spell_casting_ability: true,
		proficiency_bonus: '1',
		inspiration: '1',
		strength: {
			stat: '14',
			bonus: '2',
			athletics: {
				saving_throw: true
			}
		},
		dexterity: {
			stat: '15',
			bonus: '2',
			acrobatics: {
				saving_throw: false
			},
			sleight_of_hand: {
				saving_throw: true
			},
			stealth: {
				saving_throw: false
			}
		},
		constitution: {
			stat: '16',
			bonus: '3',
			saving_throw: true
		},
		intelligence: {
			stat: '14',
			bonus: '2',
			arcana: {
				saving_throw: false
			},
			history: {
				saving_throw: true
			},
			investigation: {
				saving_throw: false
			},
			nature: {
				saving_throw: true
			},
			religion: {
				saving_throw: false
			}
		},
		wisdom: {
			stat: '18',
			bonus: '4',
			animal_handling: {
				saving_throw: true
			},
			insight: {
				saving_throw: false
			},
			medicine: {
				saving_throw: true
			},
			perception: {
				saving_throw: false
			},
			survival: {
				saving_throw: true
			}
		},
		charisma: {
			stat: '15',
			bonus: '2',
			deception: {
				saving_throw: false
			},
			intimidation: {
				saving_throw: true
			},
			performance: {
				saving_throw: false
			},
			persuasion: {
				saving_throw: true
			}
		}
	};
	let backPack = ['sword', 'healing potion', 'water', 'magic scroll'];
	let grow;
	// const dispatch = createEventDispatcher();

	// let click = (stat) => {
	// 	alert('click', stat);
	// 	// dispatch('message', {
	// 	// 	text: 'Hello!'
	// 	// });
	// };
	function onClick(event) {
		console.log(event);
		console.log('character', character);

		for (let [key, value] of Object.entries(character)) {
			console.log(key, value);
		}

		grow = !grow;
	}
</script>

<svelte:head>
	<title>About</title>
</svelte:head>
<div class="container">
	<div class="flex">
		<div class="flex ">
			<button class=" w-[150px] ">
				<div class="stats">
					level: {character?.level}
				</div>
			</button>

			<button on:click={onClick} class="boxes {(grow &&= 'grow')}">
				{#if grow}
					<input />
				{/if}
				<div class="stats ">
					{character.name}
				</div>
			</button>
			<div class="boxes">
				<div class="stats">
					{character.alignment}
				</div>
			</div>
		</div>

		<div class=" flex">
			<div class="boxes">
				<div class="stats">
					initiative:{character.initiative}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					speed:{character.speed}
				</div>
			</div>
		</div>

		<div class="flex">
			<div class="boxes">
				<div class="stats">
					{character.experience}
				</div>
			</div>
		</div>
	</div>
	<div class=" w-screen h-[450px] flex relative">
		<div class=" w-[150px] h-[450px] z-50">
			<img height="450px" width="150px" src={characterPic} alt="" />
		</div>
		<div class=" w-full h-fit z-50 flex">
			<div class="boxes">
				<div class="stats">
					{character.race}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					{character.class}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					hit poins:{character.hit_points.current}
				</div>
			</div>

			<div class="flex">
				<div class="boxes">
					<div class="stats">
						spell save bonus:{character.spell_save_dc.bonus}
					</div>
				</div>

				<div class="boxes">
					<div class="stats">
						proficiency bonus:{character.proficiency_bonus}
					</div>
				</div>
			</div>
		</div>

		<div class=" w-full h-fit z-50 absolute bottom-0 flex ml-[134px]">
			<div class="boxes">
				<div class="stats">
					strength:{character.strength.stat}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					dexterity:{character.dexterity.stat}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					constitution:{character.constitution.stat}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					intelligence:{character.intelligence.stat}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					wisdom:{character.wisdom.stat}
				</div>
			</div>

			<div class="boxes">
				<div class="stats">
					charisma:{character.charisma.stat}
				</div>
			</div>
		</div>
	</div>
	<div class="flex">
		<div class="boxes">
			<div class="stats">
				bag:{character.items.favorite_item}
			</div>
		</div>
		<div class="boxes">
			<div class="stats">
				money:{character.currencty.copper}
			</div>
		</div>
	</div>
</div>

<style lang="postcss">
	.stats {
		@apply text-xl p-4;
	}

	.boxes {
		@apply h-fit w-fit   border-2 border-slate-400 rounded-md bg-white backdrop-filter backdrop-blur-xl bg-opacity-40;
	}
	.container {
		@apply m-4;
	}
	.grow {
		@apply w-40 h-40 z-50;
	}
	img {
		height: 450px !important;
		border-radius: 2%;
		border: 3px solid slategray;
		width: 150px !important;
	}
</style>
