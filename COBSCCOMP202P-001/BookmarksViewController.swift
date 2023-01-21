//
//  BookmarksViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import Kingfisher //this line imports Kingfisher which is used to cache images that we retrieve

class BookmarksViewController: UIViewController {
    
    //creating the label which displays the text 'Your favorites'
    let label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center //this line aligns the label to center
        lbl.text = "Your favorites" //this line sets the text displayed in the label
        lbl.font = .systemFont(ofSize: 20, weight: .regular) //this line sets the font size and font weight
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
            }
    
            //declaring setupConstraint function
            func setupConstraint() {
                
                //the following part of code creates constrains for label with the use of SnapKit
                label.snp.makeConstraints{make in
                    make.top.equalToSuperview().offset(20)
                    make.leading.equalToSuperview().offset(40)
                    make.trailing.equalToSuperview().offset(-40)
            
                }
                
                //the following part of code creates constrains for tableView with the use of SnapKit
                tableView.snp.makeConstraints{make in
                    make.top.equalTo(label.snp_bottomMargin).offset(20)
                    make.leading.equalToSuperview().offset(40)
                    make.trailing.equalToSuperview().offset(-40)
            
                }
            }
    
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
                return 4
            }
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
                
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
            label1.textColor = .systemGreen //this line sets the text color of the label to systemGreen
            return label1
        }()
        
        //creating the label where each favorite food's number of calories should load into
        let caloriesLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 15, weight: .light)
            label.textColor = .black
            return label
        }()
        
        //creating the label where each favorite food's ingredients should load into
        let ingredientsLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 15, weight: .light) //this line sets the font size of the label to 15 and font weight of the label to light
            label.textColor = .black //this line sets the text color of the label to black
            return label
        }()
        
        //creating the imageView where each favorite food's image should load into
        let foodImage : UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        //creating a viewHolder to keep labels inside
        let labelHolder : UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
            stack.spacing = 20 //this line sets a space between the subviews of the viewholder
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        //creating a viewHolder to keep the labelHolder and imageView inside
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
            
            //following three lines add each label into the labelHolder
            labelHolder.addArrangedSubview(titleLabel)
            labelHolder.addArrangedSubview(caloriesLabel)
            labelHolder.addArrangedSubview(ingredientsLabel)
            
            //following two lines add foodImage and labelHolder into contentHolder
            contentHolder.addArrangedSubview(foodImage)
            contentHolder.addArrangedSubview(labelHolder)
            
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
