//   1.  Создайте новый проект с использованием SwiftUI.
// 2. Добавьте в созданный проект дополнительное текстовое поле с вашим именем. Оно должно располагаться под текстовым полем, созданным Xcode.
//3. Добавьте анимацию изменения прозрачности текста при открытии экрана. Прозрачность должна меняться от 0 до 1 в течение трёх секунд. Для установки прозрачности на элементе Text используйте метод opacity. Для запуска анимации используйте метод onAppear.
//4. Запустите проект, убедитесь, что всё работает. Сделайте скриншот конечного состояния экрана после анимации и скопируйте код. Они понадобятся для отправки результатов работы на проверку.
import SwiftUI

struct ContentView: View {
    @State var opacityValue = 1.0
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
                .font(.largeTitle)
        // задание 2
            Text("Vasilii")
                .padding()
        }
        .opacity(opacityValue)
        .onAppear {
            let baseAnim = Animation.easeInOut(duration: 3)
            withAnimation(baseAnim){
                opacityValue = 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
