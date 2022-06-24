//
//  InicioViewController.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 17/06/22.
//

import UIKit

class InicioViewController: UIViewController {

    var check = false
    
    // Underline
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor.black,
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    
    private var pricePickerView = UIPickerView()
    private var priceRange = ["--", "Free", "Low", "Medium", "High"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
        
        priceTextField.inputView = pricePickerView
        priceTextField.text = priceRange[0]
        
        // Underline
        let attibuteString = NSMutableAttributedString(string: "Terms and conditions", attributes: yourAttributes)
        termsButton.setAttributedTitle(attibuteString, for: .normal)
        
        if check {
            starButton.isEnabled = true
        } else {
            starButton.isEnabled = false
        }
        
    }

    
    @IBAction func startButtonTapped(_ sender: UIButton) {
//        let activitiesVC = ActivitiesViewController()
//        activitiesVC.participantsInitial = participantsTextField.text ?? ""
//        navigationController?.pushViewController(activitiesVC, animated: true)
        
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .overFullScreen
        guard let participantsInitial = participantsTextField.text else { return }
        guard let priceRange = priceTextField.text else { return }
        tabBar.participantsInitial = participantsInitial
        tabBar.priceRange = priceRange
        tabBar.setupViewController()
        
        present(tabBar, animated: true)
    }
    
    @IBAction func termsButtonTapped(_ sender: UIButton) {
        let termsVC = TermsAndConditionsViewController {
            self.check = $0
            self.atuliazarTela()
        }
        termsVC.checkTerms = check
        termsVC.modalPresentationStyle = .overFullScreen
        present(termsVC, animated: true)
        
    }
    
    @IBAction func textField(_ sender: UITextField) {
        
        guard let participantsTextField = sender.text else { return }
        
        guard !CharacterSet(charactersIn: participantsTextField).isSubset(of: CharacterSet.decimalDigits) || participantsTextField == "0" || !check  else {
            starButton.isEnabled = true
            return
        }
        
        starButton.isEnabled = false
    }
    
    private func atuliazarTela() {
        DispatchQueue.main.async {
            if self.check {
                self.starButton.isEnabled = true
            } else {
                self.starButton.isEnabled = false
            }
        }
    }
    
}

extension InicioViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        priceRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceRange[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceTextField.text = priceRange[row]
        priceTextField.resignFirstResponder()
    }
    
    
}
