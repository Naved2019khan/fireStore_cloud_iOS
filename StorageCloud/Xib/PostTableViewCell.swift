//
//  PostTableViewCell.swift
//  StorageCloud
//
//  Created by Naved  on 13/02/24.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var postView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXib()
   
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        changeMode()
        reloadCollectionViewWithoutAnimation()
    }
    
    var postList : UserData? {
        didSet{
            guard let postList else { return }
            userName.text = postList.userName
            creationDate.text =  dateConvertor()
            postDescription.text = postList.description
            postView.layer.cornerRadius = 12
        }
    }
    
    
    func registerXib(){
        imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }

    func reloadCollectionViewWithoutAnimation() {
            UIView.performWithoutAnimation {
                self.imageCollectionView.reloadData()
                self.imageCollectionView.layoutIfNeeded()
            }
        }
    
    func dateConvertor()->String{
        let postTimestamp = postList?.date
        guard let postDate = postTimestamp?.dateValue() else {
            return "00:00:00"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: postDate)
        return formattedDate
    }
    
    func changeMode(){
        if UserDefaultValue.shared.getCurrentMode == "light"{
            userName.textColor = .black
            creationDate.textColor = .black
            postDescription.textColor = .black
            postView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 0.3902110927)
        }
        else{
            userName.textColor = .white
            creationDate.textColor = .white
            postDescription.textColor = .white
            postView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
    }

}
