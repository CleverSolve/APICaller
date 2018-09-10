//
//  MyAPITableViewController.swift
//  API Caller
//
//  Created by Work on 9/4/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit
import Foundation



class MyAPITableViewController: UITableViewController
{
    
    // Courses Array
    var courses = [Course]()

    //MARK: ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         apiCall()
    }
    
    // Course Struct
    struct Course: Decodable
    {
        let id: Int
        let name: String
        let link: String

        let numberOfLessons: Int
        let imageUrl: String
        
    }
    
    //MARK: API CALL FUNCTION
    fileprivate func apiCall()
    {

        // JSon URL
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_snake_case"
        
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url)
        {
            (data, _, err) in
            
            DispatchQueue.main.async
            {
                if let err = err
                {
                    print("Failed to get data from url:", err)
                    return
                }
            }

            
            // Check that the url exists?
            guard let data = data else {return}
            
            do{
                
                let decoder = JSONDecoder()
                
                // Swift 4.1
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                self.tableView.reloadData()
            }catch let jsonErr
            {
                print("Failed to decode:", jsonErr)
            }
            
            
            }.resume()
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    //MARK: NumberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return courses.count
    }

    //MARK: HeightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    //MARK: CellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAPICell", for: indexPath) as! MyAPITableViewCell
        
        let course = courses[indexPath.row]
        
        //---This is for displaying the image----------------
        let url = URL(string: course.imageUrl)
        let imgdata = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        //------------------------------
        
        // Formatted Text
        let formattedID = NSMutableAttributedString()
        formattedID
            .bold("ID: ")
            .normal(String(course.id))
        
        let formattedName = NSMutableAttributedString()
        formattedName
            .bold("Name: ")
            .normal(course.name)

        let formattedLink = NSMutableAttributedString()
        formattedLink
            .bold("Link: ")
            .normal(course.link)
        
        let formattedImgUrl = NSMutableAttributedString()
        formattedImgUrl
            .bold("ImgUrl: ")
            .normal(course.imageUrl)
        
        let formattedNumOfLessons = NSMutableAttributedString()
        formattedNumOfLessons
            .bold("Lessons: ")
            .normal(String(course.numberOfLessons))
            // -----Format Text-----
        
        
        // ---Round the Image Corners---
        cell.CImgView.layer.cornerRadius = 10;
        cell.CImgView.layer.masksToBounds = true;
        
        //cell.ID.text = "ID: " + String(course.id)
        //cell.Name.text = "Name: " + course.name
        //cell.Link.text = "Link: " + course.link
        //cell.ImgUrl.text = "Image: " + course.imageUrl
        //cell.NumOfLessons.text = "Lessons: " + String(course.numberOfLessons)
        
        
        // ---Write formatted info to cell--
        cell.ID.attributedText = formattedID
        cell.Name.attributedText = formattedName
        cell.Link.attributedText = formattedLink
        cell.ImgUrl.attributedText = formattedImgUrl
        cell.CImgView.image = UIImage(data: imgdata!)
        cell.NumOfLessons.attributedText = formattedNumOfLessons
        
        

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // NEED TO MOVE THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         let course = courses[indexPath.row]
        
        let url = URL(string: course.link)
        let imgdata = try? Data(contentsOf: url!)
        // NEED TO MOVE THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        
        
        
        // <ggonza> Deselects the row after it has been selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ROW CODE
        
        if(indexPath.row == 0)
        {
            UIApplication.shared.openURL(NSURL(string: course.link)! as URL)
        }
        if(indexPath.row == 1)
        {
            UIApplication.shared.openURL(NSURL(string: course.link)! as URL)
        }
        if(indexPath.row == 2)
        {

            UIApplication.shared.openURL(NSURL(string: course.link)! as URL)
        }
    }
}

// For Making Text Bold
extension NSMutableAttributedString
{
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString
    {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "Roboto-Bold", size: 17)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString
    {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
