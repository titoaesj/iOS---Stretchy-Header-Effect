//
//  InstagramHeaderView.swift
//  StretchyHeaderEffect
//
//  Created by Tito Albino Evangelista da Silva Junior on 26/12/18.
//  Copyright © 2018 br.com.titoaesj. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    private var initialConstraints = [NSLayoutConstraint]()
    private var imageview : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingView()
        
    }
    
    func settingView() {
        backgroundColor = .red
        imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageview)
        //        imageview.frame = frame
        imageview.image = #imageLiteral(resourceName: "cover")
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .yellow
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        initialConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageview])
        //        initialConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : imageview])
        
        initialConstraints.append(imageview.leadingAnchor.constraint(equalTo: leadingAnchor))
        initialConstraints.append(imageview.topAnchor.constraint(equalTo: topAnchor))
        initialConstraints.append(imageview.trailingAnchor.constraint(equalTo: trailingAnchor))
        initialConstraints.append(imageview.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        
        NSLayoutConstraint.activate(initialConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
