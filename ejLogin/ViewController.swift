//
//  ViewController.swift
//  ejLogin
//
//  Created by Javier Rodríguez Valentín on 28/09/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPass: UILabel!
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var dataUser = ["Javi","0000"]
    
    var checkIn = "false"
    var name = ""
    var pass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        labelName.text = "Escriba su nombre"
        labelPass.text = "Escriba su password"
        
        inputName.attributedPlaceholder = NSAttributedString(string: "Nombre",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputPass.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputPass.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 15
        loginButton.setTitle("LogIn", for: .normal)
        
        initialCheck() //iniciamos un chequeo para saber si estamos ya registrados y así no tener que poner el login otra vez e ir a la pantalla del usuario directamente
        
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        let data = checkData() //al dar al boton me hace un chequeo para saber si los datos son correctos
        
        if data{ //sin son correctos hacemos un segue
            performSegue(withIdentifier: "sgLogin", sender: self)
        }else{ //si no son correctos sacamos un alert
            alert(msg: "Datos incorrectos")
        }
        
    }
    
    func initialCheck(){
        //chequeo inicial para saber si ya nos hemos registrado antes
        if UserDefaults.standard.string(forKey: checkIn) == "true"{
            performSegue(withIdentifier: "sgLogin", sender: self)
        }
    }
    
    func checkData()->Bool{
        //Chequeamos que los datos son correctos
        if (inputName.text == dataUser[0]) && (inputPass.text == dataUser[1]) {
            
            //si los datos son correctos, almaceno los datos y cambio el check a verdadero para que entre
            UserDefaults.standard.set("true", forKey: checkIn)
            UserDefaults.standard.set(dataUser[0], forKey: name)
            UserDefaults.standard.set(dataUser[1], forKey: pass)
            UserDefaults.standard.synchronize()
            return true
        }else{
            return false
        }
        
    }
    
    func alert(msg:String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }
    
    //función para llevar datos de una view a otra mediante segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiny = segue.destination as? dataLoginViewController{
            name = inputName.text!
            inputName.text = ""
            pass = inputPass.text!
            inputPass.text = ""
            
            destiny.transfer = [name, pass, checkIn]
            }
    }
}

