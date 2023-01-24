//
//  DetailViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import FirebaseAuth //this line imports Firebase Auth which we use to register and login users
import FirebaseDatabase //this line imports Firebase Database where we store details of food and also the user details like user's name and which food the user has added to favorites
import FirebaseStorage

class DetailViewController: UIViewController {
    
    var ref: DatabaseReference?

    let storage = Storage.storage().reference()
    
    var food = ""
    var calories = 0
    var ingredients = ""
    
    
    //creating the imageView which shows the image of the selected food
    let image : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //creating the titleLabel which shows the name of the selected food
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold) //this line sets the font size of the label to 18 and font wight of the label to bold
        label.textColor = .systemGreen
        return label
    }()
    
    //creating the caloriesLabel which shows the number of calories of the selected food
    let caloriesLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular) //this line sets the font size of the label to 15 and font wight of the label to regular
        return label
    }()
    
    //creating the ingredientsLabel which shows the ingredients of the selected food
    let ingredientsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .regular) //this line sets the font size of the label to 11 and font weight of the label to regular
        return label
    }()
    
    //creating add to favorites button
    let btnAddToFavs : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white //this line makes the screen white in color
        
        titleLabel.text = food
        caloriesLabel.text = "Number of caleries: "+String(calories)
        ingredientsLabel.text = "Ingredients: "+ingredients
        
        setupConstraint() //calling setupConstraint function
        
        btnAddToFavs.addTarget(self, action: #selector(addToFavs), for: .touchUpInside) //this line calls the addToFavs function whenever user clicks on btnAddToFavs
        
        
        let path = storage.child("Food pics/"+food.lowercased()+".jpg")
        
        path.getData(maxSize: 1 * 1024 * 1024) { data, error in
            
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                self.image.image = UIImage(data: data!)
                
            }
            
        }
        
    }
    
    //declaring setupConstraint function
    func setupConstraint(){
        
        self.view.addSubview(image) //this line adds image int the main screen
        
        
        
        
        //following two lines add the image named 'favorite' in assets into the btnAddToFavs. (This was done to make the UI look better)
        let btnFavImg = UIImage(named: "favorite")
        self.btnAddToFavs.setBackgroundImage(btnFavImg, for: .normal)

        let holder = UIStackView(arrangedSubviews: [titleLabel, caloriesLabel, ingredientsLabel]) //this line adds the subviews into the viewholder
        holder.spacing = 20 //this line sets a space between the subviews of the viewholder
        holder.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
        self.view.addSubview(holder) //this line adds view holder to the main screen
        self.view.addSubview(btnAddToFavs) //this line adds btnAddToFavs to the main screen
        
        
        //the following part of code creates constrains for image view with the use of SnapKit
        image.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(90)
            make.height.equalTo(400)
            make.width.equalTo(400)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(holder.snp_topMargin).offset(-20)
        }
        
        
        
        //the following part of code creates constrains for view holder with the use of SnapKit
        holder.snp.makeConstraints{ make in
            make.top.equalTo(image.snp_topMargin).offset(20)
            make.leading.equalTo(view.snp_leadingMargin).offset(20)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
        }
        
        //the following part of code creates constrains for btnAddToFavs with the use of SnapKit
        btnAddToFavs.snp.makeConstraints{ make in
            make.top.equalTo(holder.snp_bottomMargin).offset(20)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-150)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    //declaring addToFavs function
    @objc func addToFavs()
    {
        let user = FirebaseAuth.Auth.auth().currentUser
        if user != nil{
            ref = FirebaseDatabase.Database.database().reference()
            ref?.child("Users").child(user!.uid).child("Favorites").child(food).setValue(food)
            
            let btnFavedImg = UIImage(named: "favorited")
            self.btnAddToFavs.setBackgroundImage(btnFavedImg, for: .normal)

        }
        else{
            
            navigationController?.pushViewController(ViewController(), animated: false)
            
        }
    }
}

