Class {
	#name : 'SSWMySQLStatement',
	#superclass : 'MySQLDriverStatement',
	#traits : 'SSWReStoreDBStatement',
	#classTraits : 'SSWReStoreDBStatement classTrait',
	#category : 'SSW ReStore MySQL',
	#package : 'SSW ReStore MySQL'
}

{ #category : 'initialize-release' }
SSWMySQLStatement >> adoptResultSet: anSSWMySQLResultSet [

	rsContext := anSSWMySQLResultSet 
]

{ #category : 'initialize-release' }
SSWMySQLStatement >> cursorType: aSymbol [

	self cursoredFetch: aSymbol notNil
]

{ #category : 'initialize-release' }
SSWMySQLStatement >> cursoredFetch: aBoolean [ 

	"Set a default fetchSize"
	(aBoolean and: [ fetchSize isNil ]) ifTrue: [ 	fetchSize := 10 ].

	super cursoredFetch: aBoolean
]

{ #category : 'accessing' }
SSWMySQLStatement >> executeCommandClass [
	^SSWMySQLCommandExecute
]

{ #category : 'accessing' }
SSWMySQLStatement >> fetchCommandClass [
	^SSWMySQLCommandFetch
]

{ #category : 'initialize-release' }
SSWMySQLStatement >> free [

	stmtId isNil ifFalse: 
		[super close.
		stmtId := nil]
]

{ #category : 'testing' }
SSWMySQLStatement >> isFreed [ 

	^stmtId isNil
]

{ #category : 'accessing' }
SSWMySQLStatement >> parent [

	^driver
]

{ #category : 'accessing' }
SSWMySQLStatement >> valueAt: anIndex put: anObject [
	(params at: anIndex) bindValue: anObject reStoreValue
]

{ #category : 'accessing' }
SSWMySQLStatement >> values [
	^ params ifNil: [ #()] ifNotNil: [ params collect: [ :each | each value ] ]
]

{ #category : 'accessing' }
SSWMySQLStatement >> values: aCollection [

	params := OrderedCollection new: aCollection size.
	aCollection do: [ :each | self addBinding: each reStoreValue forSSWMySQL]
]
