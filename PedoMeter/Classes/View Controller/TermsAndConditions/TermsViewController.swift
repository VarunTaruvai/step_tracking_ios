//
//  TermsViewController.swift
//  PedoMeter
//
//  Created by Ankit  Jain on 10/04/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import WebKit

class TermsViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {

    @IBOutlet weak var tblView: UITableView!
    var studyCode : String = ""
    var webHgt = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.startLoading(self.view)
        tblView.register(UINib(nibName: "TermsCell", bundle: nil), forCellReuseIdentifier: "TermsCell")
        tblView.estimatedRowHeight = 1000
        self.tblView.reloadData()
        self.navigationItem.hidesBackButton = true
        self.commonNavigationBar(title: "Terms of use", controller: Constant.Controllers.Terms)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- UIButtonActions

    @IBAction func disagreeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func agreeBtnAction(_ sender: Any) {
        moveToLogin()
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
//MARK:- Table Properties
extension TermsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TermsCell", for: indexPath) as! TermsCell
        
        if webHgt == 0
        {
        cell.webView.load(URLRequest(url: URL(string: "https://licenseagreement.herokuapp.com/index.html")!))
        cell.webView.navigationDelegate = self
        }
        
        cell.webHgt.constant = CGFloat(self.webHgt)
        //cell.webView.uiDelegate = self

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       // return   UITableView.automaticDimension
        return   2500.0
    }
    
    
    func moveToLogin()
    {
        let vc = Constant.Controllers.Login.get() as! LoginVC
        vc.studyCode = self.studyCode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        Utils.stopLoading()
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
        if complete != nil {
            webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
              //  self.containerHeight.constant = height as! CGFloat
                print("Container Height",height)
                self.webHgt = height as! Double
                self.tblView.reloadData()
                
            })
        }

        })
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    {
        Utils.stopLoading()
    }
    
    
}
