<script>
	import { goto } from '$app/navigation'
	import XMarkIcon from '$lib/components/icons/XMarkIcon.svelte'
</script>

<article class="info-article">
	<button class="exit-button" on:click={async () => goto('/')}><XMarkIcon /></button>
	<heading>
		<h1 class="heading">About</h1>
	</heading>
	<section>
		<p class="site-description">
			This is a website designed to assist you with tracking your time while you do your work. <br
			/><br />It is best suited for deep/flow work and other related techniques. The goal is to help
			you create a focused environment and not get in your way.
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
