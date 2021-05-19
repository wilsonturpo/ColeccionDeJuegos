//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Wilson Turpo Quispe on 5/17/21.
//  Copyright © 2021 wilson. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource{
    
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var txtCategoria: UITextField!
    
    
    @IBAction func addCategory(_ sender: Any) {
        Tabla.isHidden = false
    }
    
    
    var arregloCategorias = ["Costa", "Sierra", "Selva"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloCategorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = arregloCategorias[indexPath.row]
        return cell
    }
    
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if(txtCategoria.text! == ""){
            let alert = UIAlertController(title: "Debe seleccionar una categoria",
                          message: "Presione en botón '+' que està abajo", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }else{
        
            if juego != nil{
                juego!.titulo! = tituloTextField.text!
                juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
                juego!.categoria = txtCategoria.text!
            }else{
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                   
                let juego = Juego(context:context)
                juego.titulo = tituloTextField.text
                juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
                juego.categoria = txtCategoria.text!
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabla.dataSource = self
        Tabla.delegate = self
        Tabla.isHidden = true
        
        imagePicker.delegate = self
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            txtCategoria.text = juego!.categoria
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let categoria = arregloCategorias[indexPath.row]
        txtCategoria.text = categoria
        Tabla.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
