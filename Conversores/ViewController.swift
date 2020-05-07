//
//  ViewController.swift
//  Conversores
//
//  Created by João Luis dos Santos on 23/04/20.
//  Copyright © 2020 João Luis dos Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        let radius: CGFloat = 10.0
        cornerRadius(view: viewResult, radius)
        cornerRadius(view: viewTextField, radius)
        cornerRadius(view: viewButtons, radius)
        cornerRadius(view: textField, radius)
        
        shadow(view: viewResult)
        shadow(view: viewTextField)
        shadow(view: viewButtons)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var viewButtons: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var viewBackground: UIImageView!
    @IBOutlet weak var buttonUnit1: UIButton!
    @IBOutlet weak var buttonUnit2: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelUnitResult: UILabel!
    @IBOutlet weak var labelUnit: UILabel!
    
    
    @IBAction func buttonUnit1(_ sender: Any) {
        
        guard let inputTextField = self.textField.text else { return }
        guard let value = Double(inputTextField) else { return }
        
        switch buttonUnit1.titleLabel?.text {
        
            case "Real":
                ConversoresAPI().recoverDolarValue { (dolar) in
                    self.labelResult.text = self.textLabelResult(Calculate().real(dolar, value))
                    self.labelUnitResult.text = "Dólar para Real"
            }
            case "Celsius":
                labelResult.text = textLabelResult(Calculate().celsius(value))
                labelUnitResult.text = "Celsius para Farenheint"
            
            case "Quilômetro":
                labelResult.text = textLabelResult(Calculate().quilometro(value))
                labelUnitResult.text = "Quilômetro para Milha"
            default:
                labelResult.text = self.textLabelResult(Calculate().quilograma(value))
                labelUnitResult.text = "Quilograma para Libra"
            }
        textField.resignFirstResponder()
    }
    
    @IBAction func buttonUnit2(_ sender: Any) {
        
        guard let inputTextField = self.textField.text else { return }
        guard let value = Double(inputTextField) else { return }
        
        switch buttonUnit2.titleLabel?.text {

            case "Dólar":
                ConversoresAPI().recoverDolarValue { (dolar) in
                    self.labelResult.text = self.textLabelResult(Calculate().dolar(dolar, value))
                    self.labelUnitResult.text = "Real para Dólar"
                }
            case "Fahrenheit":
                labelResult.text = self.textLabelResult(Calculate().fahrenheit(value))
                labelUnitResult.text = "Fahrenheit para Celsius"
            
            case "Milha":
                labelResult.text = self.textLabelResult(Calculate().milha(value))
                labelUnitResult.text = "Milha para Quilômetro"
            
            default:
                labelResult.text = self.textLabelResult(Calculate().libra(value))
                labelUnitResult.text = "Libra para Quilograma"
            }
        textField.resignFirstResponder()
    }
    @IBAction func buttonNext(_ sender: Any) {
        switch self.labelUnit.text {
            case "Temperatura":
                self.labelUnit.text = "Peso"
                setTitle(button1: "Quilograma", button2: "Libra")
            case "Peso":
                self.labelUnit.text = "Moeda"
                setTitle(button1: "Real", button2: "Dólar")
            case "Moeda":
                self.labelUnit.text = "Distância"
                setTitle(button1: "Quilômetro", button2: "Milha")
            default:
                self.labelUnit.text = "Temperatura"
                setTitle(button1: "Celsius", button2: "Fahrenheit")
        }
    }
    
    @IBAction func buttonPrevious(_ sender: Any) {
        switch self.labelUnit.text {
            case "Temperatura":
                self.labelUnit.text = "Distância"
                setTitle(button1: "Quilômetro", button2: "Milha")
            case "Distância":
                self.labelUnit.text = "Moeda"
                setTitle(button1: "Real", button2: "Dólar")
            case "Moeda":
                self.labelUnit.text = "Peso"
                setTitle(button1: "Quilograma", button2: "Libra")
            default:
                self.labelUnit.text = "Temperatura"
                setTitle(button1: "Celsius", button2: "Fahrenheit")
        }
    }
    
    func setTitle(button1: String, button2: String) {
        buttonUnit1.setTitle(button1, for: .normal)
        buttonUnit2.setTitle(button2, for: .normal)
    }
    
    func textLabelResult(_ value: Double) -> String {
        let text = String(format: "%.2f", value)
        return text
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        print("tamanho teclado \(keyboardSize)")
        let keyboardView = view.bounds.height - keyboardSize.height
        print("altura da view menos a do teclado \(keyboardView)")
        let viewText = viewTextField.convert(viewTextField.bounds, to: self.view).maxY
        print("parte de abixo do botao \(viewText)")
        self.view.frame.origin.y = keyboardView - viewText
        print("a view vai subir \(self.view.frame.origin.y)")
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    func cornerRadius(view: UIView,_ radius: CGFloat) {
        view.layer.cornerRadius = radius
    }
    
    func shadow(view: UIView) {
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.25
    }

}

extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // Desaparece o teclado quando clicar na view
        self.view.endEditing(true)
    }
}

