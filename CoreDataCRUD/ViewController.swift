//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Divya Tejasvi on 1/22/19.
//  Copyright © 2019 Divya Tejasvi. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createData()
        retreiveData()
        updateData()
        deleteData()
    }
    
    func createData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)
        
        for i in 1...5{
            let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            user.setValue("Divya\(i)", forKey: "username")
            user.setValue("Test\(i)", forKey: "password")
            user.setValue("DivyaDT\(i)@gmail.com", forKey: "email")
        }
        
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("could not save data , \(error) , \(error.userInfo)")
        }
    }
    
    func retreiveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "username") as! String)
            }
        }catch let error as NSError{
            print("could not retreive data , \(error) , \(error.userInfo)")
        }
    }
    
    
    func updateData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Divya1")
        
        do{
            let dataFetched = try managedContext.fetch(fetchRequest)
            let objectUpdate = dataFetched[0] as! NSManagedObject
            objectUpdate.setValue("Divya Tejasvi", forKey: "username")
            objectUpdate.setValue("DivyaTejaDT@gmail.com", forKey: "email")
            
            do{
                try managedContext.save()
            }catch let error as NSError{
                print("could not update data , \(error) , \(error.userInfo)")
            }
            
        }catch let error as NSError{
            print("could not update data , \(error) , \(error.userInfo)")
        }
        
    }
    
    func deleteData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Divya2")
        
        do {
            let recordFetch = try managedContext.fetch(fetchRequest)
            let objectToDelete = recordFetch[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }catch let error as NSError{
                print("could not delete data , \(error) , \(error.userInfo)")
            }
            
        }catch let error as NSError{
            print("could not delete data , \(error) , \(error.userInfo)")
        }
    }
    
    
}

