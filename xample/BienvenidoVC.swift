//
//  BienvenidoVC.swift
//  xample
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class BienvenidoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnSalir(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTablaCobranzaVC" {
            let _ = segue.destination as! TablaCobranzaVC
            
        }
    }
    

}
