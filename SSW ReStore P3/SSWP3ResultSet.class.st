Class {
	#name : 'SSWP3ResultSet',
	#superclass : 'P3Result',
	#instVars : [
		'query',
		'dataStream',
		'columns',
		'statement'
	],
	#category : 'SSW ReStore P3',
	#package : 'SSW ReStore P3'
}

{ #category : 'initialize-release' }
SSWP3ResultSet >> close [

	"In Dolphin this closes the result set, leaving the statement open.
	Nothing to do here"
]

{ #category : 'accessing' }
SSWP3ResultSet >> columns [

	^columns
]

{ #category : 'accessing' }
SSWP3ResultSet >> cursorType [

	^#forwardOnly
]

{ #category : 'accessing' }
SSWP3ResultSet >> dataStream [

	^dataStream ifNil: [ dataStream := self data readStream ]
]

{ #category : 'enumerating' }
SSWP3ResultSet >> do: aBlock [

	data do: [ :vals | aBlock value: (self rowWith: vals)]
]

{ #category : 'enumerating' }
SSWP3ResultSet >> first [

	^data isEmpty 
		ifTrue: [nil] 
		ifFalse: [self rowWith: data first]
]

{ #category : 'initialize-release' }
SSWP3ResultSet >> free [

	statement free
]

{ #category : 'enumerating' }
SSWP3ResultSet >> keysAndValuesDo: aBlock [

	data keysAndValuesDo: [ :index :vals | aBlock value: index value: (self rowWith: vals)]
]

{ #category : 'accessing' }
SSWP3ResultSet >> last [

	^data isEmpty 
		ifTrue: [nil] 
		ifFalse: [self rowWith: data last]
]

{ #category : 'enumerating' }
SSWP3ResultSet >> next [

	^self dataStream next ifNotNil: [ :rowData | self rowWith: rowData ]
]

{ #category : 'accessing' }
SSWP3ResultSet >> numRows [

	| stream |
	
	stream := results readStream.
	[ stream atEnd or: [ stream peek isDigit ] ] whileFalse: [ stream next ].

	^stream atEnd 
		ifTrue: [ 0 ]
		ifFalse: [ Integer readFrom: stream ]
]

{ #category : 'accessing' }
SSWP3ResultSet >> position: anInteger [
	
	self dataStream position: anInteger
]

{ #category : 'accessing' }
SSWP3ResultSet >> query [
	^ query
]

{ #category : 'accessing' }
SSWP3ResultSet >> query: anObject [
	query := anObject.
	columns :=  descriptions collect: 
		[ :each | 
		SSWDBCColAttr new 
			name: each fieldName; 
			field:  (query fieldNamed: each fieldName);
			yourself].
]

{ #category : 'accessing' }
SSWP3ResultSet >> readStream [

	^SSWDBReadStream on: self
]

{ #category : 'accessing' }
SSWP3ResultSet >> resetAndFetchFirst [

	self dataStream reset.
	^self next
]

{ #category : 'accessing' }
SSWP3ResultSet >> results [ 
	^self
]

{ #category : 'initialize-release' }
SSWP3ResultSet >> results: rCollection descriptions: dCollection data: dtCollection [

	results := rCollection.
	descriptions := dCollection.
	data := dtCollection
]

{ #category : 'enumerating' }
SSWP3ResultSet >> rowWith: someData [

	^SSWP3Row new
		columns: self columns;
		data: someData;
		yourself
]

{ #category : 'accessing' }
SSWP3ResultSet >> size [

	^self numberOfRecords
]

{ #category : 'accessing' }
SSWP3ResultSet >> species [

	^OrderedCollection
]

{ #category : 'accessing' }
SSWP3ResultSet >> statement [

	^ statement
]

{ #category : 'accessing' }
SSWP3ResultSet >> statement: anObject [

	statement := anObject
]
