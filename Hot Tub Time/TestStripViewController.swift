//
//  TestStripViewController.swift
//  Hot Tub Time
//
//  Created by Joseph Miller on 12/20/21.
//

import UIKit

class TestStripViewController: UIViewController {
    var strip: TestStrip!
    
    @IBOutlet var bromineLabel: UILabel!
    @IBOutlet var alkalinityLabel: UILabel!
    @IBOutlet var phLabel: UILabel!
    @IBOutlet var calciumLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var bromine: TotalBromine!
    var alkaline: Alkalinity!
    var ph: HydrogenPotential!
    var calcium: CalciumHardness!
    var date: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bromine = strip.TBr!
        alkaline = strip.ALk!
        ph = strip.pH!
        calcium = strip.CH!
        date = strip.date!
        bromineLabel.text = bromineMessage(bromine)
        alkalinityLabel.text = "\(alkaline.partsPerMillion) Alkalinity ppm"
        phLabel.text = "\(ph.reading) pH"
        calciumLabel.text = "\(calcium.partsPerMillion) Calcium Hardness ppm"
        dateLabel.text = "\(date!)"
    }
    
    func bromineMessage(_ bromine: TotalBromine) -> String {
        var message = "\(bromine.partsPerMillion) Total Bromine ppm"
        if !bromine.isGood() {
            if bromine.partsPerMillion < TotalBromine.idealRange.lowerBound {
                message += "\n less than ideal range"
            }
        }
        return message
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
