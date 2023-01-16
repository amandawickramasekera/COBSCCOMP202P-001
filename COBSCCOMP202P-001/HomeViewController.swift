//
//  HomeViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit
import FirebaseAuth
import Kingfisher

class HomeViewController: UIViewController {
    
    //var foods : [Food] = []
    
    

    let btnFavourites : UIButton = {
        let btnFav = UIButton()
        btnFav.translatesAutoresizingMaskIntoConstraints = false
        return btnFav
    }()

    
    /*let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()*/
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
    
    /*let breakfast : UIButton = {
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
    }()*/
    

    
   /* let collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FoodCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        btnFavourites.addTarget(self, action: #selector(favoritesClicked), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        self.tableView.register(MyCellView.self, forCellReuseIdentifier: "cell")
    }
    
    
    func setupUI(){
        
        self.btnFavourites.setTitle("Favorites", for: .normal)
        self.btnFavourites.setTitleColor(.systemGreen, for: .normal)

        //self.imgView.image = UIImage(named: "food1")
        //self.imgView.contentMode = .top
    
        

        /*self.breakfast.setTitle("Breakfast", for: .normal)
        self.lunch.setTitle("Lunch", for: .normal)
        self.dinner.setTitle("Dinner", for: .normal)
        
        
        
        self.breakfast.setTitleColor(.systemGreen, for: .normal)
        self.lunch.setTitleColor(.systemGreen, for: .normal)
        self.dinner.setTitleColor(.systemGreen, for: .normal)
        

        let viewHolder = UIStackView(arrangedSubviews: [breakfast, lunch, dinner])
        viewHolder.axis = .horizontal
        viewHolder.spacing = 70*/
        
        self.view.addSubview(btnFavourites)
        self.view.addSubview(tableView)
        //self.view.addSubview(imgView)
        //self.view.addSubview(viewHolder)
        //self.view.addSubview(collection)
        
        btnFavourites.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(250)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        /*imgView.snp.makeConstraints{make in make.top.equalTo(btnFavourites.snp_bottomMargin).offset(40)
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
        }*/
        
        tableView.snp.makeConstraints{make in
            make.top.equalTo(btnFavourites.snp_bottomMargin).offset(30)
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "cell")
//            return cell
        
        
        
        let cell : MyCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCellView

//            cell.myImage.image = UIImage(named: "logo")
        //cell.titleLabel.text = foods[indexPath.row].originalTitle
//            cell.descriptionLabel.text = "IOS Application Development"
       
        
        /*let imageURL = "" + foods[indexPath.row].backdropPath
        if let url = URL(string: imageURL){
            cell.myImage.kf.setImage(with: url)
        }*/
        return cell

        
        //dequeueReusableCell - it can reuse in same cell by injecting data
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = DetailViewController()
        //vc.selectedFood = foods[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

class MyCellView : UITableViewCell {

let baseView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.shadowRadius = 0.5
    view.layer.shadowOffset = CGSize(width: 2, height: 2)
    view.layer.shadowColor = UIColor.black.cgColor
    return view
}()

    
    let myImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
let titleLabel : UILabel = {
    let label1 = UILabel()
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.font = .systemFont(ofSize: 18, weight: .bold)
    label1.textColor = .red
    return label1
}()



let contentHolder : UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = 20
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layComponent()
    //setupConstraints()
}

required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented!")
}



func layComponent(){

    contentHolder.addArrangedSubview(myImage)
    contentHolder.addArrangedSubview(titleLabel)
    baseView.addSubview(contentHolder)
    contentView.addSubview(baseView)
}

private func setupConstraints(){
    
    
    
    baseView.snp.makeConstraints {make in
        make.leading.top.equalToSuperview().offset(20)
        make.trailing.bottom.equalToSuperview().offset(-20)
    }
    
    myImage.snp.makeConstraints { make in
        make.height.equalTo(80)
        make.width.equalTo(80)
    }
    
}
}
}
