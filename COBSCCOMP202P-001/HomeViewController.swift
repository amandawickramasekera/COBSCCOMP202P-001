//
//  HomeViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    //var data : [FoodResult] = []
    

    
    
    var imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
        
    var breakfast : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var lunch : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var dinner : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    var collection : UICollectionView = {
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
    }
    
    /*func downloadData(){
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let FoodData = data {
                let json = try? JSONDecoder().decode(FoodData.self, from: FoodData)
                if let results = json?.results {
                    self.data = results
                    
                    DispatchQueue.main.async {
                        self.collection.reloadData()
                    }
                }
               
            }
            
        }
        task.resume()
    }*/
    
    func setupUI(){
        

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
        
        
        self.view.addSubview(imgView)
        self.view.addSubview(viewHolder)
        self.view.addSubview(collection)
        
        imgView.snp.makeConstraints{make in make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        
        viewHolder.snp.makeConstraints{make in make.top.equalTo(imgView.snp_bottomMargin).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    
        
        //collection.dataSource = self
        //collection.delegate = self
        
        collection.snp.makeConstraints{ make in
            make.top.equalTo(viewHolder.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        
        
    }

}

/*extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FoodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodCell
        
        cell.foodImageView.kf.setImage(with: URL(string: data[indexPath.row].image))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}*/

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

