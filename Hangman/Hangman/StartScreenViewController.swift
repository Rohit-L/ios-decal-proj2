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
    var startGameBtn: UIButton = UIButton()
    
    func startNewGameButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.gameTitle.text = "HangMan"
        self.gameTitle.font = UIFont(name: "HelveticaNeue-UltraLight", size: 65)
        self.gameTitle.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.gameTitle)
        self.gameTitle.translatesAutoresizingMaskIntoConstraints = false
        self.gameTitle.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: CGFloat(100.0)).isActive = true
        self.gameTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.gameTitle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.gameTitle.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        
        self.startGameBtn.setTitle("Start New Game", for: UIControlState.normal)
        self.startGameBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.startGameBtn.setTitleColor(UIColor.blue, for: UIControlState.highlighted)
        self.startGameBtn.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        self.startGameBtn.titleLabel!.textAlignment = NSTextAlignment.center
        self.startGameBtn.backgroundColor = .clear
        self.startGameBtn.layer.cornerRadius = 5
        self.startGameBtn.layer.borderWidth = 1
        self.startGameBtn.layer.borderColor = UIColor.black.cgColor
        self.startGameBtn.addTarget(self, action: #selector(StartScreenViewController.startNewGameButtonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(self.startGameBtn)
        self.startGameBtn.translatesAutoresizingMaskIntoConstraints = false
        self.startGameBtn.topAnchor.constraint(greaterThanOrEqualTo: gameTitle.topAnchor, constant: CGFloat(200.0)).isActive = true
        self.startGameBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.startGameBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.startGameBtn.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        
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
