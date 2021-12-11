//
//  AddTaskViewController.swift
//  TODOApp
//
//  Created by Michał Dunajski on 05/12/2021.
//

import UIKit
import NotificationBannerSwift

class AddTaskViewController: UIViewController {
  
  let scrollView = UIScrollView()
  let nameLabel = UILabel()
  let dateLabel = UILabel()
  let categoryLabel = UILabel()
  let nameTextField = UITextField()
  let datePicker = UIDatePicker()
  let categoryPicker = UIPickerView()
  let addButton = UIButton()
  let cancelButton = UIButton()
  let stackView = UIStackView()
  let bottomView = UIView()
  let contentView = UIView()
  var name: String?
  var date: Date?
  var category: String = "Work"
  let coreOperations = CoreDataOperations()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupHierarchy()
      setupConstraints()
  }
}

extension AddTaskViewController {
  func setupViews() {
    self.navigationItem.title = "Add new task"
    view.backgroundColor = .white
    self.navigationItem.setHidesBackButton(true, animated: false)
    
    nameLabel.text = "TASK NAME"
    nameLabel.textColor = .black
    nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    dateLabel.text = "DATE"
    dateLabel.textColor = .black
    dateLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    categoryLabel.text = "CATEGORY"
    categoryLabel.textColor = .black
    categoryLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.spacing = 30
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    bottomView.backgroundColor = .black
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    
    addButton.backgroundColor = .green
    addButton.setTitle("ADD", for: .normal)
    addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    addButton.layer.cornerRadius = 7
    addButton.translatesAutoresizingMaskIntoConstraints = false
    
    cancelButton.backgroundColor = .red
    cancelButton.setTitle("CANCEL", for: .normal)
    cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    cancelButton.layer.cornerRadius = 7
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    
    categoryPicker.delegate = self
    categoryPicker.translatesAutoresizingMaskIntoConstraints = false
    
    nameTextField.placeholder = "Enter task name:"
    nameTextField.font = UIFont.systemFont(ofSize: 15)
    nameTextField.borderStyle = .roundedRect
    nameTextField.autocorrectionType = UITextAutocorrectionType.no
    nameTextField.keyboardType = UIKeyboardType.default
    nameTextField.returnKeyType = UIReturnKeyType.done
    nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
    nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    nameTextField.backgroundColor = .systemGray6
    nameTextField.delegate = self
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize = CGSize(width: view.frame.width, height: 540)
  }
  
  func setupHierarchy() {
    view.addSubview(scrollView)
    view.addSubview(bottomView)
    scrollView.addSubview(contentView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(categoryLabel)
    contentView.addSubview(nameTextField)
    contentView.addSubview(datePicker)
    contentView.addSubview(categoryPicker)
    bottomView.addSubview(stackView)
    stackView.addArrangedSubview(addButton)
    stackView.addArrangedSubview(cancelButton)
  }
  
  func setupConstraints() {
    scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
    
    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
    nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
    nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
    dateLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    
    datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    datePicker.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
    categoryLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
    categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
    categoryLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    categoryPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    categoryPicker.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
    categoryPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    categoryPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    bottomView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10).isActive = true
    
    stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    stackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
    stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    stackView.widthAnchor.constraint(equalToConstant: 270).isActive = true
    
    addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    addButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    
    cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    cancelButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
  }
  
  @objc func addAction() {
    if (name != nil) && (date != nil) {
      coreOperations.addItem(name: name!, date: date!, category: category)
      func presentNotification() {
        let banner = StatusBarNotificationBanner(title: "Task Added", style: .success)
        banner.show()
      }
      navigationController?.popViewController(animated: true)
    } else {
      presentAlert()
    }
  }
  
  @objc func cancelAction() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleDatePicker(_ datePicker: UIDatePicker) {
    date = datePicker.date
  }
  
  func presentAlert() {
    let alert = UIAlertController(title: "Add information", message: "Make sure that you provided all information needed", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

extension AddTaskViewController: UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      if let text = textField.text {
        name = text
      }
      return true
    }

}

extension AddTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 3
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Category.allCases[row].rawValue
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    category = Category.allCases[row].rawValue
  }
}

