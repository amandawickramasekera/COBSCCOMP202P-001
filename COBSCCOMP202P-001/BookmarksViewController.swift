//
//  BookmarksViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit
import Kingfisher

class BookmarksViewController: UIViewController {
    
    let label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.text = "Your favorites"
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        return lbl
    }()
    
        let tableView : UITableView = {
                let table = UITableView()
                table.translatesAutoresizingMaskIntoConstraints = false
                return table
            }()

            override func viewDidLoad() {
                super.viewDidLoad()
                self.view.backgroundColor = .white
                tableView.register(MyCellView.self, forCellReuseIdentifier: "cell")
                view.addSubview(label)
                view.addSubview(tableView)
                setupConstraint()
            }
            func setupConstraint() {
                
                label.snp.makeConstraints{make in
                    make.top.equalToSuperview().offset(20)
                    make.leading.equalToSuperview().offset(40)
                    make.trailing.equalToSuperview().offset(-40)
            
                }
                
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
            
        

    class MyCellView : UITableViewCell{
        
        let baseView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.shadowRadius = 0.5
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor.black.cgColor
            return view
        }()
        
        let titleLabel : UILabel = {
            let label1 = UILabel()
            label1.translatesAutoresizingMaskIntoConstraints = false
            label1.font = .systemFont(ofSize: 18, weight: .bold)
            label1.textColor = .red
            return label1
        }()
        
        let categoryLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 15, weight: .light)
            label.textColor = .blue
            return label
        }()
        
        let foodImage : UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        let labelHolder : UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 20
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
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
            setupConstraints()
        }
        
        required init?(coder: NSCoder){
            fatalError("init(coder:) has not been implemented!")
        }
        
        
        
        func layComponent(){
            labelHolder.addArrangedSubview(titleLabel)
            labelHolder.addArrangedSubview(categoryLabel)
            contentHolder.addArrangedSubview(foodImage)
            contentHolder.addArrangedSubview(labelHolder)
            baseView.addSubview(contentHolder)
            contentView.addSubview(baseView)
        }
        
        private func setupConstraints(){
            
            baseView.snp.makeConstraints {make in
                make.leading.top.equalToSuperview().offset(20)
                make.trailing.bottom.equalToSuperview().offset(-20)
            }
            
            foodImage.snp.makeConstraints { make in
                make.height.equalTo(80)
                make.width.equalTo(80)
            }
            
        }
    

}
