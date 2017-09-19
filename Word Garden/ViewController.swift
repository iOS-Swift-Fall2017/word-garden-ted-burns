//
//  ViewController.swift
//  Word Garden
//
//  Created by Teddy Burns on 9/18/17.
//  Copyright © 2017 Teddy Burns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
    }

    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    func guessALetter() {
        guessCount += 1
        //Update letters guessed and update UI
        let currentLetterGuessed = guessedLetterField.text!
        lettersGuessed += currentLetterGuessed
        formatUserGuessLabel()
        
        //Decrement wrong guesses remaining
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
    }
    
    func stopGame() {
        guessedLetterField.isEnabled = false
        playAgainButton.isHidden = false
    }
    
    func newGame() {
        guessedLetterField.isEnabled = true
        playAgainButton.isHidden = true
        lettersGuessed = ""
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        flowerImageView.image = UIImage(named: "flower8")
        guessCountLabel.text = "You've Made 0 Guesses"
        formatUserGuessLabel()
        guessCount = 0
        
    }
    
    func formatUserGuessLabel() {
        
        var outputString = ""
        
        for letter in wordToGuess {
            outputString += " "
            if lettersGuessed.contains(letter) {
                outputString += String(letter)
            } else {
                outputString += "_"
            }
        }
        outputString.removeFirst()
        userGuessLabel.text = outputString
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder() // Dismiss keyboard
        guessedLetterField.text = "" // Blank out text
        
        // Stop if game is done
        if wrongGuessesRemaining == 0 {
            guessCountLabel.text = "You Lost. Try Again?"
            stopGame()
        }
        else if !userGuessLabel.text!.contains("_") {
            stopGame()
            guessCountLabel.text = "Victory Screech!!!! Try Again? It Took You \(guessCount) Guess\(guessCount == 1 ? "" : "es")"
        } else {
            guessCountLabel.text = "You've Made \(guessCount) Guess\(guessCount == 1 ? "" : "es")"
        }
        
        guessButton.isEnabled = false
    }

    @IBAction func guessedLetterFieldChanged(_ sender: Any) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessButton.isEnabled = true
        } else {
            guessButton.isEnabled = false
        }
    }
}

