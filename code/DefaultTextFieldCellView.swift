//
//  DefaultTextFieldCellView.swift
//  
//
//  Created by Nazhmeddin Babakhanov on 10/24/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

enum TypeOfInput {
    case phonePad
    case passwordPad
    case decimalPad
    case defaultPad
    case picker
    case datePicker
    case emailAddress
    case none
}


class DefaultTextFieldCellView: UITableViewCell {

    var editingChanged: ((String, Int?) -> ())?
    var pickerView = PickerViewManager()
    var datePickerView = DatePickerViewManager()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstrains()

        textInput.typedEvent = {  text in
            self.editingChanged?(text, self.textInput.tag)
        }

        pickerView.didSelect = {  pickedValue in
            self.textInput.text = pickedValue
        }

        datePickerView.valueChanged = { pickedDate in
            self.textInput.text = pickedDate
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: DefaultTextFieldCellView")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textInput.text = ""
        textInput.isSecureTextEntry = false
        textInput.rightView = nil
        textInput.inputView = nil
    }

    lazy var textInput: DefaultTextField = {
        let view = DefaultTextField()
        view.delegate = self
        view.addTarget(self, action: #selector(editingChangedEvent), for: .editingChanged)
        view.borderStyle = .none
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()

    lazy var rightSelectionView: UIView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bottomArrowBlue"))
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 10)
        let padding: CGFloat = 15
        let view = UIView(frame: CGRect(
            x: 0, y: 0,
            width: imageView.frame.width + padding,
            height: imageView.frame.height))
        view.addSubview(imageView)
        return view
    }()
    
    lazy var imageLeft: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Icons Background").withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 0, width:30, height: 30)
        return imageView
    }()
    
    lazy var phoneSelectionView: UIView = {
        let padding: CGFloat = 15
        let view = UIView(frame: CGRect(
            x: 10, y: 0,
            width: imageLeft.frame.width + padding,
            height: imageLeft.frame.height))
        view.addSubview(imageLeft)
        return view
    }()

    lazy var showerPasswordView: UIView = {

        let buttonView = UIButton.init(type: .custom)
        buttonView.setImage(#imageLiteral(resourceName: "hidden-1"), for: .normal)
        buttonView.addTarget(self, action: #selector(passwordSecureControl), for: .touchUpInside)
        buttonView.frame = CGRect(x: 0, y: 0, width: 20, height: 17)

        let padding: CGFloat = 15
        let view = UIView(frame: CGRect(
            x: 0, y: 0,
            width: buttonView.frame.width + padding,
            height: buttonView.frame.height))
        view.addSubview(buttonView)

        return view
    }()
}

extension DefaultTextFieldCellView {
    
    func configureWithLeftImage(with item: AuthorizationItem) -> Void {
        commontTextFieldStyle()
        textInput.attributedPlaceholder = NSAttributedString(string: item.placeholder.first!,
                                                        attributes: [NSAttributedString.Key.foregroundColor: Color.darkGray(), NSAttributedString.Key.font: Font.robotoRegular(size: 14)])
        pickerView.pickableItems = item.pickerDataSource
        configureTypeOfView(typeOfSkyInput: item.inputView)
    }


    func configure(with item: AuthorizationItem) -> Void {
        commontTextFieldStyle()
        imageLeft.image = item.image
        textInput.leftView = phoneSelectionView
        textInput.leftViewMode = .always
        textInput.attributedPlaceholder = NSAttributedString(string: item.placeholder.first!,
                                                             attributes: [NSAttributedString.Key.foregroundColor: Color.darkGray(), NSAttributedString.Key.font: Font.robotoRegular(size: 14)])
        pickerView.pickableItems = item.pickerDataSource
        configureTypeOfView(typeOfSkyInput: item.inputView)
    }

    func configure(with item: RecoveryItem) -> Void {
        commontTextFieldStyle()
        textInput.leftView = phoneSelectionView

        
        textInput.leftViewMode = .always
        
        textInput.attributedPlaceholder = NSAttributedString(string: item.placeholder.first!,
                                                             attributes: [NSAttributedString.Key.foregroundColor: Color.darkGray(), NSAttributedString.Key.font: Font.robotoRegular(size: 14)])
        pickerView.pickableItems = item.pickerDataSource
        configureTypeOfView(typeOfSkyInput: item.inputView)
    }

    func configure(with item: ChangeItem) -> Void {
        commontTextFieldStyle()
        textInput.attributedPlaceholder = NSAttributedString(string: item.placeholder.first!,
                                                             attributes: [NSAttributedString.Key.foregroundColor: Color.darkGray(), NSAttributedString.Key.font: Font.robotoRegular(size: 14)])
        pickerView.pickableItems = item.pickerDataSource
        configureTypeOfView(typeOfSkyInput: item.inputView)
    }

    func configureTypeOfView(typeOfSkyInput: TypeOfInput) -> Void {

        switch typeOfSkyInput {
        case .emailAddress:
            textInput.rightView = rightSelectionView
            textInput.leftView = rightSelectionView
            textInput.keyboardType = .decimalPad
            break
        case .phonePad:
            textInput.keyboardType = .phonePad

            break
        case .decimalPad:
            textInput.keyboardType = .decimalPad
            break
        case .picker:
            textInput.rightView = rightSelectionView
            textInput.rightViewMode = .always
            textInput.inputView = pickerView
            break
        case .datePicker:
            textInput.inputView = datePickerView
        case .passwordPad:
            textInput.rightView = showerPasswordView
            textInput.rightViewMode = .always
            textInput.keyboardType = .default
            break
        default:
            textInput.keyboardType = .default
        }
    }

    func commontTextFieldStyle() -> Void {
        selectionStyle = .none
        separatorInset = .right(with: ScreenSize.SCREEN_WIDTH)
        textInput.textColor = Color.black()
        textInput.font = Font.robotoRegular(size: 14)
    }
}

extension DefaultTextFieldCellView {

    private func setupViews() -> Void {
        backgroundColor = .white
        addSubview(textInput)
    }

    private func setupConstrains() -> Void {

        textInput.snp.makeConstraints { (make) in

            make.top.equalTo(7.5)
            make.left.equalTo(15)
            make.height.equalTo(48)
            make.right.equalTo(-15)
            make.bottom.equalTo(-7.5)
        }
    }

    @objc func editingChangedEvent() -> Void {
        self.editingChanged?(textInput.text ?? "", nil)
    }

    @objc private func passwordSecureControl(sender: UIButton) -> Void {

        if (textInput.isSecureTextEntry == false) {
            sender.setImage(#imageLiteral(resourceName: "unhidden-1"), for: .normal)
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "hidden-1"), for: .normal)
        }

        textInput.isSecureTextEntry.toggle()
    }
}

extension DefaultTextFieldCellView : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textInput.keyboardType == .phonePad {
            let editedString = newString.formattedNumber()
            textInput.text = editedString
            editingChanged?(editedString, nil)
            return false
        }
        return true
    }
}
