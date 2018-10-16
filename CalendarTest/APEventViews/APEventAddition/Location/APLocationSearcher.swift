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
    
    func locationSearcherDidReturnResults(results:[APLocationResult])
}

class APLocationSearcher: NSObject {
    
    
    let request = MKLocalSearchRequest()
    var search:MKLocalSearch?
    
    var lastSearchedCoordinateRegion:MKCoordinateRegion?
    
    override init() {
        super.init()
        
        search = MKLocalSearch(request: request)
    }
    
    
    weak var delegate: APLocationSearchResultsDelegate?
    
    
    func searchLocationWithText(searchText:String) -> Void {
        
        if searchText.count == 0 {
            
            search!.cancel()
            self.delegate?.locationSearcherDidReturnResults(results: [])
            return;
        }
        
        request.naturalLanguageQuery = searchText
        
        if lastSearchedCoordinateRegion != nil {
            
            request.region = lastSearchedCoordinateRegion!
        }
        search?.cancel()
        search = MKLocalSearch(request: request)
        
        search!.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.lastSearchedCoordinateRegion = response.boundingRegion
            
            var locationResults = [APLocationResult]()
            
            for mapItem in response.mapItems
            {
                let placeMark:MKPlacemark = mapItem.placemark
                let locationResult:APLocationResult = APLocationResult.init()
                var name = ""
                var detail = ""
                
                if let placeMarkName = placeMark.addressDictionary?["Name"] as? String {
                    name = placeMarkName
                }
                
                if let addressList = placeMark.addressDictionary?["FormattedAddressLines"] as? [String] {
                    detail =  addressList.joined(separator: ", ")
                }
                
                locationResult.title = name;
                locationResult.subTitle = detail
                locationResults.append(locationResult)
            }
            
            self.delegate?.locationSearcherDidReturnResults(results: locationResults)
            
        }
    }
}

extension APLocationSearcher:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        self.searchLocationWithText(searchText: "airport")
        
        return true
    }
}
