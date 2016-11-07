//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    var text: UITextField = UITextField()
    var gameTitle: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.text.placeholder = "Enter ToDo Item"
//        self.text.borderStyle = UITextBorderStyle.roundedRect
//        self.view.addSubview(self.text)
//        self.text.translatesAutoresizingMaskIntoConstraints = false
//        self.text.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: CGFloat(100.0)).isActive = true
//        self.text.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        self.text.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        self.text.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        
        self.gameTitle.text = "HangMan";
        self.gameTitle.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
        self.gameTitle.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.gameTitle)
        self.gameTitle.translatesAutoresizingMaskIntoConstraints = false
        self.gameTitle.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: CGFloat(100.0)).isActive = true
        self.gameTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.gameTitle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.gameTitle.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
