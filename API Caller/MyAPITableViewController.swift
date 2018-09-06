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
    let URL_IMAGE = URL(string: "http://static3.businessinsider.com/image/5484d9d1eab8ea3017b17e29/9-science-backed-reasons-to-own-a-dog.jpg")
    
    // Courses Array
    var courses = [Course]()

    //MARK: ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         apiCall()
        
        // TESTING
        
//        let session = URLSession(configuration: .default)
//
//        let getImageFromUrl = session.dataTask(with: URL_IMAGE!){ (data, response, error) in
//
//            if let e = error
//            {
//                print("An error occured: \(e)")
//            }
//            else
//            {
//                if(response as? HTTPURLResponse) != nil
//                {
//                    if let imageData = data
//                    {
//                        let image = UIImage(data: imageData)
//
//                        CImgView.image = image
//                    }
//                    else
//                    {
//                        print("no image found")
//                    }
//                }
//                else
//                {
//                    print("No respose from server")
//                }
//            }
//
//        }
//        getImageFromUrl.resume()
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
        
        //>> testing

        //>> testing
        
        cell.ID.text = "ID: " + String(course.id)
        cell.Name.text = "Name: " + course.name
        cell.Link.text = "Link: " + course.link
        cell.ImgUrl.text = "Image: " + course.imageUrl
        cell.NumOfLessons.text = "Number of Lessons: " + String(course.numberOfLessons)
        
        //>> testing
        //cell.CImgView.image = imageUrl
        //>> testing
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
         let course = courses[indexPath.row]
        
        // <ggonza> Deselects the row after it has been selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        // <ggonza> Create an alert message
        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row)", preferredStyle: .alert)
        
        // <ggonza> OK button on the alert Message
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        // <ggonza> <?> adds the ok button to the alert message
        alertController.addAction(alertAction)
        
        // <ggonza> if Extra is selected
        if(indexPath.row == 0)
        {
            alertController.title = "Message"
            alertController.message = "You selected: " + course.name
            // <ggonza> Displays the alert controller
            present(alertController, animated: true, completion: nil)
        }
        if(indexPath.row == 1)
        {
            alertController.title = "Message"
            alertController.message = "You selected: " + course.name
            // <ggonza> Displays the alert controller
            present(alertController, animated: true, completion: nil)
        }
        if(indexPath.row == 2)
        {
            alertController.title = "Message"
            alertController.message = "You selected: " + course.name
            // <ggonza> Displays the alert controller
            present(alertController, animated: true, completion: nil)
        }
        
      
    }
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

