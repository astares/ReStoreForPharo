"
ReStore
©2019 John Aspinall
https://github.com/rko281/ReStore
"
Class {
	#name : 'SSWReStoreNonRelatedDependentOwnedOrderedCollectionTest',
	#superclass : 'SSWReStoreNonRelatedOwnedOrderedCollectionTest',
	#category : 'SSW ReStore Tests',
	#package : 'SSW ReStore Tests'
}

{ #category : 'helpers' }
SSWReStoreNonRelatedDependentOwnedOrderedCollectionTest >> _testComponentExistenceOnDependency: component [

	"Private - collection is dependent at this level, so replaced/removed/cascade-deleted component should no longer exist"

	self assert: (component _dbProxyIn: reStore ifNone: [nil]) isNil.

	reStore simulateReconnect.
	self assert: ((component class storedInstancesIn: reStore) detect: [ :each | each name = component name] ifNone: [nil]) isNil
]

{ #category : 'accessing' }
SSWReStoreNonRelatedDependentOwnedOrderedCollectionTest >> componentDefinition [

	^OrderedCollection of: GenericOwnedTest dependent unrelated owner: #owner
]
