//
//  DetailsViewController.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import UIKit
import ProgressHUD

class DetailsViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var detailNavigationItem: UINavigationItem!
    @IBOutlet weak var detailTableView: UITableView!
    
    //MARK: Properties
    var selectedDate: String?
    var detailsViewModel = DetailsViewModel()
    var apodResult: ApodResult? {
        didSet {
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        callPictureOfDayAPI(date: selectedDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apodResult = detailsViewModel.getStoreCacheData()
    }
    
    //MARK: Methods
    private func setupUI() {
        detailsViewModel.deleage = self
    }
    
    @objc func showDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.dateFormat
        selectedDate = dateFormatter.string(from: sender.date)
        callPictureOfDayAPI(date: selectedDate)
        //after date selection remove picker view
        sender.removeFromSuperview()
    }
    
    private func callPictureOfDayAPI(date: String?) {
        detailsViewModel.getAstronomyPictureOfDay(date: selectedDate)
        var date = "Today"
        if let value = selectedDate {
            date = Utility().convertDateFormatterToDate(value)
        }
        detailNavigationItem.title = date  + "'s APOD"
        ProgressHUD.show("displaying data...")
    }
    //MARK: Action
    @IBAction func calenderButtonTapped(_ sender: Any) {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.view.frame.width, height: 100)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(showDatePicker(sender:)), for: .valueChanged)
        self.view.addSubview(datePicker)
    }
}

//MARK: TableView
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.delegate = self
        guard let data = apodResult else {
            return UITableViewCell()
        }
        cell.configureView(data: data)
        ProgressHUD.dismiss()
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: ViewModel Delegate
extension DetailsViewController: DetailsViewModelDelegate {
    func didReceiveSuccess(response: ApodResult) {
        self.apodResult = response
    }
    
    func didReceiveFailure(response: NetworkError) {
       
        if let data = detailsViewModel.getStoreCacheData() {
            self.apodResult = data
        } else {
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: Constant.ErrorAlertTitle, message: Constant.noDetailsMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.OkAlertTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
}

//MARK: DetailTableViewCell Delegate
extension DetailsViewController: DetailTableViewCellDelegate {
    func favButtonTap() {
        let alert = UIAlertController(title: Constant.addToFavorites, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.OkAlertTitle, style: .default) {[unowned self]_ in
            if let data = apodResult {
                self.detailsViewModel.saveFavouriteDataToStorage(apodResult: data)
            }
        }
        let cancelAction = UIAlertAction(title: Constant.CancelAlertTitle, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
