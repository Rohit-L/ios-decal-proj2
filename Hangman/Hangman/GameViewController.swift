//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var phrase: String = ""
    var guesses: [String] = Array()
    var guessLabel: UILabel = UILabel()
    var incorrectGuesses: UILabel = UILabel()
    var guessTextField: UITextField = UITextField()
    var guessBtn: UIButton = UIButton()
    var image: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        self.phrase = hangmanPhrases.getRandomPhrase()
        print(self.phrase)

        let image = UIImage(named: "hangman1")
        self.image.image = image
        self.view.addSubview(self.image)
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: CGFloat(100.0)).isActive = true
        self.image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.image.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
        
        self.guessLabel.text = self.guessString()
        self.guessLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 25)
        self.guessLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.guessLabel)
        self.guessLabel.translatesAutoresizingMaskIntoConstraints = false
        self.guessLabel.topAnchor.constraint(greaterThanOrEqualTo: self.image.topAnchor, constant: CGFloat(150.0)).isActive = true
        self.guessLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.guessLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.guessLabel.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        self.guessLabel.lineBreakMode = .byWordWrapping
        self.guessLabel.numberOfLines = 0
        
        self.incorrectGuesses.text = "No Incorrect Guesses Yet!"
        self.incorrectGuesses.font = UIFont(name: "HelveticaNeue-UltraLight", size: 25)
        self.incorrectGuesses.lineBreakMode = .byWordWrapping
        self.incorrectGuesses.numberOfLines = 0
        self.incorrectGuesses.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.incorrectGuesses)
        self.incorrectGuesses.translatesAutoresizingMaskIntoConstraints = false
        self.incorrectGuesses.topAnchor.constraint(greaterThanOrEqualTo: self.guessLabel.topAnchor, constant: CGFloat(100.0)).isActive = true
        self.incorrectGuesses.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.incorrectGuesses.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.incorrectGuesses.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        
        self.guessTextField.placeholder = "Enter Guess"
        self.guessTextField.returnKeyType = .go
        self.guessTextField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(self.guessTextField)
        self.guessTextField.translatesAutoresizingMaskIntoConstraints = false
        self.guessTextField.topAnchor.constraint(greaterThanOrEqualTo: self.incorrectGuesses.topAnchor, constant: CGFloat(100.0)).isActive = true
        self.guessTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.guessTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.guessTextField.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
        self.guessTextField.addTarget(self, action: #selector(GameViewController.guessFieldEdited(sender:)), for: UIControlEvents.editingChanged)
        self.guessTextField.addTarget(self, action: #selector(GameViewController.disableKeyboard(sender:)), for: UIControlEvents.primaryActionTriggered)
        
        self.guessBtn.setTitle("Guess", for: UIControlState.normal)
        self.guessBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.guessBtn.setTitleColor(UIColor.blue, for: UIControlState.highlighted)
        self.guessBtn.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        self.guessBtn.titleLabel!.textAlignment = NSTextAlignment.center
        self.guessBtn.backgroundColor = .clear
        self.guessBtn.layer.cornerRadius = 5
        self.guessBtn.layer.borderWidth = 1
        self.guessBtn.layer.borderColor = UIColor.black.cgColor
        self.guessBtn.addTarget(self, action: #selector(GameViewController.guessCharacter(sender:)), for: .touchUpInside)
        self.view.addSubview(self.guessBtn)
        self.guessBtn.translatesAutoresizingMaskIntoConstraints = false
        self.guessBtn.topAnchor.constraint(greaterThanOrEqualTo: self.guessTextField.topAnchor, constant: CGFloat(50.0)).isActive = true
        self.guessBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.guessBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.guessBtn.widthAnchor.constraint(equalToConstant: CGFloat(300)).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func guessString() -> String {
        self.guessTextField.resignFirstResponder()
        var wonGame = true
        var correctGuesses: [String] = Array()
        var guessString = ""
        for char in self.phrase.characters {
            if (char == " ") {
                guessString += " "
            } else {
                var charGuessed = false
                for guess in self.guesses {
                    if (String(char) == guess) {
                        charGuessed = true
                        if !correctGuesses.contains(guess) {
                            correctGuesses.append(guess)
                        }
                    }
                }
                if charGuessed {
                    guessString += String(char)
                } else {
                    guessString += "_"
                    wonGame = false
                }
            }
        }
        
        if wonGame {
            self.gameWon()
        }
        
        var numIncorrect = 0
        var incorrectGuesses = "Incorrect Guesses:\n"
        for guess in self.guesses {
            if !correctGuesses.contains(guess) {
                incorrectGuesses += guess + " "
                numIncorrect += 1
            }
        }
        self.incorrectGuesses.text = incorrectGuesses
        
        switch numIncorrect {
        case 0:
            self.image.image = UIImage(named: "hangman1")
        case 1:
            self.image.image = UIImage(named: "hangman2")
        case 2:
            self.image.image = UIImage(named: "hangman3")
        case 3:
            self.image.image = UIImage(named: "hangman4")
        case 4:
            self.image.image = UIImage(named: "hangman5")
        case 5:
            self.image.image = UIImage(named: "hangman6")
        default:
            self.image.image = UIImage(named: "hangman7")
            self.gameLost()
        }
        
        return guessString
    }
    
    func guessFieldEdited(sender: UITextField) {
        var text = sender.text!
        var lastChar = String(text.characters.suffix(1))
        let invalidCharacters = NSCharacterSet.letters.inverted
        
        if text == "" {
            return
        }

        if (text.characters.count > 1) || (invalidCharacters.contains(lastChar.unicodeScalars.first!)) {
            text.remove(at: text.index(before: text.endIndex))
        }
        
        sender.text = text.capitalized
    }
    
    func guessCharacter(sender: UIButton) {
        var text = self.guessTextField.text!
        if text == "" {
            return
        }
        self.guessTextField.text = ""
        let charToGuess = String(text.characters.suffix(1))
        if self.guesses.contains(charToGuess) {
            return
        } else {
            self.guesses.append(charToGuess)
            self.guessLabel.text = self.guessString()
        }
    }
    
    func disableKeyboard(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameWon() {
        let alertController = UIAlertController(title: "Nice Job!", message: "You have won the game.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Play Again", style: .default, handler: {(action: UIAlertAction) -> Void in
            (self.navigationController?.pushViewController(GameViewController(), animated: false))!
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameLost() {
        let alertController = UIAlertController(title: "Uh oh!", message: "You have lost the game.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Play Again", style: .default, handler: {(action: UIAlertAction) -> Void in
            (self.navigationController?.pushViewController(GameViewController(), animated: false))!
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
