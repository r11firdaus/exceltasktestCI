// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
//= require popper
//= require bootstrap
require("jquery")


Rails.start()
Turbolinks.start()
ActiveStorage.start()


window.addEventListener("load", () => {
	const element = document.querySelector("#form_comment");
	element.addEventListener("ajax:success", (event) => {
		const dataForm = $('#form_comment').serializeArray()
		$('#comment').append(`
			<div class="card bg-light my-2">
				<div class="card-body">
				  <strong class="card-title">${dataForm[1].value}</strong>
				  <p>${dataForm[2].value}</p>
				</div>
			</div>
		`)
 	 	$('#comment_body').val('')
 	});

  	element.addEventListener("ajax:error", () => {
    	element.insertAdjacentHTML("beforeend", "<p>ERROR</p>");
 	});
});