<script lang="ts">
	import { goto } from '$app/navigation';
	import XMarkIcon from '$lib/components/icons/XMarkIcon.svelte';

	const currentDate = new Date();
	const localStorageKey = `${currentDate.getDay()}/${currentDate.getMonth()}/${currentDate.getFullYear()}`;
	let flowSeconds = JSON.parse(localStorage.getItem('flow-seconds')!)[localStorageKey];
</script>

<article class="info-article">
	<button class="exit-button" on:click={async () => goto('/')}><XMarkIcon /></button>
	<heading>
		<h1 class="heading">Stats</h1>
	</heading>
	<section>
		<p class="site-description">
			Imagine some cool graphs and statistic here. Lorem ipsum dolor sit amet consectetur,
			adipisicing elit. Soluta possimus nobis velit placeat hic omnis nihil adipisci et corporis,
			aut, ipsa eos consectetur dolorem error alias, quia sunt ducimus ab.
		</p>
		<p>
			Seconds today: {flowSeconds}
		</p>
	</section>
</article>

<style lang="scss">
	button {
		border: none;
		background: none;
		margin: 0;
		padding: 0;
	}
	.info-article {
		position: relative;
		top: 0;
		right: 0;

		.heading {
			font-size: 48px;

			margin: 0;
		}
		.site-description {
			font-size: 24px;

			width: 30rem;
			text-align: justify;
		}
	}

	.exit-button {
		position: absolute;
		top: 0;
		right: 0;
		width: 3rem;
		height: 3rem;

		color: #fff;
		cursor: pointer;
	}
</style>
