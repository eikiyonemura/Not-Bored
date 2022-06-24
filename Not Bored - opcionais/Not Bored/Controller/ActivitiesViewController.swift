//
//  ActivitiesViewController.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 21/06/22.
//

import UIKit

class ActivitiesViewController: UIViewController {

    var activitiesArray: [String] = []
    var participantsInitial: String = ""
    var priceRange: String?
    
    @IBOutlet weak var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigationItem.hidesBackButton = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(shuffleButtonTapped(_:)))
//        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.title = "Activities"
        
        activitiesTableView.dataSource = self
        activitiesTableView.delegate = self
        activitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        activitiesTableView.rowHeight = 80
        
        getActivities()
        
    }
    
    private func getActivities() {
        for activity in Activities.allCases {
            activitiesArray.append(activity.name)
        }
    }
    
    @objc func shuffleButtonTapped(_ sender: UIBarButtonItem) {
        nextView(titulo: "Random", parcitipants: participantsInitial)
    }
    
    private func nextView(titulo: String, parcitipants: String) {
        let sugestionVC = SugestionViewController()
        sugestionVC.titulo = titulo
        sugestionVC.participantsInitial = parcitipants
        sugestionVC.priceRange = priceRange
        navigationController?.pushViewController(sugestionVC, animated: true)
    }
}

extension ActivitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextView(titulo: activitiesArray[indexPath.row], parcitipants: participantsInitial)        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = activitiesArray[indexPath.row]
        cell.backgroundColor = UIColor(red: 190/255, green: 227/255, blue: 252/255, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
