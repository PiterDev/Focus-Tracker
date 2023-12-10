import db from '$lib/database'
import type { RequestHandler } from '@sveltejs/kit'

// TODO: Migrate this API to /api/focus-stats/[user-id]

async function setUserTime(id: string, date: Date, timeSeconds: number) {
	await db.user.upsert({
		where: { id },
		create: {
			id,
			focusStats: {
				create: [
					{
						date,
						timeSeconds
					}
				]
			}
		},
		update: {
			focusStats: {
				upsert: [
					{
						create: { date, timeSeconds },
						update: { date, timeSeconds: { increment: timeSeconds } },
						where: { date }
					}
				]
			}
		}
	})
}

export const POST: RequestHandler = async (event) => {
	const body = await event.request.json()
	setUserTime(body.id, body.date, body.timeSeconds)

	return new Response(JSON.stringify(body), { status: 200 })
}

export const GET: RequestHandler = async (event) => {
	const { id } = event.params
	console.log(event.params)
	if (id) {
		const user = await db.user.findUnique({
			where: { id },
			include: { focusStats: true }
		})
		return new Response(JSON.stringify(user), { status: 200 })
	} else {
		// Error, id not provided
		return new Response(JSON.stringify({ error: 'No user id provided' }), { status: 400 })
	}
}
