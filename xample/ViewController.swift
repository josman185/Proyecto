//
//  ViewController.swift
//  xample
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernamatxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnEntrar(_ sender: Any) {
        let request = URLRequest(url: URL(string: "\(Constantes.URL_DESA.apiWSLogin)?username=\(usernamatxt.text!)&password=\(passwordtxt.text!.toBase64())")!)
        
        // user: salvatore.isc@gmail.com
        // pass: salvapunk
        
        let task = URLSession.shared.dataTask(with: request) { (data, resp, error) in
            if error != nil {
                print("\(String(describing: error))")
            } else {
                if let info = data {
                    do {
                        let jsonresult = try JSONSerialization.jsonObject(with: info) as! [String: AnyObject]
                        print(jsonresult)
                        if let status = jsonresult["status"] {
                            if status as! Int == 1 {
                                print("welcome")
                                DispatchQueue.main.async {
                                    let bvc = self.storyboard?.instantiateViewController(withIdentifier: "bienvenidoStoryBid")
                                    self.present(bvc!, animated: true, completion: nil)
                                }
                            } 
                        }
                    } catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
    

    @IBAction func botonCompartir(_ sender: Any) {
        //let other = UIImage(named: "dogs")
        //let bundle = NSBundle(forClass: self.dynamicType)

        let image = UIImage(named: "dogs", in: Bundle.main, compatibleWith: nil)
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

