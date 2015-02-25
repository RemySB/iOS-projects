//
//  FrontViewController.swift
//  BlackJack
//
//  Created by Student on 2/24/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    @IBOutlet weak var PlayerStepper: UIStepper!
    @IBOutlet weak var DeckStepper: UIStepper!
    @IBOutlet weak var PlayersLabel: UILabel!
    @IBOutlet weak var DecksLabel: UILabel!
    

    @IBAction func PlayersChanged(sender: AnyObject) {
        PlayersLabel.text="Players: "+toString(PlayerStepper.value)
    }
    @IBAction func DecksChanged(sender: AnyObject) {
        DecksLabel.text="Decks: "+toString(DeckStepper.value)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
