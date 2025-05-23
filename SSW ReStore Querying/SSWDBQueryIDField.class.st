"
ReStore
©2019 John Aspinall
https://github.com/rko281/ReStore
"
Class {
	#name : 'SSWDBQueryIDField',
	#superclass : 'SSWDBQueryTableField',
	#category : 'SSW ReStore Querying',
	#package : 'SSW ReStore Querying'
}

{ #category : 'instance creation' }
SSWDBQueryIDField class >> forTable: aDBTable [

	^self forField: aDBTable idField in: aDBTable
]

{ #category : 'evaluating' }
SSWDBQueryIDField >> convertValue: aValue [

	"Lookup/create the persistent object with this ID"

	^aValue isNil 
		ifTrue: [nil]
		ifFalse: [self table reStore deferredObjectOfClass: self table instanceClass withID: aValue]
]
