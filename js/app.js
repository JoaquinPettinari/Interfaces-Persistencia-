function pegarleALaApi(){
    fetch('https://jsonplaceholder.typicode.com/todos/1')
        .then(response => response.json())
        .then(json => armadoDelJson(json))
}

function armadoDelJson(json){
    var stringJson = ""
    for (var key in json){
        stringJson += `${key} = ${json[key]} \n`
    }
    
    document.getElementById("json").innerHTML = stringJson       
}


function seleccionarValorDeSelect(){
    
    var select = document.getElementById("opcionesJson") //El <select>
    var value = select.value //El valor seleccionado
    

    document.getElementById("json2").innerHTML = value

}