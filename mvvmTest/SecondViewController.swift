//
//  SecondViewController.swift
//  mvvmTest
//
//  Created by hyunny on 2020/12/15.
//  Copyright © 2020 ochjjy. All rights reserved.
//

import UIKit
import Foundation


class SecondViewController: UIViewController {
    let HandleData = ViewModel.view_model

    @IBOutlet weak var tableView: UITableView!
    
    //ver dataCells = tableViewCell() as UITable
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Second View"
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        
        
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

/*
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HandleData.get_model_data().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view_data = HandleData.get_model_data()
        //let cell =
    }
    
    
    
}
*/
