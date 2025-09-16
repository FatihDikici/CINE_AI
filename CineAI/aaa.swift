/*
 
 # RegisterViewController Detaylı Kod Analizi

 ## 1. Class Tanımı ve Özellikler

 ### Temel Class Yapısı
 ```swift
 class RegisterViewController: UIViewController {
     var presenter: RegisterPresenterProtocol?
 ```
 - **MVP (Model-View-Presenter) mimarisi** kullanılıyor
 - `presenter` ile iş mantığı ayrılmış

 ### UI Bileşenleri

 #### Background ve Görsel Efektler
 ```swift
 let backgroundView = UIView()
 let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
 ```
 - `backgroundView`: Gradient arkaplan için container
 - `blurEffectView`: iOS'un modern blur efekti (kullanılmamış ancak tanımlanmış)

 #### Logo ve Başlık Bileşenleri
 ```swift
 let logoImageView = UIImageView()
 let titleLabel = UILabel()
 let subtitleLabel = UILabel()
 ```
 - `logoImageView`: Üstte kullanıcı ikonu gösteriyor
 - `titleLabel`: "HESAP OLUŞTUR" ana başlık
 - `subtitleLabel`: "Sinema Serüveniniz Başlasın" alt başlık

 #### Form Container'ları
 ```swift
 let emailContainerView = UIView()
 let passwordContainerView = UIView()
 let confirmPasswordContainerView = UIView()
 ```
 - Her input field için **glassmorphism** efektli container'lar
 - Modern, şeffaf görünüm

 #### Text Field'lar
 ```swift
 let emailTextField = UITextField()
 let passwordTextField = UITextField()
 let confirmPasswordTextField = UITextField()
 ```
 - E-posta, şifre ve şifre doğrulama için input alanları

 #### Butonlar ve Activity Indicator
 ```swift
 let registerButton = UIButton(type: .system)
 let loginButton = UIButton(type: .system)
 let activity = UIActivityIndicatorView(style: .large)
 ```
 - `registerButton`: Yeşil gradient'li ana kayıt butonu
 - `loginButton`: Şeffaf ikincil buton
 - `activity`: Loading animasyonu

 #### İkonlar ve Floating Label'lar
 ```swift
 let emailIconImageView = UIImageView()
 let passwordIconImageView = UIImageView()
 let confirmPasswordIconImageView = UIImageView()

 let emailFloatingLabel = UILabel()
 let passwordFloatingLabel = UILabel()
 let confirmPasswordFloatingLabel = UILabel()
 ```
 - SF Symbols ikonları (envelope, lock vb.)
 - **Material Design tarzı floating label'lar**

 ## 2. Stack View'lar (Layout Yönetimi)

 ### Form Stack View
 ```swift
 lazy var formStackView: UIStackView = {
     let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, confirmPasswordContainerView])
     stackView.axis = .vertical
     stackView.spacing = 20
     stackView.alignment = .fill
     return stackView
 }()
 ```
 - **Dikey yerleşim** ile form elemanlarını düzenler
 - 20pt aralarla eşit dağılım

 ### Button Stack View
 ```swift
 lazy var buttonStackView: UIStackView = {
     let stackView = UIStackView(arrangedSubviews: [registerButton, loginButton])
     stackView.axis = .vertical
     stackView.spacing = 15
     return stackView
 }()
 ```
 - Butonları dikey olarak düzenler
 - 15pt aralarla yerleştirir

 ## 3. ViewDidLoad ve Ana Setup

 ```swift
 override func viewDidLoad() {
     super.viewDidLoad()
     setupUI()
     setupAnimations()
     presenter?.viewDidLoad()
 }
 ```
 - UI kurulumu, animasyon hazırlığı ve presenter bildirimini sırayla yapar

 ## 4. Gradient Background Setup

 ```swift
 func setupGradientBackground() {
     let gradientLayer = CAGradientLayer()
     gradientLayer.colors = [
         UIColor(red: 0.08, green: 0.12, blue: 0.25, alpha: 1.0).cgColor,
         UIColor(red: 0.15, green: 0.08, blue: 0.20, alpha: 1.0).cgColor,
         UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0).cgColor
     ]
     gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
     gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
 }
 ```
 **Animasyon/Efekt**:
 - **Çapraz gradient** (sol üstten sağ alta)
 - **Koyu mavi-mor tonları** (sinema teması)
 - 3 renk geçişi ile **depth efekti**

 ## 5. Input Container Setup (Glassmorphism)

 ```swift
 func setupInputContainer(containerView: UIView, textField: UITextField, iconImageView: UIImageView, floatingLabel: UILabel, placeholder: String, iconName: String) {
     containerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
     containerView.layer.cornerRadius = 15
     containerView.layer.borderWidth = 1
     containerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
 ```
 **Animasyon/Efekt**:
 - **%8 şeffaflık** ile glassmorphism
 - **15pt corner radius** ile modern köşeler
 - **Çok ince border** ile definition

 ```swift
 containerView.layer.shadowColor = UIColor.black.cgColor
 containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
 container.layer.shadowRadius = 8
 containerView.layer.shadowOpacity = 0.1
 ```
 **Shadow Efekti**:
 - **2pt aşağı offset** ile floating görünüm
 - **8pt blur radius** ile soft shadow
 - **%10 opacity** ile subtle etki

 ## 6. Register Button Gradient Setup

 ```swift
 func setupRegisterButton() {
     let gradientLayer = CAGradientLayer()
     gradientLayer.colors = [
         UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0).cgColor,
         UIColor(red: 0.1, green: 0.6, blue: 0.3, alpha: 1.0).cgColor
     ]
     gradientLayer.startPoint = CGPoint(x: 0, y: 0)
     gradientLayer.endPoint = CGPoint(x: 1, y: 0)
 ```
 **Animasyon/Efekt**:
 - **Yeşil gradient** (açık yeşilden koyu yeşile)
 - **Yatay geçiş** (soldan sağa)
 - **"Başarı" teması** ile register butonu için uygun

 ```swift
 registerButton.layer.shadowColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 0.4).cgColor
 registerButton.layer.shadowOffset = CGSize(width: 0, height: 8)
 registerButton.layer.shadowRadius = 20
 registerButton.layer.shadowOpacity = 0.6
 ```
 **Glow Shadow Efekti**:
 - **Yeşil glow** shadow (buton renginde)
 - **8pt aşağı** offset ile elevation
 - **20pt blur radius** ile geniş glow
 - **%60 opacity** ile belirgin etki

 ## 7. Giriş Animasyonları

 ```swift
 func setupAnimations() {
     logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
     titleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
     subtitleLabel.alpha = 0
     formStackView.transform = CGAffineTransform(translationX: 0, y: 40)
     buttonStackView.alpha = 0
 ```
 **Başlangıç Animasyon Durumu**:
 - **Logo**: %50 küçük scale
 - **Title**: 30pt aşağı kaydırılmış
 - **Subtitle**: Tamamen saydam
 - **Form**: 40pt aşağı kaydırılmış
 - **Butonlar**: Tamamen saydam

 ### Ana Giriş Animasyonu
 ```swift
 func animateEntrance() {
     UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
         self.logoImageView.alpha = 1
         self.logoImageView.transform = .identity
     }
 ```
 **Logo Animasyonu** (0.1s gecikme):
 - **0.8s süre** ile spring animasyon
 - **0.7 damping** ile hafif bounce efekti
 - **0.5 velocity** ile yumuşak başlangıç
 - Küçükten normal boyuta **scale** animasyonu

 ```swift
 UIView.animate(withDuration: 0.6, delay: 0.3) {
     self.titleLabel.alpha = 1
     self.titleLabel.transform = .identity
 }
 ```
 **Title Animasyonu** (0.3s gecikme):
 - **0.6s süre** ile linear animasyon
 - **Aşağıdan yukarı** slide in efekti

 ```swift
 UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
     self.formStackView.alpha = 1
     self.formStackView.transform = .identity
 }
 ```
 **Form Animasyonu** (0.5s gecikme):
 - **0.8 damping** ile daha az bounce
 - **Aşağıdan yukarı** slide in + **fade in**

 ## 8. Focus ve Unfocus Animasyonları

 ### Focus Animasyonu (Input'a tıklandığında)
 ```swift
 func animateFocus(containerView: UIView, iconImageView: UIImageView) {
     UIView.animate(withDuration: 0.2) {
         containerView.layer.borderColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8).cgColor
         containerView.layer.borderWidth = 2
         iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
         containerView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
     }
 }
 ```
 **Focus Efektleri**:
 - **Border color**: Altın sarısına geçiş (0.2s)
 - **Border width**: 1pt'den 2pt'ye kalınlaştırma
 - **Icon tint**: Altın sarısına değişim
 - **Micro scale**: %2 büyütme (subtle highlight)

 ### Unfocus Animasyonu (Input'tan çıkıldığında)
 ```swift
 func animateUnfocus(containerView: UIView, iconImageView: UIImageView) {
     UIView.animate(withDuration: 0.2) {
         containerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
         containerView.layer.borderWidth = 1
         iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
         containerView.transform = .identity
     }
 }
 ```
 **Unfocus Efektleri**:
 - **Orijinal renge dönüş** (şeffaf beyaz)
 - **Normal boyuta** geri dönüş
 - **İkon rengi** soluklaştırma

 ## 9. Floating Label Animasyonları

 ```swift
 func animateFloatingLabel(floatingLabel: UILabel, textField: UITextField) {
     let shouldShow = !(textField.text?.isEmpty ?? true)
     
     UIView.animate(withDuration: 0.2) {
         floatingLabel.alpha = shouldShow ? 1.0 : 0.0
     }
 }
 ```
 **Material Design Floating Labels**:
 - **Metin varsa**: Label görünür hale gelir (fade in)
 - **Metin yoksa**: Label kaybolur (fade out)
 - **0.2s yumuşak geçiş**

 ## 10. Validation Animasyonları

 ### E-posta Validasyonu
 ```swift
 func validateEmailFormat() {
     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
     let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
     let isValidEmail = emailPredicate.evaluate(with: email)
     
     UIView.animate(withDuration: 0.2) {
         if isValidEmail {
             self.emailContainerView.layer.borderColor = UIColor.systemGreen.cgColor
             self.emailIconImageView.tintColor = UIColor.systemGreen
         } else {
             self.emailContainerView.layer.borderColor = UIColor.systemOrange.cgColor
             self.emailIconImageView.tintColor = UIColor.systemOrange
         }
     }
 }
 ```
 **Real-time Validation Efektleri**:
 - **Geçerli e-posta**: Yeşil border + yeşil ikon
 - **Geçersiz format**: Turuncu border + turuncu ikon
 - **0.2s smooth renk geçişi**

 ### Şifre Gücü Validasyonu
 ```swift
 func validatePasswordStrength() {
     let isStrongPassword = password.count >= 6
     // Yeşil (güçlü) veya turuncu (zayıf) renk feedback'i
 }
 ```

 ### Şifre Eşleşme Kontrolü
 ```swift
 func validatePasswordMatch() {
     let passwordsMatch = password == confirmPassword
     // Yeşil (eşleşiyor) veya kırmızı (eşleşmiyor) feedback
 }
 ```

 ## 11. Button Press Animasyonları

 ### Press Down Efekti
 ```swift
 @objc func buttonPressed(_ sender: UIButton) {
     UIView.animate(withDuration: 0.1) {
         sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
     }
 }
 ```
 **Touch Feedback**:
 - **%5 küçültme** ile basılma hissi
 - **0.1s hızlı** animasyon

 ### Release Efekti
 ```swift
 @objc func buttonReleased(_ sender: UIButton) {
     UIView.animate(withDuration: 0.1) {
         sender.transform = .identity
     }
 }
 ```
 **Release Feedback**:
 - **Normal boyuta geri dönüş**
 - Tactile feedback tamamlanması

 ## 12. Ripple Effect (Modern Touch Feedback)

 ```swift
 func addButtonRippleEffect(button: UIButton) {
     let rippleLayer = CAShapeLayer()
     let center = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
     let startRadius: CGFloat = 0
     let endRadius = max(button.bounds.width, button.bounds.height)
     
     rippleLayer.path = UIBezierPath(arcCenter: center, radius: startRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
     rippleLayer.fillColor = UIColor(white: 1.0, alpha: 0.3).cgColor
 ```
 **Material Design Ripple**:
 - **Merkez noktadan** dalgalanma
 - **Circular expansion** animasyonu
 - **%30 beyaz şeffaflık**

 ```swift
 let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
 scaleAnimation.fromValue = 0
 scaleAnimation.toValue = endRadius / startRadius

 let opacityAnimation = CABasicAnimation(keyPath: "opacity")
 opacityAnimation.fromValue = 0.6
 opacityAnimation.toValue = 0
 ```
 **Ripple Animasyon Detayları**:
 - **Scale**: 0'dan buton boyutuna genişleme
 - **Opacity**: %60'dan %0'a fade out
 - **0.4s toplam süre**

 ## 13. Loading State Animasyonları

 ### Loading Gösterimi
 ```swift
 func showLoading() {
     UIView.animate(withDuration: 0.3) {
         self.activity.startAnimating()
         self.registerButton.isEnabled = false
         self.registerButton.alpha = 0.6
         self.formStackView.alpha = 0.5
     }
 }
 ```
 **Loading Efektleri**:
 - **Activity indicator** başlatılır
 - **Register button** %60 saydamlık (disabled look)
 - **Form** %50 saydamlık
 - **0.3s smooth** transition

 ### Loading Gizleme
 ```swift
 func hideLoading() {
     UIView.animate(withDuration: 0.3) {
         self.activity.stopAnimating()
         self.registerButton.isEnabled = true
         self.registerButton.alpha = 1.0
         self.formStackView.alpha = 1.0
     }
 }
 ```
 **Loading Bitiş Efektleri**:
 - **Tüm elemanlar** normal haline döner
 - **Smooth fade in** ile kullanıcı etkileşimi geri gelir

 ## 14. Hata ve Başarı Animasyonları

 ### Hata Alert'i
 ```swift
 func showRegisterError(_ message: String) {
     let alert = UIAlertController(title: "⚠️ Kayıt Hatası", message: message, preferredStyle: .alert)
     alert.view.tintColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
 ```
 **Error Handling**:
 - **Modern alert** görünümü
 - **Emoji** ile görsel feedback
 - **Tema renginde** tint color

 ```swift
 UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse, .repeat]) {
     self.emailContainerView.layer.borderColor = UIColor.red.cgColor
     // Diğer container'lar da kırmızı
 }
 ```
 **Input Shake/Highlight Efekti**:
 - **Kırmızı flash** animasyonu
 - **Auto-reverse** ile gidip gelme
 - **Error indication** için visual feedback

 ### Başarı Animasyonu
 ```swift
 func navigateToMainScreen() {
     UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3) {
         self.registerButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
     } completion: { _ in
         UIView.animate(withDuration: 0.3) {
             self.registerButton.transform = .identity
         }
     }
 }
 ```
 **Success Celebration**:
 - **%10 büyütme** ile success emphasis
 - **Spring animation** ile bounce efekti
 - **0.6 damping** ile belirgin bounce
 - **Geri dönüş** animasyonu ile normal boyut

 ## 15. Dinamik Gradient Frame Update

 ```swift
 override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     updateGradientFrame()
     updateButtonGradientFrame()
 }

 func updateGradientFrame() {
     if let gradientLayer = backgroundView.layer.sublayers?.first as? CAGradientLayer {
         gradientLayer.frame = view.bounds
     }
 }
 ```
 **Responsive Gradient**:
 - **Device rotation** ile gradient yeniden boyutlandırma
 - **Auto-layout** ile uyumlu çalışma
 - **Real-time** frame güncellemesi

 ## Genel Animasyon Karakteristikleri

 ### Timing ve Easing
 - **Fast interactions**: 0.1-0.2s (button press, focus)
 - **Medium transitions**: 0.3s (loading states)
 - **Entrance animations**: 0.6-0.8s (dramatic entrances)
 - **Spring animations**: Organic, bouncy feel

 ### Renk Paleti
 - **Ana tema**: Koyu mavi-mor gradient
 - **Accent**: Altın sarısı (#FFCC33)
 - **Success**: Yeşil tonları
 - **Error**: Kırmızı/turuncu
 - **Glassmorphism**: %8-10 beyaz şeffaflık

 ### Modern Design Patterns
 - **Glassmorphism**: Şeffaf, bulanık elemanlar
 - **Neumorphism**: Soft shadow'lar
 - **Material Design**: Ripple effects, floating labels
 - **Spring animations**: iOS native feel
 - **Micro-interactions**: Hover, focus, press states

 Bu kod, **sinematik** bir tema ile **modern iOS design language**'ını birleştirerek kullanıcı dostu ve görsel olarak etkileyici bir kayıt deneyimi oluşturuyor.
 
 
 */
