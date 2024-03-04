import { Ok, Error, toList } from './gleam.mjs'
import { NotFound, InvalidSelector } from './js_test.mjs'

export function query_selector(element, selector) {
	try {
		const found = element.querySelector(selector)
		return found ? new Ok(found) : new Error(new NotFound)
	} catch(error) {
		console.error(error)
		return new Error(new InvalidSelector)
	}
}

export function query_selector_all(element, selector) {
	try {
		const found = element.querySelectorAll(selector)
		return new Ok(toList(Array.from(found)))
	} catch (error) {
		console.error(error)
		return new Error(new InvalidSelector)
	}
}

export function get_text_content(element) {
	return element.textContent
}

export function get_inner_text(element) {
	return element.innerText
}

export function get_inner_html(element) {
	return element.innerHTML
}

export function get_document() {
  return window.document
}
