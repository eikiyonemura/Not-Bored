//
//  SugestionViewController.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 21/06/22.
//

import UIKit
import Alamofire

class SugestionViewController: UIViewController {
    
    var titulo: String?
    var participantsInitial: String?
    
    var urlString: String = "http://www.boredapi.com/api/activity/?"
    
    var activity: String?
    var parctcipants: Int?
    var price: String?
    var type: String?

    var priceRange: String?
    
    let sugestionService = SugestionService()
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tryAnotherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationItem.title = titulo
        
        guard let titulo = titulo else {
            return
        }
        
//        guard let participantsInitial = participantsInitial else {
//            return
//        }
//
//        guard let priceRange = priceRange else {
//            return
//        }
        
        if titulo == "Random" {
            getURLString()

        } else {
            categoryImage.isHidden =  true
            categoryLabel.isHidden = true
            urlString = urlString + "type=\(titulo.lowercased())"
            getURLString()
            
        }

        getSugestion(urlString)
        
    }

    @IBAction func tryAnotherButtonTapped(_ sender: UIButton) {
        getSugestion(urlString)
    }
    
    private func getSugestion(_ urlString: String) {

        sugestionService.getSugestion(urlString: urlString) { sugestion in
            guard let sugestion = sugestion else {
                let ac = UIAlertController(title: "Search error", message: "There were no activities found using this parameters.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
                self.tryAnotherButton.isEnabled = false
                return
            }

            DispatchQueue.main.async {
                self.activityLabel.text = sugestion.activity
                self.participantsLabel.text = "\(sugestion.participants)"
                self.priceLabel.text = self.getPrice(price: sugestion.price)
                self.categoryLabel.text = sugestion.type.capitalized
            }
        }
    }
        
    private func getPrice(price: Double) -> String {
        switch price {
            case 0:
                return "Free"
            case 0.01...0.30:
                return "Low"
            case 0.31...0.60:
                return "Medium"
        default:
            return "High"
        }
    }
    
    func getURLString() {
        guard let participantsInitial = participantsInitial else {
            return
        }

        if participantsInitial != "" {
            urlString = urlString + "&participants=\(participantsInitial)"
        }
        if priceRange != "--" {
            switch priceRange {
            case "Free":
                urlString = urlString + "&price=0.0"
            case "Low":
                urlString = urlString + "&minprice=0.01&maxprice=0.30"
            case "Medium":
                urlString = urlString + "&minprice=0.31&maxprice=0.60"
            default:
                urlString = urlString + "&minprice=0.61&maxprice=1.00"
            }
        }
    }
}
