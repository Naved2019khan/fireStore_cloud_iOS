//
//  ImageCollectionViewCell.swift
//  StorageCloud
//
//  Created by Naved  on 30/04/24.
//

import UIKit
import FirebaseStorage

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postImage: UIImageView!
    var imageUrl : String?  {
        didSet{
            guard let imageUrl else { return }
            fetchImage(pathName: imageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fetchImage(pathName : String) {
        let postRef = Storage.storage().reference(forURL: pathName)
        postRef.downloadURL { url, error in
                if let error = error {
                    print("Error downloading image:", error.localizedDescription)
                } else {
                    guard let url = url else {
                        print("Image URL not found")
                        return
                    }
                    self.postImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
                }
            }
    }

}
