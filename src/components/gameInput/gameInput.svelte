<script>
	export let name = '';
	export let correct_Answer = 'Rosco';
	export let guess = 0;
	export let correct = false;

	let testValue = 'test';

	$: if (name === correct_Answer) {
		correct = true;
	}

	function submit_Answer() {
		if (name != correct_Answer) {
			correct = false;
			guess++;
			if (guess >= 3) {
				window.location.href = '/locations';
			}
		}
	}
</script>

<div class="form__group field  submission-wrap">
	<input
		autocomplete="off"
		bind:value={name}
		type="input"
		class="form__field text-black"
		placeholder="Name"
		name="name"
		id="name"
		required
	/>
	<label for="name" class="form__label" />
	<button class="submit-answers" on:click={submit_Answer}>submit</button>
</div>

<style>
	.submission-wrap {
		display: flex;
		flex-direction: column;
		width: 100%;
		border-radius: 8px;
		padding: 10px;
		border: solid black 1px;
		backdrop-filter: blur(10px);
		-webkit-backdrop-filter: blur(10px);
		box-shadow: inset 25px 25px 50px #758f78, inset -25px -25px 50px #9fc1a2;
	}

	.submission-wrap input {
		text-align: center;
	}
</style>
