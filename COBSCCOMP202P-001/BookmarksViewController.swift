//
//  BookmarksViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import Kingfisher //this line imports Kingfisher which is used to cache images that we retrieve
import FirebaseDatabase //this line imports Firebase Database where we store details of food and also the user details like user's name and which food the user has added to favorites
import FirebaseAuth //this line imports Firebase Auth which we use to register and login users
import FirebaseStorage

class BookmarksViewController: UIViewController {
    
    let storage = Storage.storage().reference()
    
    //creating favList array
    var favList = [String] ()
    
    //creating database reference variable called 'ref'
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    //creating the label which displays the text 'Your favorites'
    let label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left //this line aligns the label to left
        lbl.text = "Your favorites" //this line sets the text displayed in the label
        lbl.font = .systemFont(ofSize: 20, weight: .regular) //this line sets the font size and font weight
        lbl.textColor = .systemGreen
        return lbl
    }()
    
        //creating the tableView which shows all the foods the user has added to favorites
        let tableView : UITableView = {
                let table = UITableView()
                table.translatesAutoresizingMaskIntoConstraints = false
                return table
            }()

            override func viewDidLoad() {
                super.viewDidLoad()
                self.view.backgroundColor = .white //this line makes the screen white in color
                tableView.register(MyCellView.self, forCellReuseIdentifier: "cell")
                view.addSubview(label) //this line adds the label to the main screen
                view.addSubview(tableView) //this line adds the tableView to the main screen
                
                setupConstraint() //calling setupConstraint function
                
                tableView.delegate = self
                tableView.dataSource = self
                
                let user = FirebaseAuth.Auth.auth().currentUser
            
                //initializing the ref variable
                ref = FirebaseDatabase.Database.database().reference()
                
                databaseHandle = ref?.child("Users").child(user!.uid).child("Favorites").observe(.childAdded, with: {(snapshot) in
                    
                    let fav = snapshot.value
                    
                    if let actualFav = fav{
                        
                        self.favList.append(actualFav as! String)
                        
                        self.tableView.reloadData()
                        
                    }
                })
            }
    
            //declaring setupConstraint function
            func setupConstraint() {
                
                //the following part of code creates constrains for label with the use of SnapKit
                label.snp.makeConstraints{make in
                    make.top.equalToSuperview().offset(90)
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.equalToSuperview().offset(-20)
            
                }
                
                //the following part of code creates constrains for tableView with the use of SnapKit
                tableView.snp.makeConstraints{make in
                    make.top.equalTo(label.snp_bottomMargin).offset(20)
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.bottom.equalToSuperview().offset(-20)
            
                }
            }
}
    
    extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell : MyCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCellView
                
            
            cell.titleLabel.text = favList[indexPath.row]
            
            
            let foodTitle = favList[indexPath.row]
            
            let path = self.storage.child("Food pics/"+foodTitle.lowercased()+".jpg")
            
            path.getData(maxSize: 1 * 1024 * 1024) { data, error in
                
                if let error = error{
                    print(error.localizedDescription)
                }
                else{
                    cell.foodImage.image = UIImage(data: data!)
                    
                }
            }
            return cell


        }
    
    
            
            func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
                return 130
            }
                    

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    
    }
}

    //creating one cell in the tableView
    class MyCellView : UITableViewCell{
        
        let baseView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.shadowRadius = 0.5
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor.black.cgColor
            return view
        }()
    
        //creating the label where each favorite food's name should load into
        let titleLabel : UILabel = {
            let label1 = UILabel()
            label1.translatesAutoresizingMaskIntoConstraints = false
            label1.font = .systemFont(ofSize: 18, weight: .bold) //this line sets the font size of the label to 18 and font weight of the label to bold
            label1.textColor = .black //this line sets the text color of the label to black
            return label1
        }()
        
        
        //creating the imageView where each favorite food's image should load into
        let foodImage : UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        //creating a viewHolder to keep the titleLabel and imageView inside
        let contentHolder : UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal //this line sets viewholder's axis to horizontal (this means the subviews of the viewholder are set one after the other horizontally)

            stack.spacing = 20 //this line sets a space between the subviews of the viewholder
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            layComponent() //calling layComponent function
            setupConstraints() //calling setupConstraints
        }
        
        required init?(coder: NSCoder){
            fatalError("init(coder:) has not been implemented!")
        }
        
        
        //declaring layComponent function
        func layComponent(){
            
            
            //following two lines add foodImage and labelHolder into contentHolder
            contentHolder.addArrangedSubview(foodImage)
            contentHolder.addArrangedSubview(titleLabel)
            
            baseView.addSubview(contentHolder) //this line adds contentHolder into baseView
            
            contentView.addSubview(baseView) //this line adds baseView into the contentView
        }
        
        //declaring setupConstraints function
        private func setupConstraints(){
            
            //the following part of code creates constrains for baseView with the use of SnapKit
            baseView.snp.makeConstraints {make in
                make.leading.top.equalToSuperview().offset(20)
                make.trailing.bottom.equalToSuperview().offset(-20)
            }
            
            //the following part of code sets height and width for foodImage with the use of SnapKit
            foodImage.snp.makeConstraints { make in
                make.height.equalTo(80)
                make.width.equalTo(80)
            }
            
        }
    }
