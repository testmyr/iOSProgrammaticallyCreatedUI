//
//  PostTableViewCell.swift
//  RedditSample
//
//  Created by sdk on 7/3/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post : Post? {
        didSet {
            lblAuthor.text = post?.author
            lblTime.text = "time"
            if let numCom = post?.numberOfComments {
                lblNumberOfCommentsValue.text = String(numCom)
            }
        }
    }
    
    func setThumbnailImage(image: UIImage) {
        imgThumbnail.image = image
    }
    
    private let paddingLeft = CGFloat(5)

    private let imgReadStatus : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.circle(diameter: 100, color: UIColor.blue)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    private var lblAuthor: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblTime: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var imgThumbnail : UIImageView = {
        let imgView = UIImageView()
        //TODO rm
        imgView.backgroundColor = UIColor.red
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    private var btnDismissPost: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var lblNumberOfComments: UILabel! = {
        let label = UILabel()
        label.text = "comments"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblNumberOfCommentsValue: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        backgroundColor = .black
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        addSubview(imgReadStatus)
        imgReadStatus.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        imgReadStatus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeft).isActive = true
        imgReadStatus.widthAnchor.constraint(equalTo: imgReadStatus.heightAnchor, multiplier: 1.0).isActive = true
        imgReadStatus.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        imgReadStatus.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        addSubview(lblAuthor)
        lblAuthor.leadingAnchor.constraint(equalTo: imgReadStatus.trailingAnchor, constant: 10).isActive = true
        lblAuthor.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        lblAuthor.lineBreakMode = .byTruncatingTail
        
        addSubview(lblTime)
        lblTime.leadingAnchor.constraint(equalTo: lblAuthor.trailingAnchor, constant: 5).isActive = true
        lblTime.centerYAnchor.constraint(equalTo: lblAuthor.centerYAnchor).isActive = true
        lblTime.setContentCompressionResistancePriority(.required, for: .horizontal)

        addSubview(imgThumbnail)
        imgThumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeft).isActive = true
        imgThumbnail.topAnchor.constraint(equalTo: lblAuthor.bottomAnchor, constant: 5).isActive = true
        imgThumbnail.widthAnchor.constraint(equalTo: imgThumbnail.heightAnchor, multiplier: 1.0).isActive = true
        imgThumbnail.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// MARK: - UIImage extension
extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}
