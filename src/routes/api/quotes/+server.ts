import { json, type RequestHandler } from '@sveltejs/kit'
import db from '$lib/database'

export const GET: RequestHandler = async (event) => {
	const posts = await db.quote.findMany()
	return json(posts)
}
