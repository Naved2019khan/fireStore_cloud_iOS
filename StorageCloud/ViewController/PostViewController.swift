//
//  PostViewController.swift
//  StorageCloud
//
//  Created by Atul  on 13/02/24.
//

import UIKit
import FirebaseCore
import  FirebaseStorage
import FirebaseFirestore

class PostViewController: UIViewController{
    
    @IBOutlet weak var postTableView: UITableView!
    var postList = [UserData]() // list of json
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        registerXib()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStorageList()
    }
    
    func registerXib(){
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    // MARK: - Action Method
    @IBAction func segmentMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("light", forKey: Constants.shared.mode) // set key : "mode" to light
            sender.selectedSegmentTintColor = .white
            changeSegmentTextColor(sender: sender, normalColor: .black, selectedColor: .black)
        case 1 :
            UserDefaults.standard.set("dark", forKey: Constants.shared.mode) // set key : "mode" to light
            sender.selectedSegmentTintColor = .black
            changeSegmentTextColor(sender: sender, normalColor: .white , selectedColor: .white)
        default:
            break
        }
        changeMode()
        postTableView.reloadData()
    }
    
    // segment text color change
    func changeSegmentTextColor(sender : UISegmentedControl ,normalColor : UIColor , selectedColor : UIColor){
        let normalAttributes = [NSAttributedString.Key.foregroundColor: normalColor]
                sender.setTitleTextAttributes(normalAttributes, for: .normal)
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: selectedColor]
                sender.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    func changeMode(){
        tabBarController?.tabBar.tintColor = .red
        if UserDefaultValue.shared.getCurrentMode == "light"{
            let blurEffect = UIBlurEffect(style: .regular)
            blurView.effect = blurEffect
        }
        else{
            let blurEffect = UIBlurEffect(style: .dark)
            blurView.effect = blurEffect
        }
    }
    
    // get list of posts
    func fetchStorageList() {
        LoaderHelper.shared.startLoader(self.view)
        let postsCollection = db.collection("posts")
        postList.removeAll()
        postsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }

            for document in documents {
                let data = document.data()
                if let userName = data["userName"] as? String, let description = data["description"] as? String,
                    let imageUrl = data["imageUrls"] as? [String],let date = data["date"] as? Timestamp  {
                    print(imageUrl)
                        let userDataObject = UserData(userName: userName, date: date, imageUrl: imageUrl, description: description)
                        self.postList.append(userDataObject)
                    LoaderHelper.shared.stopLoader()

                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: { [self] in
                if postList.isEmpty{
                    LoaderHelper.shared.stopLoader()
                }
            })
            self.postTableView.reloadData()
        }
    }
    
}

// MARK: - TableView Delgate Method
extension PostViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.imageCollectionView.delegate = self
        cell.imageCollectionView.dataSource = self
        cell.imageCollectionView.tag = indexPath.row
        cell.postList = postList[indexPath.row]
//        cell.imageCollectionView.reloadData()
        return cell
    }
    
}



extension PostViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList[collectionView.tag].imageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageUrl = postList[collectionView.tag].imageUrl[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionFrame = collectionView.frame
        return CGSize(width: collectionFrame.width , height:  190)
    }
    
}
