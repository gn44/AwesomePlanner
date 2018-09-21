//
//  APCalendarVariables.swift
//  CalendarTest
//
//  Created by Gints Osis on 16/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import Foundation

let aPDate = Date()
let apCalendar = Calendar.current

let aPDay = apCalendar.component(.day, from: aPDate)
let aPWeekDay = apCalendar.component(.weekday, from: aPDate)
let aPMonth = apCalendar.component(.month, from: aPDate)
let aPYear = apCalendar.component(.year, from: aPDate)

let aPComponents = apCalendar.dateComponents(Set<Calendar.Component>([.month, .year, .day]), from: aPDate)
