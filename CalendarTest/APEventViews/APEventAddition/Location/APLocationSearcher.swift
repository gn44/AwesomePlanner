//
//  LocationSearcher.swift
//  CalendarTest
//
//  Created by Gints Osis on 04/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit
import MapKit

protocol APLocationSearchResultsDelegate: class {
    
    func locationSearcherDidReturnResults(results:[MKMapItem])
}

class APLocationSearcher: NSObject {
    
    
    weak var delegate: APLocationSearchResultsDelegate?
    
    func searchLocationWithText(searchText:String) -> Void {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText
        
        //request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            for mapItem in response.mapItems
            {
                let placeMark = mapItem.placemark
                NSLog("mapItem", "")
            }
            self.delegate?.locationSearcherDidReturnResults(results: response.mapItems)
            
        }
    }
}

extension APLocationSearcher:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        self.searchLocationWithText(searchText: "Riga")
        
        return true
    }
}
