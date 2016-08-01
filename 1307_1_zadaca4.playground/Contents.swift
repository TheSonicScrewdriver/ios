//: Playground - noun: a place where people can play
import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
    
    init() {
        latitude = Double(arc4random()%181) - 90.0
        longitude = Double(arc4random()%361) - 90.0
    }
}
struct Course {
    let teacher: Person
    let courseName: String
    
    func aboutCourse() -> String{
        return "\(courseName) course by prof. \(teacher.lastName)"
    }
}

class Person {
    var name: String?
    var lastName: String?
    var yearOfBirth: Int
    var location: Location?
    var age: Int {
        get { return 2016 - yearOfBirth }
        set { yearOfBirth = 2016 - age }
    }
    
    init(name: String?, lastName: String?, yearOfBirth: Int?, location: Location?){
        self.name = "/"
        self.lastName = "/"
        self.yearOfBirth = 1990
        self.location = Location()
        
        if let name = name {
            self.name = name
        }
        if let lastName = lastName {
            self.lastName = lastName
        }
        if let yearOfBirth = yearOfBirth {
            self.yearOfBirth = yearOfBirth
        }
        if let location = location {
            self.location = location
        }
    }
    
    convenience init (name: String, lastName: String) {
        self.init(name: name, lastName: lastName, yearOfBirth: 1990, location: Location())
    }
    
    func introduction() -> String {
        return "Hi, my name is \(name) \(lastName). My age is \(age)."
    }
}

class Parent: Person {
    var children:[Person]?
    var savings: Double?
    
    init (name: String?, lastName: String?, yearOfBirth: Int?, location: Location, children: [Person]?, savings: Double?) {
        
        self.children = children
        self.savings = savings
        
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    override func introduction() -> String {
        if let children = children {
            let intro = super.introduction() + "I'm parent of \(children.count) children "
        } else {
            let intro = super.introduction() + "I have no children "
        }
        
        return intro
    }
}

class Student: Person {
    var attendingCourses: [Course]?
    var grades: [Int]?
    
    let faculty = "WiP"
    var averageGrade: Double?{
        if let grades = grades {
            var averageGradeSum = 0
            for grade in grades {
                averageGradeSum += grade
            }
            // check if average grade is number and greater than 0
            if averageGradeSum > 0 {
                return Double(averageGradeSum) / Double(grades.count)
            }
        }
        return nil
    }
    
    init(name: String?, lastName: String?, yearOfBirth: Int?, location: Location?, attendingCourses: [Course]?, grades: [Int]?){
        self.attendingCourses = nil
        self.grades = nil
        
        if let attendingCourses = attendingCourses {
            self.attendingCourses = attendingCourses
        }
        
        if let grades = grades {
            self.grades = grades
        }
        
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    
    override func introduction() -> String {
        
        var intString = super.introduction() + " I'm student at \(faculty). "
        
        if attendingCourses!.isEmpty {
            intString += "[There is no courses you are attending ]"
        } else {
            intString += "My favourite course is" + " " + attendingCourses!.first!.aboutCourse() + " " + "and my average is \(averageGrade!) "
        }
        
        guard(father?.savings != nil || mother?.savings != nil) else {
            intString += "My parents are broke"
            return intString
        }
        
        if let fatherSavings = father?.savings {
            intString += "My father have \(fatherSavings) savings"
        }
        if let motherSavings = mother?.savings {
            intString += "My mother have \(motherSavings) savings"
        }
        return intString
    }
}

let mirko = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: Location())
let nedim = Person(name: "Nedim", lastName: "Sabic", yearOfBirth: 1982, location: Location())

let seo = Course(teacher: nedim, courseName: "SEO")
let iOSDevelopment = Course(teacher: mirko, courseName: "iOS Development")

let courses = [iOSDevelopment, seo]
let grades = [10, 10, 8, 9, 9, 10]

let student = Student(name: "Kenan", lastName: "Kahric", yearOfBirth: 1995, location: Location(), attendingCourses: courses, grades: grades)

var randomSavings = Double(arc4random() % 10000)

var brother = Person(
    name: "Niko",
    lastName: "Neznanovic",
    yearOfBirth: 1990,
    location: Location()
)

var father = Parent(
    name: "Edin",
    lastName: "Kahric",
    yearOfBirth: 1969,
    location: Location(),
    children: [student, brother],
    savings: randomSavings
)

var mother = Parent(
    name: "Aida",
    lastName: "Kahric",
    yearOfBirth: 1970,
    location: Location(),
    children: [student, brother],
    savings: randomSavings
)

mirko.introduction()
nedim.introduction()
student.introduction()

