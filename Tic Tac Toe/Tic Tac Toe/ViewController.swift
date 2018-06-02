//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Pamela on 01/06/2018.
//  Copyright © 2018 Pamela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameActive = true
    
    //1 = cross, 2 = nought
    var player = 1;
    
    //0 = empty, 1 = cross, 2 = nought
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var win = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var winner = ""
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        //If spot is empty
        if gameState[sender.tag] == 0 && gameActive == true{
            var image = UIImage()
            gameState[sender.tag] = player
            
            if player == 1{
                image = UIImage(named: "cross.png")!
                player = 2
            }else{
                image = UIImage(named: "nought.png")!
                player = 1
            }
            sender.setImage(image, for: .normal)
            
            for combination in win{
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                    if gameState[combination[0]] == 1{
                        winner = "X"
                        
                    }else{
                        winner = "O"
                    }
                    winnerLabel.text = "Winner: " + String(winner)
                    winnerLabel.isHidden = false
                    restartButton.isHidden = false
                    gameActive = false
                }
            }
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        gameActive = true
        player = 1
        gameState = [0,0,0,0,0,0,0,0,0]
        var button : UIButton?
        for i in 0...9{
            button = view.viewWithTag(i) as? UIButton
            button?.setImage(nil, for: .normal)
        }
        winnerLabel.isHidden = true
        restartButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winnerLabel.isHidden = true
        restartButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

