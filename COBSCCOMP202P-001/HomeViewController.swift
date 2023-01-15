//
//  HomeViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit
import FirebaseAuth

class HomeViewController: UIViewController {

    let btnFavourites : UIButton = {
        let btnFav = UIButton()
        btnFav.translatesAutoresizingMaskIntoConstraints = false
        return btnFav
    }()

    
    let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
        
    let breakfast : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lunch : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dinner : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    let collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FoodCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        btnFavourites.addTarget(self, action: #selector(favoritesClicked), for: .touchUpInside)
        
    }
    
    
    func setupUI(){
        
        self.btnFavourites.setTitle("Favorites", for: .normal)
        self.btnFavourites.setTitleColor(.systemGreen, for: .normal)

        self.imgView.image = UIImage(named: "food1")
        self.imgView.contentMode = .top
        

        self.breakfast.setTitle("Breakfast", for: .normal)
        self.lunch.setTitle("Lunch", for: .normal)
        self.dinner.setTitle("Dinner", for: .normal)
        
        
        
        self.breakfast.setTitleColor(.systemGreen, for: .normal)
        self.lunch.setTitleColor(.systemGreen, for: .normal)
        self.dinner.setTitleColor(.systemGreen, for: .normal)
        

        let viewHolder = UIStackView(arrangedSubviews: [breakfast, lunch, dinner])
        viewHolder.axis = .horizontal
        viewHolder.spacing = 70
        
        self.view.addSubview(btnFavourites)
        self.view.addSubview(imgView)
        self.view.addSubview(viewHolder)
        self.view.addSubview(collection)
        
        btnFavourites.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(250)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        
        imgView.snp.makeConstraints{make in make.top.equalTo(btnFavourites.snp_bottomMargin).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        viewHolder.snp.makeConstraints{make in make.top.equalTo(imgView.snp_bottomMargin).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    
        
        collection.snp.makeConstraints{ make in
            make.top.equalTo(viewHolder.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        
        
    }
    
    @objc private func favoritesClicked()
    {
        let user = FirebaseAuth.Auth.auth().currentUser
        if(user != nil)
        {
            let vc = BookmarksViewController()
            self.present(vc, animated: true, completion: nil)
        }
        else{
            let vc = ViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }

}


class FoodCell : UICollectionViewCell {
    
    let foodImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(foodImageView)
        
        foodImageView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

