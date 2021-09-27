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