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
        if let attendingCourses = attendingCourses {
            return "\(super.introduction()) I'm a student at \(faculty). My favourite course is \(attendingCourses.first!.aboutCourse())"
        }
        
        return "\(super.introduction()) I'm a student at \(faculty)."
    }
}

let mirko = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: Location())
let nedim = Person(name: "Nedim", lastName: "Sabic", yearOfBirth: 1982, location: Location())

let seo = Course(teacher: nedim, courseName: "SEO")
let iOSDevelopment = Course(teacher: mirko, courseName: "iOS Development")


let courses = [iOSDevelopment, seo]
let student = Student(name: "Kenan", lastName: "Kahric", yearOfBirth: 1995, location: Location(), attendingCourses: courses, grades: [10, 10, 8, 9, 9, 10])

mirko.introduction()
nedim.introduction()
student.introduction()

