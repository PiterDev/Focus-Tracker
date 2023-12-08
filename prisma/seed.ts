import { PrismaClient } from '@prisma/client';

const db = new PrismaClient();

type Quote = {
	quote: string;
	author: string;
};

async function getQuotes() {
	const response = await fetch('https://dummyjson.com/quotes');
	const { quotes } = await response.json();
	return quotes as Quote[];
}

async function main() {
	const quotes: Quote[] = await getQuotes();

	for (const quote of quotes) {
		await db.quote.create({
			data: {
				quote: quote.quote,
				author: quote.author
			}
		});
	}
}

main();
