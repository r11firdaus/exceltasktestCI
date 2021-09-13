const data = require('../data/id-region.json');

const arr = []
data.map(prov => arr.push(prov))

const inputProvince = document.getElementById('user_province');
const optionsVal = document.getElementById('list_province');

const inputCity = document.getElementById('user_city');
const optionsValCity = document.getElementById('list_city');

const inputDistrict = document.getElementById('user_district');
const optionsValDistrict = document.getElementById('list_district');

//Use this function to replace potential characters that could break the regex
RegExp.escape = function (s) {
    return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
};

inputProvince.addEventListener('keyup', show);
optionsVal.onclick = function () {
    setVal(this);
    inputCity.disabled = false
};

//shows the list
function show() {
	if (inputCity.value != '') inputCity.value = ''
	if (inputDistrict.value != '') inputDistrict.value = ''
    var dropdownProv = document.getElementById('dropdownProv');
    dropdownProv.style.display = 'none';
    optionsVal.hidden = false

    optionsVal.options.length = 0;

    if (inputProvince.value) {
        dropdownProv.style.display = 'block';
        optionsVal.size = 3;
        var textProvince = inputProvince.value;

        for (var i = 0; i < arr.length; i++) {
            var testableRegExp = new RegExp(RegExp.escape(textProvince), "i");
            if (arr[i].name.match(testableRegExp)) {
                addValue(arr[i].name, arr[i].name, arr[i].id);
            }
        }
        
        var size = dropdownProv.children[0].children;
        if (size.length > 0)
        {
           var defaultSize = 16;
           if (size.length < 10)
           {
              defaultSize *= size.length;
           }
           else
           {
              defaultSize *= 10;
           }
           dropdownProv.children[0].style.height = defaultSize + "px";
        }
        
    }
}

function addValue(text, val, provID) {
    var createOptions = document.createElement('option');
    optionsVal.appendChild(createOptions);
    createOptions.text = text;
    createOptions.value = val;
    createOptions.id = provID;
}

//Settin the value in the box by firing the click event
function setVal(selectedVal) {
    inputProvince.value = selectedVal.value;
    document.getElementById('dropdownProv').style.display = 'none';
    provId = selectedVal.options[selectedVal.selectedIndex]?.id
    provId && getCity(provId)
}

let cityArr = []
const getCity = (Id) => {
	for (let i = 0; i <= data.length; i++) {
		if (data[i].id == Id) {
			cityArr = data[i].regencies
			break
		}
	}

	inputCity.addEventListener('keyup', showCity);
	optionsValCity.onclick = function () {
	    setValCity(this);
	    inputDistrict.disabled = false
	};

	function showCity() {
		if (inputDistrict.value != '') inputDistrict.value = ''
	    var dropdownCity = document.getElementById('dropdownCity');
	    dropdownCity.style.display = 'none';
	    optionsValCity.hidden = false

	    optionsValCity.options.length = 0;

	    if (inputCity.value) {
	        dropdownCity.style.display = 'block';
	        optionsValCity.size = 3;
	        var textCity = inputCity.value;

	        for (var i = 0; i < cityArr.length; i++) {
	            var testableRegExp = new RegExp(RegExp.escape(textCity), "i");
	            if (cityArr[i].name.match(testableRegExp)) {
	                addValueCity(cityArr[i].name, cityArr[i].name, cityArr[i].id);
	            }
	        }
	        
	        var size = dropdownCity.children[0].children;
	        if (size.length > 0)
	        {
	           var defaultSize = 16;
	           if (size.length < 10)
	           {
	              defaultSize *= size.length;
	           }
	           else
	           {
	              defaultSize *= 10;
	           }
	           dropdownCity.children[0].style.height = defaultSize + "px";
	        }
	        
	    }
	}

	function addValueCity(text, val, cityID) {
	    var createOptions = document.createElement('option');
	    optionsValCity.appendChild(createOptions);
	    createOptions.text = text;
	    createOptions.value = val;
	    createOptions.id = cityID;
	}

	function setValCity(selectedVal) {
	    inputCity.value = selectedVal.value;
	    document.getElementById('dropdownCity').style.display = 'none';
	    cityId = selectedVal.options[selectedVal.selectedIndex]?.id
    	cityId && getDistrict(cityId)
	}
}

const getDistrict = (id) => {
	let districtArr = []

	for (let i = 0; i <= cityArr.length; i++) {
		if (cityArr[i].id == id) {
			districtArr = cityArr[i].districts
			break
		}
	}

	inputDistrict.addEventListener('keyup', showDistrict);
	optionsValDistrict.onclick = function () {
	    setValDistrict(this);
	};

	function showDistrict() {
	    var dropdownDistrict = document.getElementById('dropdownDistrict');
	    dropdownDistrict.style.display = 'none';
	    optionsValDistrict.hidden = false

	    optionsValDistrict.options.length = 0;

	    if (inputDistrict.value) {
	        dropdownDistrict.style.display = 'block';
	        optionsValDistrict.size = 3;
	        var textDistrict = inputDistrict.value;

	        for (var i = 0; i < districtArr.length; i++) {
	            var testableRegExp = new RegExp(RegExp.escape(textDistrict), "i");
	            if (districtArr[i].name.match(testableRegExp)) {
	                addValueDistrict(districtArr[i].name, districtArr[i].name, districtArr[i].id);
	            }
	        }
	        
	        var size = dropdownDistrict.children[0].children;
	        if (size.length > 0)
	        {
	           var defaultSize = 16;
	           if (size.length < 10)
	           {
	              defaultSize *= size.length;
	           }
	           else
	           {
	              defaultSize *= 10;
	           }
	           dropdownDistrict.children[0].style.height = defaultSize + "px";
	        }
	        
	    }
	}

	function addValueDistrict(text, val, districtID) {
	    var createOptions = document.createElement('option');
	    optionsValDistrict.appendChild(createOptions);
	    createOptions.text = text;
	    createOptions.value = val;
	    createOptions.id = districtID;
	}

	function setValDistrict(selectedVal) {
	    inputDistrict.value = selectedVal.value;
	    document.getElementById('dropdownDistrict').style.display = 'none';
	}
}