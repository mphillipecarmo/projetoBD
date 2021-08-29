
/*
let btn_cadUser =  document.querySelector("#btn_cadUser")
btn_cadUser.addEventListener('click', function(){
    let nome = document.querySelector("#nomeUsuario").value;
    let CPF = document.querySelector("#CPF").value;
    let telefone = document.querySelector("#Telefone").value;
    let email = document.querySelector("#emailUsuario").value;
    let endereco = document.querySelector("#endereco").value;
    })
*/
console.log("CU")
let Switch_aluno =  document.querySelector("#Switch_aluno")
Switch_aluno.addEventListener('click', function(){
    
    console.log('string de test checkbosk')
  if(Switch_aluno.checked){
    let outroid = document.querySelector("#matricula_aluno_form")
    outroid.style.display = "block"
  }
  else{
    let outroid = document.querySelector("#matricula_aluno_form")
    outroid.style.display = "none"
  }




    /*
        console.log('checado')
        let nomepai = document.querySelector("#divPaiCheck_aluno")
        nomepai.innerHTML+=`<div class="mb-3 col-4 p-2" id="matricula_aluno_form">
        <label for="matricula_aluno" class="form-label">Matricula:</label>
        <input type="text" class="form-control" id="matricula_aluno" name="matricula_aluno">
        
      </div>`
    }else{
        
        console.log('nao checado')
        let nomepai = document.querySelector("#divPaiCheck_aluno")

        let outroid = document.querySelector("#matricula_aluno_form")
        console.log(outroid)
        if (outroid === null){
            console.log('null')
        }else{
            outroid.parentNode.removeChild(outroid)}
            //nomepai.removeChild(outroid.parentNode.removeChild(outroid))}

    }
    */
    })