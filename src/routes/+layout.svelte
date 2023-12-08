<script lang="ts">
	import '../app.scss'
</script>

<svelte:head>
	<link href="https://fonts.googleapis.com/css?family=Inter" rel="stylesheet" />
</svelte:head>

<div class="center-container">
	<slot />
</div>

<style lang="scss">
	* {
		color: #fff;
	}

	.center-container {
		display: flex;
		flex-direction: column;
		gap: 2rem;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		background: no-repeat center url('/images/bg-gradient.png');
		background-size: cover;
	}
</style>
