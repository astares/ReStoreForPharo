"
ReStore
©2019 John Aspinall
https://github.com/rko281/ReStoreForDolphin
https://github.com/rko281/ReStoreForPharo
"
Class {
	#name : #SSWSQLServerDialect,
	#superclass : #SSWSQLDialect,
	#category : #'SSW ReStore SQL Entities'
}

{ #category : #constants }
SSWSQLServerDialect class >> dbmsName [

	^'MICROSOFT SQL SERVER' 
]

{ #category : #datatypes }
SSWSQLServerDialect >> boolean [

	^'BIT'
]

{ #category : #testing }
SSWSQLServerDialect >> canDescribeParameters [

	"Appears to be supported by the native ODBC driver, but flaky (doesn't work with > 1 param?), so let's act as if it doesn't work"

	^false
]

{ #category : #constants }
SSWSQLServerDialect >> cursorType [

	^#keysetDriven
]

{ #category : #constants }
SSWSQLServerDialect >> dateAndTimeFormat [

	"The format for DateAndTImes when expressed as Strings"

	^'yyyy-MM-dd HH:mm:ssfff'
]

{ #category : #datatypes }
SSWSQLServerDialect >> datetime [

	^'DATETIME2'
]

{ #category : #datatypes }
SSWSQLServerDialect >> datetimeWithResolution [

	^'DATETIME2(<1p>)'
]

{ #category : #constants }
SSWSQLServerDialect >> defaultMaxColumnNameLength [

	^128
]

{ #category : #constants }
SSWSQLServerDialect >> defaultMaxTableNameLength [

	^128
]

{ #category : #constants }
SSWSQLServerDialect >> dialectSpecificFunctions [

	^Dictionary new

		"Numeric functions"
		at: #rounded put: 'ROUND(%1,0)' asSQLFunctionIntegerResult;

		"String functions"
		at: #, put: '(%1 + %2)' asSQLFunction;
		at: #leftString: put: 'LEFT(%1,%2)' asSQLFunction;
		at: #rightString: put: 'RIGHT(%1,%2)' asSQLFunction;
		at: #asciiValue put: 'ASCII(%1)' asSQLFunctionIntegerResult;
		at: #indexOfSubCollection: put: 'CHARINDEX(%2,%1)' asSQLFunctionIntegerResult;
		at: #midString:from: put: 'SUBSTRING(%1,%3,%2)' asSQLFunction;
		
		"Date functions"
		at: #addDays: put: 'DATEADD(''d'',%2,%1)' asSQLFunction;
		at: #addMonths: put: 'DATEADD(''m'',%2,%1)' asSQLFunction;
		at: #addYears: put: 'DATEADD(''yyyy'',%2,%1)' asSQLFunction;
		at: #dayOfMonth put: 'DATEPART(''d'',%1)' asSQLFunctionIntegerResult;
		at: #monthIndex put: 'DATEPART(''m'',%1)' asSQLFunctionIntegerResult;
		at: #year put: 'DATEPART(''yyyy'',%1)'asSQLFunctionIntegerResult;

		"Logical functions"
		at: #ifNil: put: 'ISNULL(%1,%2)' asSQLFunction;
		at: #ifNull: put: 'ISNULL(%1,%2)' asSQLFunction;

		yourself
]

{ #category : #datatypes }
SSWSQLServerDialect >> double [

	^'DOUBLE PRECISION'
]

{ #category : #constants }
SSWSQLServerDialect >> identifierQuoteClose [

	"Square brackers are the standard for SQLServer"

	^$]
]

{ #category : #constants }
SSWSQLServerDialect >> identifierQuoteOpen [

	"Square brackers are the standard for SQLServer"

	^$[
]

{ #category : #datatypes }
SSWSQLServerDialect >> integer [

	^'INT'
]

{ #category : #constants }
SSWSQLServerDialect >> maxCharacter [

	^8000
]

{ #category : #maintenance }
SSWSQLServerDialect >> renameField: oldField to: newField in: aReStore [

	aReStore executeSQL: ('EXEC sp_rename ''<1s>.<2s>'', <3p>, ''COLUMN''' expandMacrosWith: newField table name with: oldField name with: newField name)
]

{ #category : #maintenance }
SSWSQLServerDialect >> renameTableNamed: oldName to: newName in: anSSWReStore [

	anSSWReStore executeSQL: ('EXEC sp_rename <1p>,<2p>' expandMacrosWith: oldName with: newName)
]

{ #category : #testing }
SSWSQLServerDialect >> shouldMaskSuccessWithInfo [

	^true
]

{ #category : #testing }
SSWSQLServerDialect >> supportsImplicitTrueConditions [

	^false
]

{ #category : #datatypes }
SSWSQLServerDialect >> unsizedBlob [

	^'varbinary(max)'
]
