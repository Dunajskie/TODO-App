//
//  TaskCell.swift
//  TODOApp
//
//  Created by Michał Dunajski on 05/12/2021.
//

import Foundation
import CoreData
import UIKit
class TaskCell : UITableViewCell {
  
  var task: ToDoItem? {
    didSet {
      NameLabel.text = task?.name
      DateLabel.text = task?.date?.formatted()
      switch task?.category {
      case "Work":
        TaskImage.image = UIImage(systemName: "folder")
      case "Shopping":
        TaskImage.image = UIImage(systemName: "cart")
      case "Other":
        TaskImage.image = UIImage(systemName: "diamond")
      default:
        return
      }
    }
  }
  
  let NameLabel:UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let DateLabel:UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let TaskImage:UIImageView = {
    let img = UIImageView()
    img.tintColor = .black
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    self.contentView.addSubview(NameLabel)
    self.contentView.addSubview(DateLabel)
    self.contentView.addSubview(TaskImage)
    
    TaskImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    TaskImage.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant:-10).isActive = true
    TaskImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    TaskImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    NameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant:15).isActive = true
    NameLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant:10).isActive = true

    DateLabel.topAnchor.constraint(equalTo:self.NameLabel.bottomAnchor).isActive = true
    DateLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant:10).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}



