import adapter from '@sveltejs/adapter-auto';
// import preprocess from 'svelte-preprocess';
// import { mdsvex } from 'mdsvex';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// extension: ['.svelte'],
	preprocess: [
		// mdsvex(),
		// preprocess({
		// 	scss: { includePaths: ['src', 'node_modules'] }
		// })
	],

	kit: {
		adapter: adapter()

		// hydrate the <div id="svelte"> element in src/app.html
		// target: '#svelte'
	}
};

export default config;
