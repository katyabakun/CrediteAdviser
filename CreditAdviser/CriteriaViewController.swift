import UIKit
import CoreActionSheetPicker

class CriteriaViewController: UITableViewController{
    let closeHeight: CGFloat = 91
    let openHeight: CGFloat = 91
    var itemHeight = [CGFloat]()
    var chosenBank : [Bank]
    var rows = [String]()
    var items = [Item]()
    var options = [String:Int]()
    var optionsInvert = [Int:String]()
    var datePickerIndexPath: NSIndexPath?
    var matrixToCheck = [Double]()
    var flagaForMatrix: Bool = false
    var arrayToCheck = [Double]()
    init(initWithData banks: [Bank]){
        self.chosenBank = banks
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rows = ["Oprocentowanie","Raty","Prowizja"]
        options = ["oba porównywane warianty są równie dobre":1,"wariant pierwszy jest nieznacznie lepszy od drugiego":3,"wariant pierwszy jest wyraźnie lepszy od drugiego":5,"wariant pierwszy jest zdecydowanie lepszy od drugiego":7, "wariant pierwszy jest bezwzględnie lepszy od drugiego":9]

        optionsInvert = [1:"oba porównywane warianty są równie dobre",2:"wariant jest między równie preferowany a nieznacznie liepszy od wariantu drugiego ",3:"wariant pierwszy jest nieznacznie lepszy od drugiego",4:"wariant jest między nieznacznie leszy a wyraźnie liepszy od drugiego",5:"wariant pierwszy jest wyraźnie lepszy od drugiego",6:"wariant pierwszy jest między wyraźnie lepszy a zdecydowanie lepszy od drugiego",7:"wariant pierwszy jest zdecydowanie lepszy od drugiego",8:"wariant pierwszy jest zdecydowanie lepszy a bezwzględnie lepszy od drugiego",9: "wariant pierwszy jest bezwzględnie lepszy od drugiego"]
        for i in 0..<rows.count-1{
            for x in i+1..<rows.count{
                let row = Item(nameA: rows[i], nameB: rows[x], options: options, imageA: UIImage(named: "settings")!,imageB:UIImage(named: "rating")!)
                
                if(row.nameA != row.nameB){
                    items.append(row)
                }
            }
        }
        tableView.register(CriteriaCellView.self, forCellReuseIdentifier: "cell")
        
 
        
        let saveButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width/6, height: self.view.frame.width/6))
        
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveOption), for: .touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = saveButton
        self.navigationItem.setRightBarButton(barButton, animated: true)
        itemHeight = Array(repeating: 91, count: items.count)
        registerCell()
        self.navigationItem.title = "Porównanie kryteriów"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CriteriaViewController{
    
    

    
    func registerCell() {
        tableView.register(CriteriaCellView.self, forCellReuseIdentifier: "cell")
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemHeight.count
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! CriteriaCellView
        cell.textLabelf.text = items[indexPath.row].nameA
        cell.textLabelfb.text = items[indexPath.row].nameB
        cell.imageViewf.image = items[indexPath.row].imageA
        cell.imageViewfb.image = items[indexPath.row].imageB
        if !arrayToCheck.isEmpty && !flagaForMatrix{
            let i = arrayToCheck[indexPath.row]
            
            cell.ofertaName.text = "\(optionsInvert[Int(i)]!)"
            
        }else if flagaForMatrix{
            let i = matrixToCheck[indexPath.row]
            
            cell.ofertaName.text = "\(optionsInvert[Int(i)]!)"
        }
        print(cell.index)
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CriteriaCellView
        multipleStringPickerClicked(sender:cell)
        tableView.reloadData()
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight { // open cell
            itemHeight[indexPath.row] = openHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            itemHeight[indexPath.row] = closeHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    func multipleStringPickerClicked(sender: CriteriaCellView) {
        
        let values = options.flatMap(){ $0.0 }
        
        let acp = ActionSheetStringPicker(title: "Skala Satiego", rows: values, initialSelection: 1, doneBlock: {
            picker, values, indexes in
            
            print("values = \(values)")
            print("indexes = \(String(describing: indexes))")
            print("picker = \(String(describing: picker))")
            
            sender.ofertaName.text = indexes as? String
            
            self.matrixToCheck.append(Double(self.options[indexes as! String]!))
            
            print(self.matrixToCheck)
            
            return
        }, cancel: {ActionStringCancelBlock in return}, origin: sender)
        acp?.setTextColor(darkMintColor)
        acp?.pickerBackgroundColor = UIColor.lightGray
        acp?.toolbarBackgroundColor = mintColor1
        acp?.toolbarButtonsColor = UIColor.white
        acp?.show()
        
        return
    }
    func saveOption(){
        if matrixToCheck.count==items.count{
        var matrix = createMatrix(array: matrixToCheck, size: items.count)
        print(matrix)
        let isSpojne = czySpojne(wekt_pref: wekt_preferencji(macierz: macierz_unorm(macierz: matrix)), suma_kol: sumaKolumn(macierz: matrix))
        if isSpojne{
            self.navigationController?.pushViewController(CriteriaComparitionViewController.init(initWithData: self.chosenBank, s0: self.wekt_preferencji(macierz: self.macierz_unorm(macierz: matrix)), navTitle: rows[0]), animated: true)

        }else{
            let alertController = UIAlertController(title: "Zmień macierz porównań", message:
                "Macierz nie jest spójna!", preferredStyle: UIAlertControllerStyle.alert)
            let zmienAction = UIAlertAction(title: "Zmień", style: .default) { (_) -> Void in
              print(matrix)
            matrix = self.poprawaSpojnosci(macierz: matrix)
                print( self.czySpojne(wekt_pref: self.wekt_preferencji(macierz: self.macierz_unorm(macierz: matrix)), suma_kol: self.sumaKolumn(macierz: matrix)))
            self.arrayToCheck = self.createArray(matrix: matrix)
                print(self.arrayToCheck)
                print(self.matrixToCheck)
                for i in 0..<self.matrixToCheck.count{
                    if self.matrixToCheck[i] != self.arrayToCheck[i]{
                       
                        
                        self.tableView.reloadData()
                    }
                }
                
              let alertPotwierdz = UIAlertController(title: "Czy potwierdzasz zmianę", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Tak", style: .default) { (_) -> Void in
                    
                    self.navigationController?.pushViewController(CriteriaComparitionViewController.init(initWithData: self.chosenBank, s0: self.wekt_preferencji(macierz: self.macierz_unorm(macierz: matrix)), navTitle: self.rows[0]), animated: true)
                }
                let cancelButton = UIAlertAction(title: "Nie", style: .default) { (_) -> Void in
                    
                    let alertInsert = UIAlertController(title: "Alert!", message: "Wyniki rankingu mogą być niepoprawne", preferredStyle: .alert)
                    
                    
                    let okButton = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                        self.flagaForMatrix = true
                        self.tableView.reloadData()
                        var matrix = self.createMatrix(array: self.matrixToCheck, size: self.items.count)
                        self.navigationController?.pushViewController(CriteriaComparitionViewController.init(initWithData: self.chosenBank, s0: self.wekt_preferencji(macierz: self.macierz_unorm(macierz: matrix)), navTitle: self.rows[0]), animated: true)
                    }

                    alertInsert.addAction(okButton)
                    self.present(alertInsert, animated: true, completion: nil)
                }
                alertPotwierdz.addAction(okButton)
                alertPotwierdz.addAction(cancelButton)
                self.present(alertPotwierdz,animated: true,completion: nil)
            }
            let action = UIAlertAction(title: "Zatwierdź", style: .default) { (_) -> Void in
                
                let alertInsert = UIAlertController(title: "Alert!", message: "Wyniki rankingu mogą być niepoprawne", preferredStyle: .alert)
                
                    
                    let okButton = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                        self.flagaForMatrix = true
                        self.tableView.reloadData()
                        var matrix = self.createMatrix(array: self.matrixToCheck, size: self.items.count)
                        self.navigationController?.pushViewController(CriteriaComparitionViewController.init(initWithData: self.chosenBank, s0: self.wekt_preferencji(macierz: self.macierz_unorm(macierz: matrix)), navTitle: self.rows[0]), animated: true)
                    }
                    
                    alertInsert.addAction(okButton)
                    self.present(alertInsert, animated: true, completion: nil)
              
            
            }
            alertController.addAction(zmienAction)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            }}else{
            let alertInsert = UIAlertController(title: "Alert!", message: "Wielkość macierzy się ni zgadza", preferredStyle: .alert)
            
            
            let okButton = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
                
                
                
                self.navigationController?.pushViewController(CriteriaViewController.init(initWithData: self.chosenBank), animated: true)
            }
            
            alertInsert.addAction(okButton)
            self.present(alertInsert, animated: true, completion: nil)
        }
    }
    func createMatrix(array: [Double],size: Int)->[[Double]]{
        let row = Array(repeating: 1.0, count: size)
        var matrix : [[Double]] = Array(repeating: row, count: size)
        var x = 0
        var y = 0
        for i in 0..<size{
            for j in 0..<size{
                if i==j {
                    matrix[i][j]=1
                }else if i<j{
                    matrix[i][j] = Double(array[x])
                    x+=1
                }else {
                    matrix[i][j] = Double(1/matrix[j][i])
                    y+=1
                }
            }
        }
        return matrix
    }
    func createArray(matrix: [[Double]])->[Double]{
        var array = [Double]()
        
        for i in 0..<matrix.count{
            for j in 0..<matrix.count{
                if i<j{
                    array.append(matrix[i][j])
                }
            }
        }
        return array
    }
    //obliczanie sumy "c" w kolumnach macierzy
    func sumaKolumn(macierz:[[Double]])->[Double]{
        
        var c : [Double]=[]
        var sum: Double
        
        for x in 0..<macierz.count // zliczanie sumy c w kolumnie mac
        {
            sum = 0.0
            for y in 0..<macierz.count
            {
                sum += macierz[y][x];
            }
            c.append(sum)
            
        }
        
        return c;
    }

    // MACIERZ UNORMOWANA
    func macierz_unorm(macierz: [[Double]])->[[Double]]{
        var c: [Double]=[];
        
        c=sumaKolumn(macierz: macierz);
        print(c)
        var unorm_macierz:[[Double]] = macierz
        for x in 0..<macierz.count{
            
            for y in 0..<macierz.count{
                unorm_macierz[y][x] = macierz[y][x]/c[x];
            }}
        print(unorm_macierz)
        return unorm_macierz;
        
    }
    
    
    
    //WEKTOR PREFERENCJI---- suma w wierszu macierz_unorm/ iloúÊ kolumn iloúc kolumn=3
    func wekt_preferencji(macierz: [[Double]])->[Double]{
        
        var suma:Double
        var c = Array(repeating: 0.0, count: macierz.count)
        
        
        for x in 0..<macierz.count
        {
            suma=0
            for y in 0..<macierz.count
            {
                suma+=macierz[x][y];
            }
            c[x]=suma/Double(macierz.count)
            
        }
        print(c)
        return c;
        
    }
    

    
    //Sprawdzanie spÛjnoúci
    // TODO: SPRAWDZIC FU
    func czySpojne(wekt_pref: [Double],suma_kol: [Double])->Bool{
        var RI = Double()
        switch wekt_pref.count{
            
        case 1,2:
            RI = 0.52
        case 3:
            RI = 0.89
        case 4:
            RI = 1.11
        default:
            RI=0.52
        }
        
        var lambda_max:Double=0
        
        for x in 0..<wekt_pref.count {
            lambda_max += wekt_pref[x]*suma_kol[x]
        }
        
        let CI = (lambda_max-Double(suma_kol.count) ) / Double(suma_kol.count-1)
        let CR=CI/RI
        
        print(lambda_max)
        print(CR)
        
        if(CR>0.1)
        {
            print("\n Macierz nie jest spojna")
            
            return false
        }else{
            print("\n Macierz jest spojna")}
        return true
    }
    //szuka maxa
    func Max(macierzTemp: [[Double]])->Double {
        
        var max = macierzTemp[0][0];
        
        for i in 0..<macierzTemp.count
        {
            for j in 1..<macierzTemp.count {
                if (macierzTemp[i][j] > max){
                    max = macierzTemp[i][j]
                }}
            
        }
        return max
    }
    
    //minimum
    func Min(macierzTemp:[[Double]])->Double {
        
        var min = macierzTemp[0][0]
        
        for i in 0..<macierzTemp.count
        {
            for j in 1..<macierzTemp.count {
                if (min > macierzTemp[i][j]) {
                    min =  macierzTemp[i][j]
                }
            }}
        
        return min
    }
    
    
    
    
    //Poprawa spÛjnoúÊi metoda A^2- maksymalna wartoúÊ w≥asna
    func poprawaSpojnosci(macierz: [[Double]])->[[Double]]{
        var macierzTemp=[[Double]]()
        let row = Array(repeating: 0.0, count: macierz.count)
        for item in macierz{
            macierzTemp.append(row)
        }
        
        for i in 0..<macierz.count{
            for j in 0..<macierz.count{
                macierzTemp[i][j]=0;
                for u in 0..<macierz.count{
                    macierzTemp[i][j]+=macierz[i][u]*macierz[u][j]}
            }
        }
        
        //liczenie sumy w wierszach
        var suma: Double
        var suma_calk=0;
        var c=Array(repeating: 0.0, count: macierz.count)
        //double p= macierzTemp[0][0];
        
        var max=Max(macierzTemp: macierzTemp);
        var min=Min(macierzTemp: macierzTemp);
        var roz=max-min;
        
        for i in 0..<macierz.count
        {
            suma=0.0;
            for j in 0..<macierz.count
            {
                suma+=macierz[i][j]
                if(macierzTemp[i][j]>=min && macierzTemp[i][j] < (min+(roz/5))){
                    macierzTemp[i][j]=1
                }
                else if (macierzTemp[i][j]<=max && macierzTemp[i][j]>=(max-(roz/5)))
                { macierzTemp[i][j]=9}
                else
                {
                    if(macierzTemp[i][j]>=(min+(roz/5)) && macierzTemp[i][j] < (min+2*(roz/5))){ macierzTemp[i][j]=3}
                    else if(macierzTemp[i][j]>=(min+2*(roz/5)) && macierzTemp[i][j] < (min+3*(roz/5))){ macierzTemp[i][j]=5}
                    else if(macierzTemp[i][j]>=(min+3*(roz/5)) && macierzTemp[i][j] < (min+4*(roz/5))){ macierzTemp[i][j]=7}
                }}
            macierzTemp=utwMacierz(macierz: macierzTemp)
            
            
        }
        return macierzTemp
        
    }
    func utwMacierz(macierz: [[Double]])->[[Double]]{
            
            var macierzTemp = [[Double]]()
            let row = Array(repeating: 0.0, count: macierz.count)
            for item in macierz{
                macierzTemp.append(row)
            }
            
            for j in 0..<macierz.count{
                for  i in 0..<macierz.count{
                    macierzTemp[i][j]=macierz[i][j]
                    macierzTemp[j][i]=1/macierz[i][j]
                }
                
            }
            return macierzTemp;
            
        }
    
}



