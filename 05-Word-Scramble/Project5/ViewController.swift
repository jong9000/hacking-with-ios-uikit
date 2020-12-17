//
//  ViewController.swift
//  Project5
//
//  Created by Jonathan Gentry on 12/15/20.
//

import UIKit

class ViewController: UITableViewController {

  var allWords = [String]()
  var usedWords = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
    
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
      }
    }
    
    if allWords.isEmpty {
      allWords = ["silkworm"]
    }
    
    startGame()
    
  }

  func startGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
  
  @objc func restartGame() {
    startGame()
  }
  
  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()
    
    let submitAction = UIAlertAction(title: "Submit", style: .default) {
      [weak self, weak ac] action in
      guard let answer = ac?.textFields?[0].text else { return }
      self?.submit(answer)
    }
    
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  func submit(_ answer: String) {
    
    let lowerAnswer = answer.lowercased()
    
    if isPossible(word: lowerAnswer) {
      if isOriginal(word: lowerAnswer) {
        if isReal(word: lowerAnswer) {
          
          if lowerAnswer.count < 3 {
            showErrorMessage(title: "Invalid", message: "Word must be at least 3 letters.")
            return
          } else if lowerAnswer == title {
            showErrorMessage(title: "Invalid", message: "Cannot be the same as base word.")
            return
          }
          
          usedWords.insert(lowerAnswer, at: 0)
          
          let indexPath = IndexPath(row: 0, section: 0)
          tableView.insertRows(at: [indexPath], with: .automatic)
          
          return
        } else {
          showErrorMessage(title: "Word not recognized.", message: "You can't just make them up you know!")
        }
      } else {
        showErrorMessage(title: "Word already used.", message: "Be more original")
      }
    } else {
      guard let title = title else { return }
      showErrorMessage(title: "Word not possible.",
                       message: "You can't spell that word from \(title.lowercased()).")
      }
  }
  
  func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }
    
    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        return false
      }
    }
    return true
  }
  
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
  }
  
  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func showErrorMessage(title errorTitle: String, message errorMessage: String) {
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

}

