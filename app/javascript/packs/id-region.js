const data = require('../data/id-region.json');

const arrProvince = []
let arrCity = []
let arrDistrict = []

data.map(prov => arrProvince.push(prov))

const getVal = (type, inputName, optionsName, arrName) => {
	const elementInput = document.getElementById(inputName);
	const elementOptions = document.getElementById(optionsName);
	const dropdown = document.getElementById(`dropdown${type}`)

	RegExp.escape = function (s) {
    	return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
	};

	const show = () => {
		switch(type) {
			case 'Province':
				const cityInput = document.getElementById('user_city')
				document.getElementById('list_city').textContent = ''
				document.getElementById('list_district').textContent = ''
				if (cityInput.value != '') cityInput.value = ''
				break;
			case 'City':
				const districtInput = document.getElementById('user_district')
				document.getElementById('list_district').textContent = ''
				if (districtInput.value != '') districtInput.value = ''
				break;
		}

		elementOptions.textContent = ''

		dropdown.style.display = 'none'
		elementOptions.hidden = false

		elementOptions.options = 0

		if (elementInput.value) {
			dropdown.style.display = 'block';
			elementOptions.size = 3;
			const inputVal = elementInput.value;

			for (let i = 0; i < arrName.length; i++) {
	            let testableRegExp = new RegExp(RegExp.escape(inputVal), "i");
	            if (arrName[i].name.match(testableRegExp)) {
	                addValue(arrName[i].name, arrName[i].name, arrName[i].id);
	            }
	        }

	        let size = dropdown.children[0].children;
	        if (size.length > 0) {
	           let defaultSize = 16;
	           if (size.length < 10) {
	              defaultSize *= size.length;
	           } else {
	              defaultSize *= 10;
	           }
	           dropdown.children[0].style.height = `${defaultSize}px`;
	        }
		}
	}

	elementInput.addEventListener('keyup', show);
	elementOptions.onclick = () => setVal(elementOptions)

	const addValue = (text, val, ID) => {
	    const createOptions = document.createElement('option');
	    elementOptions.appendChild(createOptions);
	    createOptions.text = text;
	    createOptions.value = val;
	    createOptions.id = ID;
	}

	const setVal = (selectedVal) => {
	    elementInput.value = selectedVal.value;
	    dropdown.style.display = 'none';
	    let dataID = selectedVal.options[selectedVal.selectedIndex]?.id
	    if (dataID && type == 'Province') {
	    	document.getElementById('user_city').disabled = false
	    	getCityData(dataID)
	    }
	    if (dataID && type == 'City') {
	    	document.getElementById('user_district').disabled = false
	    	getDistrictData(dataID)
	    }
	}
}

getVal('Province', 'user_province', 'list_province', arrProvince)

const getCityData = (Id) => {
	for (let i = 0; i <= arrProvince.length; i++) {
		if (arrProvince[i].id == Id) {
			arrCity = arrProvince[i].regencies
			break
		}
	}
	getVal('City', 'user_city', 'list_city', arrCity)
}

const getDistrictData = (Id) => {
	for (let i = 0; i <= arrCity.length; i++) {
		if (arrCity[i].id == Id) {
			arrDistrict = arrCity[i].districts
			break
		}
	}
	getVal('District', 'user_district', 'list_district', arrDistrict)
}