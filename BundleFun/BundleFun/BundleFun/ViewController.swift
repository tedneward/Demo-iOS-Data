//
//  ViewController.swift
//  BundleFun
//
//  Created by Ted Neward on 3/27/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var bundles : [Bundle] = [Bundle.main] + Bundle.allFrameworks
    var currentBundle = Bundle.main
    
    @IBOutlet weak var lblBundleIdentifier: UILabel!
    @IBOutlet weak var pckBundles: UIPickerView!
    @IBOutlet weak var lblBundlePath: UILabel!
    @IBOutlet weak var segBundlePaths: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pckBundles.dataSource = self
        pckBundles.delegate = self
        
        segBundlePaths.selectedSegmentIndex = 0
        refresh()
    }
    
    func refresh() {
        lblBundleIdentifier!.text = currentBundle.bundlePath
        lblBundlePath!.text = currentBundle.resourcePath
    }

    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bundles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bundles[row].bundleIdentifier
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentBundle = bundles[row]
        refresh()
    }

    @IBAction func bundlePathChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        NSLog("bundlePathChanged")
        switch sender.selectedSegmentIndex {
        case 0: lblBundlePath!.text = currentBundle.resourcePath; break;
        case 1: lblBundlePath!.text = currentBundle.executablePath; break;
        case 2: lblBundlePath!.text = currentBundle.privateFrameworksPath; break;
        case 3: lblBundlePath!.text = currentBundle.sharedFrameworksPath; break;
        case 4: lblBundlePath!.text = currentBundle.sharedSupportPath; break;
        default: lblBundlePath!.text = "Unrecognized option";
        }
    }
    
}

