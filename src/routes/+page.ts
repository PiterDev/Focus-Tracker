import type { Quote } from '@prisma/client'
import type { PageLoad } from './$types'

export const load: PageLoad = async ({ fetch }) => {
	const response = await fetch('http://localhost:5173/api/quotes', {
		headers: {
			'Access-Control-Allow-Headers': '*'
		}
	})
	const quotes = await response.json()
	return {
		quotes: quotes as Quote[]
	}
}
