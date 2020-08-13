- IN

```
curl -fsL 'https://kotlinlang.org/docs/reference/native/objc_interop.html#mappings' -o test.html
```

- CMD
  - 型マッピング的なものをあつめる

```
$ cat test.html | pup '.typo-table' | teip -Gog '\s(id|class|href).*?(?=>)' -- sed 's/.//g' | grep -vP '<code>|</code>|<a>|</a>' | html2 | grep -P '/html/body/table/(thead|tbody)/tr/(th|td)'|ruby -F -anle 'p case $F[1];when nil; "-";else;$F[1..$F.size-1].join("うんこ") end' | xargs -n4 | sed 's/ /\t/g' | sed 's/うんこ/ /g'
```

- OUT

```
Kotlin	Swift	Objective-C	Notes
class	class	@interface	note
interface	protocol	@protocol	-
constructor / create	Initializer	Initializer	note
Property	Property	Property	note note
Method	Method	Method	note note
@Throws	throws	error:(NSError**)error	note
Extension	Extension	Category member	note
companion member <-	Class method or property	Class method or property	-
null	nil	nil	-
Singleton	Singleton()	[Singleton singleton]	note
Primitive type	Primitive type / NSNumber	-	note
Unit return type	Void	void	-
String	String	NSString	-
String	NSMutableString	NSMutableString	note
List	Array	NSArray	-
MutableList	NSMutableArray	NSMutableArray	-
Set	Set	NSSet	-
MutableSet	NSMutableSet	NSMutableSet	note
Map	Dictionary	NSDictionary	-
MutableMap	NSMutableDictionary	NSMutableDictionary	note
Function type	Function type	Block pointer type	note
Suspend functions	Unsupported	Unsupported	note
Inline classes	Unsupported	Unsupported	note
```
