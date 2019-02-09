//
//  ViewController.swift
//  Regex Tester 2
//
//  Created by James Flanagan on 1/18/19.
//  Copyright © 2019 James Flanagan. All rights reserved.

//  https://benscheirman.com/2014/06/regex-in-swift/
//https://stackoverflow.com/questions/25525171/uitextview-highlight-all-matches-using-swift
//http://www.thomashanning.com/uitableview-tutorial-for-beginners/
//another comment

import UIKit

class ViewController: UIViewController, UITableViewDataSource
{
 
    private var data: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return countRegex
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        
        let text = data[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell
    }
    

    @IBOutlet weak var regexObject: UITextField!
    
    @IBOutlet weak var targetObject: UITextView!
    
    @IBOutlet weak var resultObject: UILabel!
    
    @IBOutlet weak var tableObject: UITableView!
    
    var regexText : String = ""
    var targetText : String = ""
    
    var error: NSError?
    
    var resultingMatches : NSTextCheckingResult? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetObject.layer.cornerRadius = 5
        targetObject.layer.borderColor = UIColor.purple.cgColor
        targetObject.layer.borderWidth = 1
        
        tableObject.dataSource = self
        
//        regexObject.addTarget(self, action: NSSelectorFromString("regexChanged"), for: UIControl.Event.editingChanged)
    }

    
 
    
    @IBAction func regexChanged(_ sender: Any) {
        regexText = regexObject.text!
        targetText = targetObject.text!
        let attributed = NSMutableAttributedString(string: targetObject.text)


        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue", size: 20.0)!, range: NSMakeRange(0, targetText.count))

        attributed.removeAttribute(NSAttributedString.Key.backgroundColor,  range: NSMakeRange(0, targetText.count))
        
        do {

            let regex =  try NSRegularExpression(pattern: regexText, options: .caseInsensitive)

            let resultingMatches = regex.matches(in: targetText, range:NSMakeRange(0, targetText.count))

            data.removeAll()


            resultObject.text = "\(resultingMatches.count)"


            for match in resultingMatches
            {
            attributed.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: match.range)

                data.append(String(targetText[Range(match.range, in: targetText)!]))
            }
            targetObject.attributedText = attributed

            self.tableObject.reloadData()

        }
        catch {
            print(self.error)
        }
    }
    
    
}

