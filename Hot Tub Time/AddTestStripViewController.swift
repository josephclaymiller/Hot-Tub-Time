//
//  AddTestStripViewController.swift
//  Hot Tub Time
//
//  Created by Joseph Miller on 12/20/21.
//

import UIKit

class AddTestStripViewController: UIViewController {
    // property in source class to hold a reference to the listener
    weak var delegate: TestStripDelegate?
    
    @IBOutlet var bromineControl: UISegmentedControl!
    @IBOutlet var alkalineControl: UISegmentedControl!
    @IBOutlet var phControl: UISegmentedControl!
    @IBOutlet var calciumControl: UISegmentedControl!
    
    let bromineChoices: [Int] = [0, 1, 3, 5, 10, 20]
    let alkalineChoices: [Int] = [0, 40, 80, 120, 180, 240]
    let phChoices: [Double] = [6.2, 6.8, 7.2, 7.6, 8.0, 8.4]
    let calciumChoices: [Int] = [0, 100, 250, 450, 800]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpSegments()
    }
    @IBAction func cancelAddingTestStrip(_ sender: Any) {
        print("cancel adding test strip")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTestStrip(_ sender: Any) {
        let testStrip = createStripFromSegmentControl()
        delegate?.addtestStrip(viewController: self, didTest: testStrip)
    }
    
    // replaces segment control segments as set up in storyboard to match data set in here instead
    func setUpSegments() {
        bromineControl.removeAllSegments()
        for (index, choice) in bromineChoices.enumerated() {
            bromineControl.insertSegment(withTitle: "\(choice)", at: index, animated: false)
            //bromineControl.setBackgroundImage(UIImage(named: "tbr_\(index)"), for: .normal, barMetrics: UIBarMetrics.default)
        }
        alkalineControl.removeAllSegments()
        for (index, choice) in alkalineChoices.enumerated() {
            alkalineControl.insertSegment(withTitle: "\(choice)", at: index, animated: false)
        }
        phControl.removeAllSegments()
        for (index, choice) in phChoices.enumerated() {
           phControl.insertSegment(withTitle: "\(choice)", at: index, animated: false)
        }
        calciumControl.removeAllSegments()
        for (index, choice) in calciumChoices.enumerated() {
            calciumControl.insertSegment(withTitle: "\(choice)", at: index, animated: false)
        }
    }
    
    func createStripFromSegmentControl() -> TestStrip? {
        print("Atempting to create test strip")
        guard bromineControl.selectedSegmentIndex > -1 else {
            print("Missing bromine reading")
            return nil
        }
        guard alkalineControl.selectedSegmentIndex > -1 else {
            print("Missing alkaline reading")
            return nil
        }
        guard phControl.selectedSegmentIndex > -1 else {
            print("Missing pH reading")
            return nil
        }
        guard calciumControl.selectedSegmentIndex > -1 else {
            print("Missing calcium hardness reading")
            return nil
        }
        let bromineReading: Int? = bromineChoices[bromineControl.selectedSegmentIndex]
        let alkalinityReading: Int? = alkalineChoices[alkalineControl.selectedSegmentIndex]
        let phReading: Double? = phChoices[phControl.selectedSegmentIndex]
        let calciumReading: Int? = calciumChoices[calciumControl.selectedSegmentIndex]
        
        return createStrip(bromine: bromineReading, alkaline: alkalinityReading, ph: phReading, calcium: calciumReading)
    }
    
//    func createStripFromTextFields() -> TestStrip? {
//        let bromineReading: Int? = Int(bromineTextField.text!)
//        let alkalinityReading: Int? = Int(alkalinityTextField.text!)
//        let phReading: Double? = Double(phTextField.text!)
//        let calciumReading: Int? = Int(calciumTextField.text!)
//
//        return createStrip(bromine: bromineReading, alkaline: alkalinityReading, ph: phReading, calcium: calciumReading)
//    }
    
    func createStrip(bromine: Int?, alkaline: Int?, ph: Double?, calcium: Int?) -> TestStrip? {
        guard let bromineReading = bromine else {
            print("Missing bromine reading")
            return nil
        }
        guard let alkalinityReading = alkaline else {
            print("Missing alkaline reading")
            return nil
        }
        guard let phReading = ph else {
            print("Missing pH reading")
            return nil
        }
        guard let calciumReading = calcium else {
            print("Missing calcium hardness reading")
            return nil
        }

        let bromine: TotalBromine = TotalBromine(bromineReading)
        let alkaline: Alkalinity = Alkalinity(alkalinityReading)
        let ph: HydrogenPotential = HydrogenPotential(phReading)
        let calcium: CalciumHardness = CalciumHardness(calciumReading)
        
        let testStrip = TestStrip(Strip.bromine(bromine, alkaline, ph, calcium))
        
        return testStrip
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

// Custum protocol has methods for event of pressing button to add test strip data
protocol TestStripDelegate: AnyObject {
    func addtestStrip(viewController: AddTestStripViewController, didTest testStrip: TestStrip?)
}
