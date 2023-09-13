//
//  dataLoginViewController.swift
//  ejLogin
//
//  Created by Javier Rodríguez Valentín on 28/09/2021.
//

import UIKit

class dataLoginViewController: UIViewController {

    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var name = ""
    var pass = ""
    var transfer:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 15
        logoutButton.setTitle("LogOut", for: .normal)
        labelWelcome.text = "Bienvenido: \(transfer[0])"
        labelName.text = "Nombre: \(transfer[0])"
        labelPass.text = "Password: \(transfer[1])"
        dataReg() //Recoger datos. La intención es que si salimos de la app, cuando vuelva a esta pantalla no perdamos los datos. NO LO HACE BIEN
    }
    
    func dataReg(){
        //Función para sacar los datos almacenados en el dispositivo
        if transfer[0] == "" {
            labelWelcome.text = "Bienvenido: \(UserDefaults.standard.string(forKey: name) ?? "error")"
            labelName.text = "Nombre: \(UserDefaults.standard.string(forKey: name) ?? "error")"
            labelPass.text = "Password: \(UserDefaults.standard.string(forKey: pass) ?? "error")"
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        //cambiamos el check para que al acceder a la app no entre directamente en esta pantalla
        UserDefaults.standard.set("false", forKey: transfer[2])
        
        //elimina la última pantalla viewController. en este caso nos sirve pero si hubiera más viewControllers habría que hacerlo de otro modo
        navigationController?.popViewController(animated: true)
    }

}
