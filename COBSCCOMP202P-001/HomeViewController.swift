//
//  HomeViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import FirebaseAuth //this line imports Firebase Auth which we use to register and login users
import FirebaseDatabase //this line imports Firebase Database where we store details of food and also the user details like user's name and which food the user has added to favorites
import Kingfisher //this line imports Kingfisher which is used to cache images that we retrieve

class HomeViewController: UIViewController {
    
    //creating database reference variable called 'ref'
    var ref: DatabaseReference?
    
    //creating foodList array
    var foodList = [FoodModel] ()
    
    //creating btnFavorites which takes user to the favorites where the user can view the food user has added to favorites
    let btnFavourites : UIButton = {
        let btnFav = UIButton()
        btnFav.translatesAutoresizingMaskIntoConstraints = false
        return btnFav
    }()
    
    //creating the tableview which shows all the foods stored in the database
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //creating the btnLogout which allows user to log out if they are already logged in
    let btnLogout : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white //this line makes the screen white in color
        
        let user = FirebaseAuth.Auth.auth().currentUser //this line gets the current user into the variable named 'user'
        
        if user != nil{

        setupUIWithBtnLogout() //calling setupUI function with logout button
            
        }
        else{
            setupUI() //calling setupUI function without logout button
        }
        
        btnFavourites.addTarget(self, action: #selector(favoritesClicked), for: .touchUpInside) //this line calls the favoritesClicked function whenever user clicks on btnFavorites
        
        btnLogout.addTarget(self, action: #selector(logout), for: .touchUpInside) //this line calls the logout function whenever user clicks on btnLogout
        
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        self.tableView.register(MyCellView.self, forCellReuseIdentifier: "cell")
        
        //initializing the ref variable
        ref = FirebaseDatabase.Database.database().reference()
        
        ref?.child("Foods").observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0
            {
                self.foodList.removeAll()
                for foods in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let foodObject = foods.value as? [String: AnyObject]
                    
                    let calories = foodObject?["Calories"]
                    let foodName = foodObject?["Food"]
                    let ingredients = foodObject?["Ingredients"]
                    
                    let food = FoodModel(calories: calories as!
                        Int, foodName: foodName as! String, ingredients: ingredients as! String)
                    
                    self.foodList.append(food)
                }
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    func setupUIWithBtnLogout()
    {
        
        //following two lines add the image named 'favorited' in assets into the btnFavorites. (This was done to make the UI look better)
        let btnFavImg = UIImage(named: "favorited")
        self.btnFavourites.setBackgroundImage(btnFavImg, for: .normal)

        
        self.view.addSubview(btnFavourites) //this line adds btnFavorites to the main screen
        self.view.addSubview(tableView) //this line adds the tableView to the main screen
    
        
        
        //the following part of code creates constrains for btnFavorites with the help of SnapKit
        btnFavourites.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(290)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
    
        //the following part of code creates constrains for tableView with the help of SnapKit
        tableView.snp.makeConstraints{make in
            make.top.equalTo(btnFavourites.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
            
            self.btnLogout.setTitle("Logout", for: .normal)
            self.btnLogout.backgroundColor = .systemGreen
            self.btnLogout.setTitleColor(.white, for: .normal)
            
            self.view.addSubview(btnLogout)
            
            btnLogout.snp.makeConstraints{make in
                make.top.equalTo(tableView.snp_bottomMargin).offset(20)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.bottom.equalToSuperview().offset(-20)
            
        }
    }
    //declaring setupUI function
    func setupUI(){
        
        //following two lines add the image named 'favorited' in assets into the btnFavorites. (This was done to make the UI look better)
        let btnFavImg = UIImage(named: "favorited")
        self.btnFavourites.setBackgroundImage(btnFavImg, for: .normal)

        
        self.view.addSubview(btnFavourites) //this line adds btnFavorites to the main screen
        self.view.addSubview(tableView) //this line adds the tableView to the main screen

        
        //the following part of code creates constrains for btnFavorites with the help of SnapKit
        btnFavourites.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(290)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    
        //the following part of code creates constrains for tableView with the help of SnapKit
        tableView.snp.makeConstraints{make in
            make.top.equalTo(btnFavourites.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    //declaring favoritesClicked function
    @objc func favoritesClicked()
    {
        
        
        let user = FirebaseAuth.Auth.auth().currentUser //this line gets the current user into the variable named 'user'
        
        //the following part of code opens the BookmarksViewController which shows the food user has added to favorites if they are already logged in and if not, it opens the ViewController on which the user can log in to the application
        if user != nil
        {
            
            navigationController?.pushViewController(BookmarksViewController(), animated: false)
            
        }
        else{
            navigationController?.pushViewController(ViewController(), animated: false)
            
            
        }
    }
    
    //declaring logout function
    @objc func logout()
    {
        //following lines of code tries to log the user out and load the HomeViewController again (because the logout button should not be visible when user is logged out) and if an exception occured, an alert is shown to the user
        do{
            try FirebaseAuth.Auth.auth().signOut()
            navigationController?.pushViewController(HomeViewController(), animated: false)
            
        }
        catch{
        
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
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
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : MyCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCellView
        
        let food: FoodModel
        
        food = foodList[indexPath.row]
        
        cell.titleLabel.text = food.foodName
                
        return cell


    }
    func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let vc = DetailViewController()
        let food : FoodModel
        food = foodList[indexPath.row]
        vc.food = food.foodName!
        vc.calories = food.calories!
        vc.ingredients = food.ingredients!
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
//creating one cell in the tableView
class MyCellView : UITableViewCell {

let baseView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.shadowRadius = 0.5
    view.layer.shadowOffset = CGSize(width: 2, height: 2)
    view.layer.shadowColor = UIColor.black.cgColor
    return view
}()

    //creating the imageView where each food image should load into
    let myImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    

//creating the label where each food's name should load into
let titleLabel : UILabel = {
    let label1 = UILabel()
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.font = .systemFont(ofSize: 18, weight: .bold) //this line sets the font size of the label to 18 and font weight of the label to bold
    label1.textColor = .black //this line sets the textColor of the label to black
    return label1
}()


//creating the viewHolder in which imageView and label is kept
let contentHolder : UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal //this line sets viewholder's axis to horizontal (this means the subviews of the viewholder are set one after the other horizontal)
    stack.spacing = 20 //this line sets a space between the subviews of the viewholder
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layComponent() //calling layComponent function
    setupConstraints() //calling setupConstraints function
}

required init?(coder: NSCoder){
    fatalError("init(coder:) has not been implemented!")
}


//declaring layComponent function
func layComponent(){

    contentHolder.addArrangedSubview(myImage) //adds the imageView into the viewHolder
    contentHolder.addArrangedSubview(titleLabel) //adds the label into the viewHolder
    baseView.addSubview(contentHolder) //adds the viewHolder into the baseView
    contentView.addSubview(baseView) //adds the baseView into the contentView
}

    
    //declaring setupConstraints function
    private func setupConstraints(){
    
        //creating constraints for baseView with SnapKit
        baseView.snp.makeConstraints {make in
        make.leading.top.equalToSuperview().offset(20)
        make.trailing.bottom.equalToSuperview().offset(-20)
    }
    
        //creating constraints for imageView with SnapKit
        myImage.snp.makeConstraints { make in
        make.height.equalTo(80)
        make.width.equalTo(80)
    }
    
}
}
}
