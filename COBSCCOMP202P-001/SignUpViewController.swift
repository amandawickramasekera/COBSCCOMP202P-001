//
//  SignUpViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-13.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import FirebaseAuth //this line imports Firebase Auth which we use to register and login users
import FirebaseDatabase //this line imports Firebase Database where we store details of food and also the user details like user's name and which food the user has added to favorites

class SignUpViewController: UIViewController {
    
    //creating the imageView which is added just to make the UI look better
    let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    //creating the label which displays the text 'Sign up to continue'
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center //this line aligns the label to center
        label.text = "Sign up to continue" //this line sets the text displayed in the label
        label.font = .systemFont(ofSize: 20, weight: .regular) //this line sets the font size and font weight
        return label
    }()
    
    //creating the text field where user enters name
    let nameText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Name" //this line adds the hint that the user should enter name in this textfield
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    
    //creating the text field where user enters email address
    let emailText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Email address" //this line adds the hint that the user should enter email address in this textfield
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocapitalizationType = .none //this line disables autocapitalization for this text field
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    //creating the text field where user enters password
    let pwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Password" //this line adds the hint that the user should enter password in this textfield
        text.isSecureTextEntry = true //this line hides the password that is entered to this text field with dots
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocapitalizationType = .none //this line disables autocapitalization for this text field
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    //creating the text field where user confirms password
    let cpwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Confirm password" //this line adds the hint that the user should confirm password in this textfield
        text.isSecureTextEntry = true //this line hides the password that is entered to this text field with dots
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocapitalizationType = .none //this line disables autocapitalization for this text field
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    //creating the login button which allows user to register
    let btnRegister: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal) //this line sets the color of the button text to white
        btn.backgroundColor = .systemGreen //this line sets the color of the button background to systemGreen
        btn.setTitle("Sign up", for: .normal) //this line sets the text that the button should display
        return btn
    }()

    //creating the login button which redirects the users who already have an account to the login screen
    let btnLog: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal) //this line sets the color of the button text to white
        btn.backgroundColor = .systemGreen //this line sets the color of the button background to systemGreen
        btn.setTitle("Already have an account? Sign in", for: .normal) //this line sets the text that the button should display
        return btn
    }()
    
    //following line creates database variable and assigns Firebase database reference to it
    let database = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white //this line makes the screen white in color
        
        setupUI() //calling setupUI function
        
        btnRegister.addTarget(self, action: #selector(signUp), for: .touchUpInside) //this line calls the signUp function whenever user clicks on btnRegister
        
        btnLog.addTarget(self, action: #selector(openSignIn), for: .touchUpInside) //this line calls the openSignignIn function whenever user clicks on btnLog
    }

    //declaring setupUI function
    func setupUI()
    {
        self.imgView.image = UIImage(named: "food1") //this line adds the image named 'foodimg' in assets into the imageView
        
        //the following lines of code is supposed to set position and width and height of the frames of the text fields but actually makes no difference
        nameText.frame = CGRect(x: 20, y: 60, width: 50, height: 50)
        emailText.frame = CGRect(x: 20, y: 120, width: 50, height: 50)
        pwText.frame = CGRect(x: 20, y: 180, width: 50, height: 50)
        cpwText.frame = CGRect(x: 20, y: 240, width: 50, height: 50)
        
        
        let viewHolder = UIStackView(arrangedSubviews: [label, nameText, emailText, pwText, cpwText, btnRegister, btnLog]) //this line adds the subviews into the viewholder
        viewHolder.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
        viewHolder.spacing = 20 //this line sets a space between the subviews of the viewholder
        
        
        self.view.addSubview(viewHolder) //this line adds viewHolder to the main screen
        self.view.addSubview(imgView) //this line adds the imgView to the main screen
        
        
        //the following part of code creates constrains for imgView with the use of SnapKit
        imgView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        //the following part of code creates constrains for viewHolder with the use of SnapKit
        viewHolder.snp.makeConstraints{make in
            make.top.equalTo(imgView.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameText.becomeFirstResponder() //this sets the curser to the nameText text field when the screen appears
    }
    
    //declaring signUp function
    @objc func signUp()
    {
        //following part of code checks if the user has entered details and if not an alert is displayed to the user
        guard let name = nameText.text, !name.isEmpty,
              let email = emailText.text, !email.isEmpty,
              let pw = pwText.text, !pw.isEmpty,
              let cpw = cpwText.text, !cpw.isEmpty
        else{
            let alert = UIAlertController(title: "Details not entered", message: "Please enter your details and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            return
        }
        
        //the following part of code checks if retyped password is not equal to the password and if so, an alert is displayed to the user
        if cpw != pw
        {
            let alert = UIAlertController(title: "Passwords do not match", message: "Created password and confirmed password must be same", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            
        }
        //the following part of code checks if length of the passwords is less than 6 characters and if so, an alert is displayed to the user
        else if pw.count < 6
        {
            let alert = UIAlertController(title: "Password too short", message: "Password must be at least 6 characters long", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            
        }
        
        //else means all good so we can register the user
        else{
        //following part of code registers the user
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw, completion: {result, error in
            //if there is an error in registering the user an alert is shown to the user
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in}))
                self.present(alert, animated: true)
            }
            //if there is no error we can continue to store user's details like name in firebase realtime database
            else{
            let user = FirebaseAuth.Auth.auth().currentUser //this line gets the current user into the variable named 'user'
    
            if user != nil //checking if the user is not null
            {
                let userkey = user!.uid //creating a variable called userkey and storing the user's uid generated from FurebaseAuth in the userkey variable
                
                //the following part of code stores the user's name and uid inside the child node named after the user's uid, inside the parent node called 'Users'
                let object: [String: Any] = [
                    "uid": userkey,
                    "name": name
                ]
                self.database.child("Users").child(userkey).setValue(object)
            }
            }
        })
    
            self.nameText.text = ""
            self.emailText.text = ""
            self.pwText.text = ""
            self.cpwText.text = ""
            
            
            //the following lines of code opens the HomeViewController
            navigationController?.pushViewController(HomeViewController(), animated: true)
            
        }
       
    
    }
    
    //declaring openSignIn function
    @objc func openSignIn()
    {
        //the following lines of code opens the ViewController where users who already have an account can log in
        navigationController?.pushViewController(ViewController(), animated: true)
            }
}
