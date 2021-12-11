//
//  CoreDataOperations.swift
//  TODOApp
//
//  Created by Michał Dunajski on 05/12/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataOperations {
  
  let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var items = [ToDoItem]()
  static var itemsAdded = false
  
  func getItems() {
    do {
      items = try context.fetch(ToDoItem.fetchRequest())
    } catch {}
  }
  
  func deleteItem(item: ToDoItem) {
    context.delete(item)
    do {
      try context.save()
      getItems()
    } catch {}
  }
  
  func addItem(name: String, date: Date, category: String) {
    let newItem = ToDoItem(context: context)
    newItem.name = name
    newItem.date = date
    newItem.category = category
    CoreDataOperations.itemsAdded = true
    do {
      try context.save()
    } catch {}
  }
}
