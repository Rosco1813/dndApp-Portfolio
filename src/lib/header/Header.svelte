<script>
	import { page } from '$app/stores';
	import logo from './openSourcerer.jpg';

	let navPages = [
		{
			pathName: '/',
			title: 'Pokedex'
		},
		{
			pathName: '/spellbook',
			title: 'Spell Boook'
		},
		{
			pathName: '/locations',
			title: 'Locations'
		},
		{
			pathName: '/entergame/[id]',
			title: 'enter game'
		}
		// {
		// 	pathName: '/howto/character',
		// 	title: 'Character'
		// },
		// {
		// 	pathName: '/todos',
		// 	title: 'To Dos'
		// },
		// {
		// 	pathName: '/howto',
		// 	title: 'How To'
		// }
	];
	let showModal = false;

	function toggleModal() {
		showModal = !showModal;
	}
</script>

<nav class="mainNav">
	<button class="button" on:click={toggleModal}>Menu</button>
</nav>

<header />
{#if showModal}
	<div class="container" />
	<div class="modal" class:showModal>
		<ul class="routeWrap">
			{#each navPages as route}
				<li
					class="routeTitle"
					on:click={toggleModal}
					class:active={$page.url.pathname === route.pathName}
				>
					<a sveltekit:prefetch href={route.pathName}>
						{route.title}
					</a>
				</li>
			{/each}
		</ul>
		<button on:click={toggleModal}>Close</button>
		<span class="flex flex-row" />
		<div class="wiz">
			<img src={logo} alt="SvelteKit" />
		</div>
	</div>
{/if}

<style>
	.mainNav {
		display: flex;
		width: 100dvw;
		justify-content: center;
		margin-top: 15px;
	}
	.routeWrap {
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
	}
	.wiz,
	img {
		height: 75px;
		width: 75px;
	}
	.wiz {
		width: 100%;
		display: flex;
		justify-content: center;
	}
	.routeTitle {
		padding: 4px;
		font-size: 16px;
	}

	.container {
		position: fixed;
		height: 100%;
		width: 100dvw;
		min-width: 10000px;
		/* #9370db */
		/* #ff69b4 */
		background: linear-gradient(to bottom right, #e998c1, rgb(89, 48, 170));
		opacity: 80%;
		z-index: 1;
		backdrop-filter: blur(100px);
		overflow: hidden;
		scroll-behavior: unset;
	}

	.button {
		padding: 10px 20px;
		font-size: 16px;
		background-color: #3498db;
		color: #fff;
		border: none;
		cursor: pointer;
		outline: none;
		border-radius: 8px;
		border: 1px solid rgb(214, 176, 218);
	}

	.modal {
		border-radius: 8px;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		padding: 20px;
		/* background-color: #fff; */
		background-color: rgb(223, 159, 231);
		/* border: 1px solid black; */
		z-index: 2;
		display: none;
		height: fit-content;
		min-height: 350px;
		min-width: 250px;
		/* rgba(255, 0, 102, 0.8) */
		box-shadow: 8px 8px 8px rgba(95, 6, 107, 0.8);
	}
	.showModal {
		display: flex !important;
		flex-direction: column;
		justify-content: space-evenly;
	}

	/* ================================= */
	/* header {
		display: flex;
		justify-content: space-between;
	} */
</style>
