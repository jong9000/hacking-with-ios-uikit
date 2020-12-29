//
//  ViewController.swift
//  Project2
//
//  Created by Jonathan Gentry on 11/13/20.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var correctAnswer = 0
  var score = 0
  var questionsAsked = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }
  
  func askQuestion(action: UIAlertAction! = nil) {
    
    questionsAsked += 1
    if questionsAsked > 10 {
      let ac = UIAlertController(title: "Game Over", message: "You got \(score) out of 10 correct.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: startOver))
      present(ac, animated: true)
    }
    
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    
    title = "Country: \(countries[correctAnswer].uppercased())     SCORE:\(score)"
  }
  
  func startOver(action: UIAlertAction! = nil) {
    questionsAsked = 0
    score = 0
    askQuestion()
  }

  @IBAction func buttonTapped(_ sender: UIButton) {

    var title: String

    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
      
      let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
      present(ac, animated: true)
      
    } else {
      title = "WRONG!"
      score -= 1
      let wrongAnswer = countries[sender.tag]
      
      let ac = UIAlertController(title: title, message: "This is the flag of \(wrongAnswer.uppercased()).", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
      present(ac, animated: true)
    }
    
  }
  
}




//func askQuestion() {
//    button1.setImage(UIImage(named: countries[0]), for: .normal)
//    button2.setImage(UIImage(named: countries[1]), for: .normal)
//    button3.setImage(UIImage(named: countries[2]), for: .normal)
//}
