//Что нужно сделать
//
//Создайте демонстрационное приложение со шрифтами, цветами и изображениями из Figma. Для работы используйте макет.
//
//    Создайте новый проект.
//    Создайте файл с константами и перенесите туда стили текста, которые используются в макете.
//    Добавьте в файл с константами и в проект цвета, которые используются в макете.
//    Добавьте в проект и в константы изображения, экспортированные из Figma. Каждое изображение нужно экспортировать только в одном экземпляре.
//    Создайте экран приложения из одного экрана, соответствующий макету, на котором будут UILabel, UIImageView и UIButton:
//        Все лейблы должны соответствовать по стилю и цветам лейблам из дизайна.
//        Лейблы можно настраивать и через параметры, и через NSAttributedString.
//        В проекте должно быть по одному экземпляру изображения, сами иконки должны быть настроены по цвету и размеру.
//        Кнопки должны быть настроены по дизайну, включая тени.

import UIKit

class ViewController: UIViewController {
    //MARK: Views
    
    //stackViewPlans
    private lazy var stackViewPlans: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 36
        stackView.addArrangedSubview(labelPlans)
        return stackView
    }()
    
    // stackViewPrepare
    private lazy var stackViewPrepare: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        // добавить в стэк лэйбл и изображения
        stackView.addArrangedSubview(labelPrepare)
        stackView.addArrangedSubview(cartRed)
        stackView.addArrangedSubview(cartYellow)
        stackView.addArrangedSubview(cartGreen)
        return stackView
    }()
    // stackViewRoad
    private lazy var stackViewRoad: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        // добавить в стэк изображения и лейбл
        stackView.addArrangedSubview(airplane1)
        stackView.addArrangedSubview(airplane2)
        stackView.addArrangedSubview(airplane3)
        stackView.addArrangedSubview(labelRoad)
        return stackView
    }()
    
    // stackViewRest
    private lazy var stackViewRest: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        // стэк из одного лейбла
        stackView.addArrangedSubview(labelRest)
        return stackView
    }()
    
    // stackViewUmbrella
    private lazy var stackViewUmbrella: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        // стэк из изображений
        stackView.addArrangedSubview(umbrella1)
        stackView.addArrangedSubview(umbrella2)
        stackView.addArrangedSubview(umbrella3)
        return stackView
    }()
    
    // Лейбл Планы
    private lazy var labelPlans : UILabel = {
        let label = UILabel()
        // обьявить строку и поменять ее характеристики
        let labelString = "Планы:"
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font : Constants.Fonts.JuraBold36!,
        ]
        let attributeString : NSMutableAttributedString =
        NSMutableAttributedString(
            string: labelString,
            attributes: attributes
        )
       // label.textAlignment = NSTextAlignment.left
        // назначить текст лейбла получившейся строкой
        label.attributedText = attributeString
       // label.frame = CGRect (x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        
        return label
    }()
   
    // Лейбл Подготовка
    private lazy var labelPrepare : UILabel = {
//        var r = CGRect(x: 24, y: 133, width: 126, height: 45)
        let label = UILabel()
//        label.frame = r
        // обьявить строку и поменять ее характеристики
        let labelString = "Подготовка"
        let attributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorPrepare!,
            .font : Constants.Fonts.PacificoRegular24!,
            //ширина обводки текста
            .strokeWidth: -4,
            //цвет обводки текста
            .strokeColor: UIColor.black,
        ]
        let attributeString : NSMutableAttributedString =
        NSMutableAttributedString(
            string: labelString,
            attributes: attributes
        )
        //label.textAlignment = NSTextAlignment.left
        
        label.attributedText = attributeString
        // в этом примере тень задается лейблу, а не тексту (ниже будет тексту), сделано для усвоения
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.masksToBounds = false
        return label
    }()

    // Лейбл Дорога
    private lazy var labelRoad : UILabel = {
        let label = UILabel()
        // обьявить строку и поменять ее характеристики
        let labelString = "Дорога"
        let attribute : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorRoad!,
            .font : Constants.Fonts.PacificoRegular24!
        ]
        let attributeString : NSMutableAttributedString =
        NSMutableAttributedString(
            string: labelString,
            attributes: attribute
        )
  //      label.textAlignment = NSTextAlignment.right
        label.attributedText = attributeString
        return label
    }()
    
    // Лейбл Отдыха
    private lazy var labelRest : UILabel = {
        let label = UILabel()
        // обьявить строку и поменять ее характеристики
        let labelString = "Отдых"
        let attribute : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorRest!,
            .font : Constants.Fonts.PacificoRegular24!
        ]
        let attributeString : NSMutableAttributedString =
        NSMutableAttributedString(
            string: labelString,
            attributes: attribute
        )
//        label.textAlignment = NSTextAlignment.center

        label.attributedText = attributeString
        return label
    }()

    // изображение тележки красной стандарт
    private lazy var cartRed : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.cart
        imageView.setImageColor(color: .red)
        return imageView
    }()
    
    // изображение тележки пустой с желтой обводкой средней
    // сколько не искал - не нашел "нормальный" способ как "опустошить" тележку и оставить обводку, так что оставил тележку и самолет отдельными изображениями для "пустая и с обводкой"
    private lazy var cartYellow : UIImageView = {
        let imageView = UIImageView()
        let newImage = resizeImage(
            image: Constants.Images.cartBordered!,
            targetSize: CGSize(width: 42, height: 42)
        )
        imageView.image = newImage
        imageView.setImageColor(color: .yellow)
        return imageView
    }()
    
    // изображение тележки зеленой большой
    private lazy var cartGreen : UIImageView = {
        let imageView = UIImageView()
        let newImage = resizeImage(image: Constants.Images.cart!, targetSize: CGSize(width: 48, height: 48))
        imageView.image = newImage
        imageView.setImageColor(color: .green)
        return imageView
    }()
    
    // изображение самолета красной стандарт
    private lazy var airplane1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.airplane
        imageView.setImageColor(color: .red)
        return imageView
    }()
    
    // изображение самолета пустого с желтой обводкой средней
    // сколько не искал - не нашел "нормальный" способ как "опустошить" тележку и оставить обводку, так что оставил тележку и самолет отдельными изображениями для "пустая и с обводкой"
    private lazy var airplane2 : UIImageView = {
        let imageView = UIImageView()
        let newImage = resizeImage(
            image: Constants.Images.airplaneBordered!,
            targetSize: CGSize(width: 42, height: 38)
         )
        imageView.image = newImage
        imageView.setImageColor(color: .yellow)
        return imageView
    }()
    
    // изображение самолета зеленой большой
    private lazy var airplane3 : UIImageView = {
        let imageView = UIImageView()
        let newImage = resizeImage(image: Constants.Images.airplane!, targetSize: CGSize(width: 48, height: 44))
        imageView.image = newImage
        imageView.setImageColor(color: .green)
        return imageView
    }()
    
    // изображение зонта красной стандарт
    private lazy var umbrella1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.umbrella
        imageView.setImageColor(color: .red)
        return imageView
    }()
    
    // изображение зонта зеленой большой
    private lazy var umbrella2 : UIImageView = {
        let imageView = UIImageView()
        
        let newImage = resizeImage(image: Constants.Images.umbrella!, targetSize: CGSize(width: 48, height: 48))
        imageView.image = newImage
        imageView.setImageColor(color: .green)
        return imageView
    }()
    
    // изображение зонта желтой стандарт
    private lazy var umbrella3 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.umbrella
        imageView.setImageColor(color: .yellow)
        return imageView
    }()
    
    // кнопка "start"
    private lazy var buttonStart : UIButton = {
        //в этом примере уже тень задается тексту
        let textString = "start"
        // начало тень
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 4
        //конец тень
        let attribute : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorStart!,
            .font : Constants.Fonts.KnewaveRegular24!,
            .shadow : shadow
        ]
        let attributeString : NSAttributedString =
        NSAttributedString(
            string: textString,
            attributes: attribute
        )
        let attributedStringNew = attributeString.toAttributedString()
//        var config = UIButton.Configuration.borderedProminent()
//        config.attributedTitle = attributedStringNew
//        config.cornerStyle = .capsule
//        config.baseBackgroundColor = Constants.Colors.ColorStop
//        config.baseForegroundColor = Constants.Colors.ColorStart
//
//        let button = UIButton(configuration: config)
        // делаем из прямоугольной кнопки "капсулу"
        let button = CapsuleButton()
        // обязательно или не будет тени
        button.layer.masksToBounds = false
        
        button.setAttributedTitle(attributeString, for: .normal)
        button.backgroundColor = Constants.Colors.ColorStop
        button.contentEdgeInsets = UIEdgeInsets (top: 10, left: 20, bottom: 10, right: 20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        // задаем тень самой кнопке
        button.layer.shadowOffset = CGSize(width: -2, height: 5)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.8
        
        return button
    }()
    
    // кнопка "stop"
    private lazy var buttonStop : UIButton = {
        // текст для кнопки
        let textString = "stop"
        let attribute : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorStop!,
            .font : Constants.Fonts.KnewaveRegular24!,
        ]
        let attributeString : NSAttributedString =
        NSAttributedString(
            string: textString,
            attributes: attribute
        )
        // делаем из прямоугольной кнопки "капсулу"
        let button = CapsuleButton()
        button.layer.masksToBounds = false
        button.setAttributedTitle(attributeString, for: .normal)
        button.backgroundColor = Constants.Colors.ColorStart
        button.contentEdgeInsets = UIEdgeInsets (top: 10, left: 20, bottom: 10, right: 20)
        return button
    }()
    
    // кнопка "wait"
    private lazy var buttonWait : UIButton = {
        let textString = "wait"
        let attribute : [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.ColorWait!,
            .font : Constants.Fonts.KnewaveRegular24!,
        ]
        let attributeString : NSAttributedString =
        NSAttributedString(
            string: textString,
            attributes: attribute
        )
        let button = CapsuleButton()
        button.layer.masksToBounds = false
        button.setAttributedTitle(attributeString, for: .normal)
        button.backgroundColor = Constants.Colors.ColorWaitButton
        button.contentEdgeInsets = UIEdgeInsets (top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    // линия посреди экрана
    private lazy var line : UIView = {
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: 400, height: 1)
        line.backgroundColor = UIColor.blue
        return line
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
    }

    //MARK: private
    
    private func setupView() {
        view.addSubview(stackViewPlans)
        view.addSubview(stackViewPrepare)
        view.addSubview(stackViewRoad)
        view.addSubview(stackViewRest)
        view.addSubview(stackViewUmbrella)
        view.addSubview(buttonStart)
        view.addSubview(line)
        view.addSubview(buttonStop)
        view.addSubview(buttonWait)
    }
    
    // констренсы
    private func setupConstrains() {
        // отступы слева и сверху
        stackViewPlans.translatesAutoresizingMaskIntoConstraints = false
        stackViewPlans.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackViewPlans.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        // отступы слева и от "планы"
        stackViewPrepare.translatesAutoresizingMaskIntoConstraints = false
        stackViewPrepare.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackViewPrepare.topAnchor.constraint(equalTo: stackViewPlans.topAnchor, constant: 50).isActive = true
        // отступы справа и от "подготовка"
        stackViewRoad.translatesAutoresizingMaskIntoConstraints = false
        stackViewRoad.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackViewRoad.topAnchor.constraint(equalTo: stackViewPrepare.topAnchor, constant: 75).isActive = true
        // центрирование и отступ "дорога"
        stackViewRest.translatesAutoresizingMaskIntoConstraints = false
        stackViewRest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewRest.topAnchor.constraint(equalTo: stackViewRoad.topAnchor, constant: 50).isActive = true
        // центрирование и отступ от "отдых"
        stackViewUmbrella.translatesAutoresizingMaskIntoConstraints = false
        stackViewUmbrella.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewUmbrella.topAnchor.constraint(equalTo: stackViewRest.topAnchor, constant: 50).isActive = true
        // отступы слева и справа и от "зонтов"
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: 200).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.topAnchor.constraint(equalTo: stackViewUmbrella.topAnchor, constant: 75).isActive = true
        line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        // отступы слева и от линии
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        buttonStart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonStart.topAnchor.constraint(equalTo: line.topAnchor, constant: 40).isActive = true
        // назначить размеры кнопки
        buttonStart.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonStart.heightAnchor.constraint(equalToConstant: 56).isActive = true
        // отступы слева и от кнопки старт
        buttonStop.translatesAutoresizingMaskIntoConstraints = false
        buttonStop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonStop.topAnchor.constraint(equalTo: buttonStart.topAnchor, constant: 90).isActive = true
        // назначить размеры кнопки
        buttonStop.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonStop.heightAnchor.constraint(equalToConstant: 56).isActive = true
        // отступы снизу и справа
        buttonWait.translatesAutoresizingMaskIntoConstraints = false
        buttonWait.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        buttonWait.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        // назначить размеры кнопки
        buttonWait.widthAnchor.constraint(equalToConstant: 107).isActive = true
        buttonWait.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    // класс для "капсул"
    private class CapsuleButton: UIButton {
      override func layoutSubviews() {
        super.layoutSubviews()
        let height = bounds.height
        layer.cornerRadius = height/2
      }
    }
    
    // метод для изменения размера изображения
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

