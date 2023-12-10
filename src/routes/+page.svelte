<script lang="ts">
	import Timer from '$lib/timer'
	import PauseIcon from '$lib/components/icons/PauseIcon.svelte'
	import PlayIcon from '$lib/components/icons/PlayIcon.svelte'
	import { fade } from 'svelte/transition'
	import InformationIcon from '$lib/components/icons/InformationIcon.svelte'
	import ChartIcon from '$lib/components/icons/ChartIcon.svelte'
	import { goto } from '$app/navigation'
	import { signIn, signOut } from '@auth/sveltekit/client'
	import { page } from '$app/stores'

	export let data

	let timer = new Timer()

	let counting = false

	let minutes = 0
	let seconds = 0

	let message = ''

	let quotes = data.quotes

	async function timerToggled() {
		counting = !counting
		if (counting) {
			startTimer()
		} else {
			await stopTimer()
		}
	}

	function startTimer() {
		timer.start()
		setInterval(updateTimer, 1000)
		message = quotes[Math.floor(Math.random() * quotes.length)].quote
	}

	async function stopTimer() {
		timer.stop()
		message = ''

		if ($page.data.session) {
			const userId = $page.data.session.user?.id
			if (userId) {
				const today = new Date()
				today.setHours(0, 0, 0, 0)

				fetch('api/users', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({
						id: userId,
						timeSeconds: timer.getTimeSeconds(),
						date: today
					})
				})
			}
		}
	}

	function updateTimer() {
		let [h, min, sec] = timer.getTime()
		minutes = min
		seconds = sec
	}

	setInterval(async () => {
		if (counting) {
			message = quotes[Math.floor(Math.random() * quotes.length)].quote
		}
	}, 300_000)
</script>

<div class="top-bar">
	<div class="bar-left">
		<button class="icon-button-small" on:click={async () => goto('/about')}
			><InformationIcon /></button
		>
		<button class="icon-button-small" on:click={async () => goto('/stats')}><ChartIcon /></button>
	</div>
	<div class="bar-right">
		{#if $page.data.session}
			{#if $page.data.session.user?.image}
				<div style="background-image: url('{$page.data.session.user.image}')" class="avatar" />
			{/if}
			<button on:click={() => signOut()}>Sign out</button>
		{:else}
			<button on:click={() => signIn('discord')}>Sign in</button>
		{/if}
	</div>
</div>

<div class="timer-box">
	<button class="toggle-button" on:click={timerToggled}>
		{#if counting}
			<PauseIcon />
		{:else}
			<PlayIcon />
		{/if}
	</button>

	<div class="time-display" class:blink={!counting}>
		{`${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`}
	</div>
</div>

{#key message}
	<div class="message" class:hidden={!counting} in:fade>
		{#if message != ''}
			{message}
		{:else}
			Time to focus!
		{/if}
	</div>
{/key}

<style lang="scss">
	@keyframes blink {
		50% {
			opacity: 0.1;
		}
		100% {
			opacity: 1;
		}
	}

	@keyframes appear {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}

	.blink {
		animation: blink 2s linear infinite;
	}

	button {
		border: none;
		background: none;
		margin: 0;
		padding: 0;

		color: #fff;
		font-weight: 600;
		cursor: pointer;
	}

	.top-bar {
		display: flex;
		justify-content: space-between;
		gap: 1rem;
		position: fixed;
		top: 0;
		right: 0;
		left: 0;

		width: 100%;

		.icon-button-small {
			width: 2rem;
			height: 2rem;
			color: #fff;

			cursor: pointer;
		}

		.avatar {
			width: 2rem;
			height: 2rem;
			border-radius: 100%;

			background-size: cover;
			background-repeat: no-repeat;
			background-position: center center;
		}

		& > div {
			display: flex;
			align-items: center;
			justify-content: flex-start;

			padding: 1rem;
			gap: 1rem;
		}
	}

	.timer-box {
		width: 55rem;
		height: 20rem;

		.toggle-button {
			width: 10rem;
			height: 10rem;
			color: #ffffff;

			cursor: pointer;
		}
		background: rgba(255, 255, 255, 0.3);
		box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
		backdrop-filter: blur(20px);
		-webkit-backdrop-filter: blur(20px);
		border-radius: 10px;

		display: flex;
		justify-content: center;
		align-items: center;
		gap: 4rem;

		padding: 0;

		.time-display {
			font-size: 8rem;

			-webkit-touch-callout: none;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;

			min-width: 6ch;
			text-align: center;

			font-variant-numeric: tabular-nums;
		}
	}

	.message {
		font-size: 24px;
		max-width: 50rem;
		height: 6rem;
		text-align: center;
		transition: opacity 2s;

		// &.hidden {
		// 	opacity: 0;
		// }
	}
</style>
