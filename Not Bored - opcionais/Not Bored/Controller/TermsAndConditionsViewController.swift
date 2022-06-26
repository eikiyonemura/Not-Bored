//
//  TermsAndConditionsViewController.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 17/06/22.
//

import UIKit
import Alamofire

class TermsAndConditionsViewController: UIViewController {
    
    var checkTerms: Bool?
    
    private var callback: ((Bool) -> Void)

    @IBOutlet weak var checkButton: UIButton!
    
    init(callback: @escaping ((Bool)) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        guard let checkTerms = checkTerms else {
            return
        }
        
        checkTerms ? checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal) : checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)

//        if checkTerms {
//            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill")
//        } else {
//            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//        }
        
    }


    @IBAction func closeButtonTapped(_ sender: UIButton) {
        //navigationController?.popViewController(animated: true)
        guard let check = checkTerms else {
            return
        }

        callback(check)
        dismiss(animated: true)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard let check = checkTerms else {
            return
        }

        if check {
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            checkTerms = false
        } else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkTerms = true
        }
    }
}
