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


class DetailViewController: UIViewController {
    
    //creating the imageView which shows the image of the selected food
    let image : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //creating the titleLabel which shows the name of the selected food
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold) //this line sets the font size of the label to 18 and font wight of the label to bold
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
        label.font = .systemFont(ofSize: 12, weight: .regular) //this line sets the font size of the label to 12 and font weight of the label to regular
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
        
        setupConstraint() //calling setupConstraint function
        
        btnAddToFavs.addTarget(self, action: #selector(addToFavs), for: .touchUpInside) //this line calls the addToFavs function whenever user clicks on btnAddToFavs
        
    }
    
    //declaring setupConstraint function
    func setupConstraint(){
        
        self.view.addSubview(image) //this line adds image int the main screen
        
        //the following part of code creates constrains for image view with the use of SnapKit
        image.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview()
        }
        
        
        //following two lines add the image named 'favorite' in assets into the btnAddToFavs. (This was done to make the UI look better)
        let btnFavImg = UIImage(named: "favorite")
        self.btnAddToFavs.setBackgroundImage(btnFavImg, for: .normal)

        let holder = UIStackView(arrangedSubviews: [titleLabel, caloriesLabel, ingredientsLabel]) //this line adds the subviews into the viewholder
        holder.spacing = 10 //this line sets a space between the subviews of the viewholder
        holder.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
        self.view.addSubview(holder) //this line adds view holder to the main screen
        self.view.addSubview(btnAddToFavs) //this line adds btnAddToFavs to the main screen
        
        //the following part of code creates constrains for view holder with the use of SnapKit
        holder.snp.makeConstraints{ make in
            make.top.equalTo(image.snp_topMargin).offset(10)
            make.leading.equalTo(view.snp_leadingMargin).offset(20)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
        }
        
        //the following part of code creates constrains for btnAddToFavs with the use of SnapKit
        btnAddToFavs.snp.makeConstraints{ make in
            make.top.equalTo(holder.snp_bottomMargin).offset(10)
            make.leading.equalTo(view.snp_leadingMargin).offset(150)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-150)
        }
    }
    
    //declaring addToFavs function
    @objc func addToFavs()
    {
        
    }
}

