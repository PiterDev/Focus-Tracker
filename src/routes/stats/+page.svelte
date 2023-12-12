<script lang="ts">
	import { goto } from '$app/navigation'
	import XMarkIcon from '$lib/components/icons/XMarkIcon.svelte'
	import { onMount } from 'svelte'
	import { page } from '$app/stores'

	import { Line } from 'svelte-chartjs'
	import { Chart, registerables } from 'chart.js'
	Chart.register(...registerables)

	// TODO: Get rid of this mess, and migrate to svelte-chartjs

	const currentDate = new Date()
	let data: Object
	onMount(async () => {
		// Set the graph data to the fetched user stats
		const { dates, times } = await fetchUserStats()
		data = {
			labels: dates.map((date) => `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`),
			datasets: [
				{
					label: 'Time spent focusing',
					data: times,
					fill: false,
					borderColor: 'rgb(75, 192, 192)',
					tension: 0.1
				}
			]
		}
	})

	async function fetchUserStats() {
		if ($page.data.session) {
			const userId = $page.data.session.user?.id
			if (userId) {
				const response = await fetch(`/api/users/${userId}`)
				const { focusStats } = await response.json()
				// Create an array of all the dates and of all the times in seconds
				const dates: Array<Date> = []
				const times: Array<number> = []
				for (const focusStat of focusStats) {
					dates.push(new Date(focusStat.date))
					times.push(focusStat.timeSeconds)
				}
				return { dates, times }
			}
		}
		return { dates: [], times: [] }
	}

	let chartCanvas: HTMLCanvasElement
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
	</section>
	<Line {data} />
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
