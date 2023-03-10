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
import FirebaseStorage //this line imports Firebase Storage from where we retrieve images of food

class DetailViewController: UIViewController {

    let storage = Storage.storage().reference()
    
    let user = FirebaseAuth.Auth.auth().currentUser
    
    let ref = FirebaseDatabase.Database.database().reference()
    
    let btnFavImg = UIImage(named: "favorite")
    let btnFavedImg = UIImage(named: "favorited")
    
    var food = ""
    var calories = 0
    var calorieBreakdown = ""
    var ingredients = ""
    var otherNutrients = ""
    
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
        label.font = .systemFont(ofSize: 20, weight: .bold) //this line sets the font size of the label to 20 and font wight of the label to bold
        label.textColor = .systemGreen
        return label
    }()
    
    //creating the caloriesLabel which shows the number of calories of the selected food
    let caloriesLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular) //this line sets the font size of the label to 15 and font wight of the label to regular
        return label
    }()
    
    //creating the calorieBreakdownLabel which shows the breakdown of calories with the percentage
    let calorieBreakdownLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular) //this line sets the font size of the label to 14 and font wight of the label to regular
        label.numberOfLines = 2
        return label
    }()
    
    //creating the ingredientsLabel which shows the ingredients of the selected food
    let ingredientsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular) //this line sets the font size of the label to 14 and font weight of the label to regular
        label.numberOfLines = 2
        return label
    }()
    
    //creating the nutrientsLabel which shows the nutrients of the selected food
    let nutrientsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular) //this line sets the font size of the label to 14 and font weight of the label to regular
        label.numberOfLines = 2
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
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        //self.view.backgroundColor = .white //this line makes the screen white in color
        
        titleLabel.text = food
        caloriesLabel.text = "Number of calories: "+String(calories)
        calorieBreakdownLabel.text = "Calorie breakdown: "+calorieBreakdown
        nutrientsLabel.text = "Other nutrients: "+otherNutrients
        ingredientsLabel.text = "Ingredients: "+ingredients
        
        setupConstraint() //calling setupConstraint function
        
        btnAddToFavs.addTarget(self, action: #selector(addToOrRemoveFromFavs), for: .touchUpInside) //this line calls the addToFavs function whenever user clicks on btnAddToFavs
        
        
        //the following lines of code retrieve the image from Firebase Storage
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
        
    
        //checking if user is not null
        if user != nil
        {
        
            //creating 'favRef' variable to store the database reference where we store the favorite food data
            let favRef = ref.child("Users").child(user!.uid).child("favorites").child(food)
        
            //following lines of code checks if the value already exists in the database and toggles button image accordingly
            favRef.observe(.value, with: { snapshot in
                    
            if snapshot.exists() == true
            {
                self.btnAddToFavs.setBackgroundImage(self.btnFavedImg, for: .normal)
            
            }
            else{
                self.btnAddToFavs.setBackgroundImage(self.btnFavImg, for: .normal)
            }
        })
        
        }
        
        
        //if user is null, sets button image to add to favorites icon anyway
        else
        {
            self.btnAddToFavs.setBackgroundImage(btnFavImg, for: .normal)
        }
        
        let holder = UIStackView(arrangedSubviews: [titleLabel, caloriesLabel, calorieBreakdownLabel, nutrientsLabel, ingredientsLabel]) //this line adds the subviews into the viewholder
        holder.spacing = 20 //this line sets a space between the subviews of the viewholder
        holder.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
        self.view.addSubview(holder) //this line adds view holder to the main screen
        self.view.addSubview(btnAddToFavs) //this line adds btnAddToFavs to the main screen
        
        
        //the following part of code creates constrains for image view with the use of SnapKit
        image.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(90)
            make.height.equalTo(250)
            make.width.equalTo(250)
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
            make.leading.equalToSuperview().offset(160)
            make.trailing.equalToSuperview().offset(-160)
            make.height.equalTo(50)
        }
    }
    
    //declaring addToFavs function
    @objc func addToOrRemoveFromFavs()
    {

        let user = FirebaseAuth.Auth.auth().currentUser //this line gets the current user into the variable named 'user'
        
        //checking if the user is not null
        if user != nil{
            
            
            //creating 'favRef' variable to store the database reference where we store the favorite food data
            let favRef = ref.child("Users").child(user!.uid).child("favorites").child(food)
                
            //checking if the button shows add to favorites icon
            if btnAddToFavs.backgroundImage(for: .normal) == btnFavImg
            {
                    //if so, add the food to favorites
                    favRef.setValue(food)
                    
                    //toggle button image
                    btnAddToFavs.setBackgroundImage(btnFavedImg, for: .normal)
                }
                
                else{
                    
                    //if not, remove from favorites
                    favRef.removeValue()
                    
                    //toggle button image
                    btnAddToFavs.setBackgroundImage(btnFavImg, for: .normal)
                }
            }
            
                      
        
        //if the user is null redirect user to sign in screen
        else{
            
            navigationController?.pushViewController(ViewController(), animated: true)
            
        }
    }
}

