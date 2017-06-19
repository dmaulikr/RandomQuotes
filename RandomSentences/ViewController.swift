//
//  ViewController.swift
//  RandomSentences
//
//  Created by Dylan Saldana on 6/18/17.
//  Copyright © 2017 Dyl0n and Arod92. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteSpace.delegate = self as? UITextViewDelegate
        bySpace.delegate = self as? UITextViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
        let url1 = URL(string:"http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1")
        let task = URLSession.shared.dataTask(with: url1!) { (data, response, error) in
            if error != nil
            {
                print("ERROR")
            }
            else {
                if let content = data
                {
                    do
                    {
                        //array
                        let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                        let myarray = myJSON[0] as! NSDictionary
                        let mystring = myarray["content"] as! String
                        let newString = mystring.replacingOccurrences(of: "<p>", with: "", options: .literal, range: nil)
                        let newString2 = newString.replacingOccurrences(of: "</p>", with: "", options: .literal, range: nil)
                        let title = myarray["title"] as! String
                        NSLog(title)
                        NSLog(newString2)
                        DispatchQueue.main.async {
                            // Update UI
                            self.quoteSpace.text = newString2
                            self.bySpace.text = title
                        }
                        
                    }
                    catch {
                        
                    }
                }
            }
        }
 
            task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonAction(_ sender: UIButton) {
        //sender.setTitle("Something interesting.", for: .normal)
        let url = URL(string:"http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=20")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("ERROR")
            }
            else {
                if let content = data
                {
                    do
                    {
                        //array
                        let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                        
                        let myarray = myJSON[Int(arc4random_uniform(20))] as! NSDictionary
                        let mystring = myarray["content"] as! String
                        let newString = mystring.replacingOccurrences(of: "<p>", with: "", options: .literal, range: nil)
                        var newString3 = newString.replacingOccurrences(of: "</p>", with: "", options: .literal, range: nil)
                        let title = myarray["title"] as! String
                        NSLog(title)
                        NSLog(newString3)
                        newString3 = newString3.stringByDecodingHTMLEntities
                        
                        DispatchQueue.main.async {
                            // Update UI
                            self.quoteSpace.text = newString3
                            self.bySpace.text = title
                        }
                        
                    }
                    catch
                    {
                    }
                }
            }
        }
        task.resume()    }
    
    
    @IBOutlet weak var quoteSpace: UITextView!
    @IBOutlet weak var bySpace: UITextView!
}

