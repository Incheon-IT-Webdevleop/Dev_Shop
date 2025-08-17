<<<<<<< HEAD
=======
const selectOne = () => {
	console.log("selectOne");

	fetch(`/api/purchase/select.do`)
		.then(response => response.json())
		.then(data => {
			console.log(data);
		})
		.catch(error => {
			console.log(error);
		})
};

selectOne();
>>>>>>> main
