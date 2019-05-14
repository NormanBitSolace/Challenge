import Foundation

struct TodayCalendarViewModel {
    let day: String
    let dayOfMonth: String
    let monthYear: String
}


extension TodayCalendarViewModel {

    static func build() ->TodayCalendarViewModel {
        let today = Date()
        let day = today.dateString("EEEE")
        let dayOfMonth = today.dateString("d")
        let monthYear = today.dateString("MMM YYYY")
        return TodayCalendarViewModel(day: day, dayOfMonth: dayOfMonth, monthYear: monthYear)
    }
}
