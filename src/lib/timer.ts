export default class Timer {
	#timeSeconds: number = 0;
	#intervalID: string | number | NodeJS.Timeout | undefined;

	#tick() {
		this.#timeSeconds++;

		const currentDate = new Date();
		const localStorageKey = `${currentDate.getDay()}/${currentDate.getMonth()}/${currentDate.getFullYear()}`;
		const currentTime = localStorage.getItem('flow-seconds');

		if (currentTime == null) {
			localStorage.setItem(
				'flow-seconds',
				JSON.stringify({
					localStorageKey: 1
				})
			);
		} else {
			const currentSeconds = Number(
				JSON.parse(localStorage.getItem('flow-seconds')!)[localStorageKey]
			);
			localStorage.setItem(
				'flow-seconds',
				JSON.stringify({
					[localStorageKey]: currentSeconds + 1
				})
			);
		}
	}

	getTime() {
		let timeToUse = this.#timeSeconds;

		let hours = Math.floor(timeToUse / 3600);
		timeToUse %= 3600;

		let minutes = Math.floor(timeToUse / 60);
		timeToUse %= 60;

		let seconds = timeToUse;
		return [hours, minutes, seconds];
	}

	start() {
		this.#timeSeconds = 0;
		this.#intervalID = setInterval(this.#tick.bind(this), 1000);
	}

	stop() {
		clearInterval(this.#intervalID);
	}
}
