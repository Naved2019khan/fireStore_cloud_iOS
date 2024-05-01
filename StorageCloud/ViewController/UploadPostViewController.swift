//
//  UploadPostViewController.swift
//  StorageCloud
//
//  Created by Atul  on 13/02/24.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class UploadPostViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageCollection: UICollectionView!
//    @IBOutlet weak var imageUpload: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userDescription: UITextView!
    var getImage : UIImage?
    var postList = [UserData]()
    private let storage = Storage.storage().reference()
    private let firestore = Firestore.firestore()
    var imagePicker = UIImagePickerController()
    var imageArr = [UIImage]()
    var storeUrls = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollection.dataSource = self
        imageCollection.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeMode()
    }
    
    @IBAction func crossButton(_ sender: UIButton) {
        imageArr.remove(at: sender.tag)
        imageCollection.reloadData()
    }

    @IBAction func submitButton(_ sender: Any) {
       
        if userName.text! != "" {
            uploadAllImage()
        }
        else{
            showAlert(title: "not valid", message: "UserName can't be empty")
        }
    }

    func uploadAllImage(){
        storeUrls.removeAll()
        LoaderHelper.shared.startLoader(self.view)
        for imageData in imageArr{
            uploadImageToStorage(image: imageData)
        }
    }
}


// MARK: - ImagePicker  Method
extension UploadPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Target for Image Picker
    @objc func addImage(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            if imageArr.count < 5{
                imageArr.append(pickedImage)
            }
        }
        picker.dismiss(animated: true, completion: {
            self.imageCollection.reloadData()
        })
    }
    
}

// MARK: - Upload Method Firebase
extension UploadPostViewController {
    
    // upload images to firebase after completion "uploadPostToFirestore" this call
    func uploadImageToStorage(image: UIImage){
        let imageRef = storage.child("post_images/\(UUID().uuidString).jpg")
        let imageData = image.jpegData(compressionQuality: 0.8)
        imageRef.putData(imageData!, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            imageRef.downloadURL { [self] (url, error) in
                if let error = error {
                    print("Error getting image URL: \(error.localizedDescription)")
                    return
                }
                
                guard let imageURL = url?.absoluteString else {
                    return
                }
                
                // store return url
                self.storeUrls.append(imageURL)
                if self.storeUrls.count == self.imageArr.count {
                    uploadPostToFirestore(userName: userName.text!, description: userDescription.text!, storeUrls: storeUrls)
                }
                
            }
        }
        
    }
 
    // save data to firestore
    private func uploadPostToFirestore(userName: String, description: String,storeUrls : [String]) {
                let postData: [String: Any] = [
                    "userName": userName,
                    "description": description,
                    "imageUrls" : storeUrls,
                    "date": Timestamp(date: Date()),
                    "userId" : UUID().uuidString
                ]

                self.firestore.collection("posts").addDocument(data: postData) { (error) in
                    if let error = error {
                        print("Error saving post data: \(error.localizedDescription)")
                    } else {
                        print("Post uploaded successfully")
                        self.clearFields()
                    }
                }
    }
    
        private func clearFields() {
            LoaderHelper.shared.stopLoader()
            userName.text = ""
            userDescription.text = ""
            storeUrls.removeAll()
            imageArr.removeAll()
            imageCollection.reloadData()
            tabBarController?.selectedIndex = 0
        }
    
    func changeMode(){
        
        if UserDefaultValue.shared.getCurrentMode == "light"{
            let blurEffect = UIBlurEffect(style: .regular)
            blurView.effect = blurEffect
            nameLabel.textColor = .black
            labelDescription.textColor = .black
            userName.textColor = .black
            userDescription.textColor = .black
            userName.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 0.3902110927)
            descriptionView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 0.3902110927)
        }
        else{
            let blurEffect = UIBlurEffect(style: .dark)
            blurView.effect = blurEffect
            nameLabel.textColor = .white
            labelDescription.textColor = .white
            userName.textColor = .white
            userDescription.textColor = .white
            userName.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            descriptionView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
        
    }
    
}

// MARK: - CollectionView Delgate Method

extension UploadPostViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageArr.count <= 4{
            return imageArr.count + 1;
        }
        else{
            return 5 ;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  imageCollection.dequeueReusableCell(withReuseIdentifier: "AddPostCollectionViewCell", for: indexPath) as! AddPostCollectionViewCell
        if indexPath.row < 5  {
            
            if imageArr.count == indexPath.row {
                cell.crossBtn.isHidden = true;
                cell.imageView.image = UIImage(named: "backImage")
                cell.imageView.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
                tap.delegate = self
                cell.imageView.addGestureRecognizer(tap)
            }
            else{
                
                cell.imageView.isUserInteractionEnabled = false
                cell.crossBtn.isHidden = false;
                cell.imageView.layer.cornerRadius = 12
                cell.crossBtn.tag = indexPath.row
                cell.imageView.image = imageArr[indexPath.row]
            }
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imageCollection.frame.size.width/3 ;
        return CGSize(width: size - 3 , height: size)
    }
    
}



