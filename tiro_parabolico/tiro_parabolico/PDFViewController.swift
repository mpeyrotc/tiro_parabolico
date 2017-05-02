//
//  PDFViewController.swift
//  tiro_parabolico
//
//  Created by Marco Peyrot on 4/29/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {
    @IBOutlet weak var pdfView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "Manual", withExtension: "pdf")
    
        if let url = url {
            
            let urlRequest = NSURLRequest(url: url)
            pdfView.loadRequest(urlRequest as URLRequest)
            
            view.addSubview(pdfView)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return UIInterfaceOrientationMask.landscape
        
    }
    
    override var shouldAutorotate: Bool {
        
        return false
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
