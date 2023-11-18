import cookie from 'cookie';
import { v4 as uuid } from '@lukeed/uuid';

export const getSession = (request) => {
	return {
		API_URL: process.env['API_URL'],
		RECAPTCHA_KEY: process.env['RECAPTCHA_KEY'],
		TESTING: process.env['TESTING'],
		MAPBOX_KEY: process.env['MAPbOX_KEY']
	};
};

export const handle = async ({ event, resolve }) => {
	// console.log('handle fn ');
	// console.log('event ', event);
	const cookies = cookie.parse(event.request.headers.cookie || '');
	event.locals.userid = cookies.userid || uuid();

	// TODO https://github.com/sveltejs/kit/issues/1046
	if (event.url.searchParams.has('_method')) {
		event.request.method = event.url.searchParams.get('_method').toUpperCase();
	}

	const response = await resolve(event);

	if (!cookies.userid) {
		// if this is the first time the user has visited this app,
		// set a cookie so that we recognise them when they return
		response.headers['set-cookie'] = cookie.serialize('userid', event.locals.userid, {
			path: '/',
			httpOnly: true
		});
	}

	return response;
};
