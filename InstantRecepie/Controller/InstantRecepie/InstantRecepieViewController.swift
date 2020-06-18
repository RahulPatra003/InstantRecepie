//
//  InstantRecepieViewController.swift
//  InstantRecepie
//
//  Created by MAC on 17/06/20.
//  Copyright © 2020 Techangouts. All rights reserved.
//

import UIKit

class InstantRecepieViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var recepieTableView: UITableView!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK:- Variables
    var viewModle: RecepieViewModle? = RecepieViewModle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.constant = -60
        
        recepieTableView.delegate = self
        recepieTableView.dataSource = self
        
        recepieData(ingrediants: "", page: viewModle?.page ?? 1)
        
        searchTextField.addTarget(self, action: #selector(didChangeEditing), for: .editingChanged)
    }
    
    func recepieData(ingrediants: String, page: Int) {
        viewModle?.isSearching = true
        viewModle?.hitRecepieApi(withIngrediants: ingrediants, andPageNo: page, completion: { (isSuccess, message) in
        self.viewModle?.isSearching = false
            if isSuccess == true {
                self.recepieTableView.reloadData()
            }else {
                print(message)
            }
        })
    }
    
    //MARK:- Action
    @objc func didChangeEditing(_ textField : UITextField) {
        recepieData(ingrediants: (searchTextField.text ?? ""), page: viewModle?.page ?? 1)
    }
    
    @objc func downAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.viewTop.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @objc func upAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.viewTop.constant = -60
            self.searchTextField.text = ""
            self.recepieData(ingrediants: "", page: 1)
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    @IBAction func searchBtn(_ sender: UIButton) {
        downAnimation()
    }
    
    @IBAction func crossBtn(_ sender: UIButton) {
        upAnimation()
    }
}

extension InstantRecepieViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModle?.dataRecepie?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recepieTableView.dequeueReusableCell(withIdentifier: "IRTableViewCell", for: indexPath) as! IRTableViewCell
        cell.cellData = viewModle?.dataRecepie?.results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastElement = (viewModle?.dataRecepie?.results.count ?? 0) - 2
        if indexPath.row == lastElement {
            if !(self.viewModle?.isSearching ?? false) {
                if !(self.viewModle?.isLast ?? false) {
                    DispatchQueue.main.async {
                        self.viewModle?.page += 1
                        self.recepieData(ingrediants: (self.searchTextField.text ?? ""), page: self.viewModle?.page ?? 0)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecepieDetailViewController") as! RecepieDetailViewController
        vc.urlString = viewModle?.dataRecepie?.results[indexPath.row].href ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

