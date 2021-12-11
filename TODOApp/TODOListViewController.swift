//
//  TODOListViewController.swift
//  TODOApp
//
//  Created by Michał Dunajski on 05/12/2021.
//

import UIKit
import NotificationBannerSwift

class TODOListViewController: UIViewController {

  private lazy var tableView = UITableView()
  var deleteTaskIndexPath: IndexPath? = nil
  let coreOperations = CoreDataOperations()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupHierarchy()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    coreOperations.getItems()
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    if CoreDataOperations.itemsAdded {
      presentNotification()
      CoreDataOperations.itemsAdded = false
    }
  }
}

extension TODOListViewController {
  
  func setupViews() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
    navigationItem.title = "Tasks List"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    navigationController?.navigationBar.tintColor = .white
    tableView.register(TaskCell.self, forCellReuseIdentifier: "tasks")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func setupHierarchy() {
    view.addSubview(tableView)
  }
  
  func setupConstraints() {
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  @objc func addTapped() {
    let addView = AddTaskViewController()
    self.navigationController?.pushViewController(addView, animated: true)
  }
  
  func presentNotification() {
    let banner = StatusBarNotificationBanner(title: "Task Added", style: .success)
    banner.show()
  }
}

extension TODOListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func confirmDelete() {
    let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to permanently delite this task?", preferredStyle: .alert)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteTask)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteTask)
    alert.addAction(deleteAction)
    alert.addAction(cancelAction)
  
    self.present(alert, animated: true, completion: nil)
  }
  
  func handleDeleteTask(alertAction: UIAlertAction!) -> Void {
    if let indexPath = deleteTaskIndexPath {
      tableView.beginUpdates()
      let cellTask = self.coreOperations.items[indexPath.row]
      self.coreOperations.deleteItem(item: cellTask)
      tableView.deleteRows(at: [indexPath], with: .fade)
      deleteTaskIndexPath = nil
      tableView.endUpdates()
    }
  }
  
  func cancelDeleteTask(alertAction: UIAlertAction!) {
    deleteTaskIndexPath = nil
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    70
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if coreOperations.items.count == 0 {
      self.tableView.setEmptyMessage("You dont have any tasks")
    } else {
      self.tableView.restore()
    }
    return coreOperations.items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TaskCell
    cell.task = coreOperations.items[indexPath.row]
    return cell
  }
    
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .delete
  }
    
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteTaskIndexPath = indexPath
      confirmDelete()
    }
  }
}


extension UITableView {

  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font.withSize(20)
    messageLabel.sizeToFit()

    self.backgroundView = messageLabel
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}

