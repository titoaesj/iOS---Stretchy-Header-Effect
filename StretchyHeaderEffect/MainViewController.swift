//
//  MainViewController.swift
//  StretchyHeaderEffect
//
//  Created by Tito Albino Evangelista da Silva Junior on 26/12/18.
//  Copyright © 2018 br.com.titoaesj. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var inititalConstraints = [NSLayoutConstraint]()
    private var tableview : UITableView!
    private var headerView : HeaderView!
    private var headerMaskLayer: CAShapeLayer!
    private var itens = Array(1...100)
    
    
    private let tableHeaderViewHeight: CGFloat = 250.0
    private let tableHeaderViewCutaway: CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView()
        constraintTableview()
        
        NSLayoutConstraint.activate(inititalConstraints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateHeaderView()
    }
    
    private func settingView() {
        view.backgroundColor = .white
        
        tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .red
        
        tableview.estimatedRowHeight = tableview.rowHeight
        tableview.rowHeight = UITableView.automaticDimension
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: tableHeaderViewHeight))
        debugPrint(tableview)
        tableview.tableHeaderView = nil
        if headerView != nil {
            
            tableview.addSubview(headerView)
            
            let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway / 2
            tableview.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
            tableview.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
            
        }
        
    }
    
    private func constraintTableview() {
        inititalConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tableview ])
        inititalConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tableview ])
    }
    
    func updateHeaderView() {
        let effectiveHeight = tableHeaderViewHeight
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableview.bounds.width, height: tableHeaderViewHeight)
        
        if tableview.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableview.contentOffset.y
            headerRect.size.height = -tableview.contentOffset.y
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height))
        
        headerMaskLayer?.path = path.cgPath
        
    }
    
}

extension MainViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(itens[indexPath.row])"
        return cell
    }
    
}

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

