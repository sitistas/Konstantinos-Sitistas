Version 0.1 of Greek Language by Konstantinos Sitistas begins here.

"To make Greek the language of play."

[Για την έκδοση 10.2.0 του Inform 7 - Glulx μόνο]

Use authorial modesty.

Volume 1 - Settings

[A language extension is required to set the following variable correctly:]

The language of play is the Greek language.

[The following only needs to be done for inflected languages which distinguish
the genders -- which is why English doesn't do it.]

An object has a grammatical gender.

[Inform initialises this property sensibly. We can easily check the results:

	When play begins:
		repeat with T running through things:
			say "[T] has [grammatical gender of T]."

By default, if Inform can't see any reason to choose a particular gender,
it will use neuter.]

The grammatical gender of a woman is usually feminine gender.
[ The grammatical gender of an object is usually neuter gender. ]

A thing can be female.
A room can be female.
A room can be plural-named or singular-named.

A grammatical case is a kind of value. The grammatical cases are ονομαστική and αιτιατική.

[TODO: Now we define any unusual tenses we want to support. Inform allows up to 7
tenses, and it requires tenses 1 to 5 to be present, past, perfect, past
perfect, and future; English stops there, but two slots are left free for
other languages to create. ]

[It's customary to define a constant so that I6 code can conditionally compile
if we're using this extension, though nothing in the I7 compiler needs it.]

Include (-
Constant LIBRARY_GREEK; ! For dependency checking.
-)

Include (-
[ TextStartsWithAVowel txt  cp p letter result;
	if (txt == 0) return 0;
	cp = txt-->0; p == TEXT_TY_Temporarily_Transmute(txt);
	letter = BlkValueRead(txt, 0);
	! If the text is empty, letter will be 0 and the function will return false, as expected.
	if (IsAnA(letter) || IsAnE(letter) || IsAnI(letter) || IsAnO(letter) || IsAnU(letter) || letter == 'h' or 'H' || letter == 'η' or 'Η' or 'ή' or 'Ή' || letter == 'ω' or 'Ω' or 'ώ' or 'Ώ') {
		result = true;
	} else {
		result = false;
	}
	TEXT_TY_Untransmute(txt, p, cp);
	return result;
];
-)

To decide whether (T - a text) starts with a vowel:
	(- (TextStartsWithAVowel({-by-reference:T})) -)


[ Part 1.1 SR Hack - Greek Bibliographical Data (in place of Section 7 - Unindexed Standard Rules variables in Standard Rules)

[ TODO: Does it work? ]
[ Check with:
Section 3.5.1 - The bibliographical data - Unindexed (in place of Section SR2/6a - Unindexed Standard Rules variables - Unindexed in Standard Rules by Graham Nelson) ]
The story title, the story author, the story headline, the story genre and the story description are text variables. [*****]
The release number and the story creation year are number variables. [**]

The release number is usually 1.
The story headline is usually "Ένα διαδραστικό μυθιστόρημα".
The story genre is usually "Ιστορία". ]

Part 1.2 - Other Tricks

Carry out looking (this is the greek room description heading rule):
	say bold type;
	if the visibility level count is 0:
		begin the printing the name of a dark room activity;
		if handling the printing the name of a dark room activity:
			say "Σκότος" (A);
		end the printing the name of a dark room activity;
	otherwise if the visibility ceiling is the location:
		johan mode "[visibility ceiling]";
	otherwise:
		say "[The visibility ceiling]";
	say roman type;
	let intermediate level be the visibility-holder of the actor;
	repeat with intermediate level count running from 2 to the visibility level count:
		if the intermediate level is a supporter or the intermediate level is an animal:
			say " (σχετικά με [the intermediate level])" (B);
			[ TODO: Check translation from Spanish ]
		otherwise:
			say " (στο [the intermediate level])" (C);
		let the intermediate level be the visibility-holder of the intermediate level;
	say line break;
	say run paragraph on with special look spacing.

The greek room description heading rule is listed instead of the room description heading rule in the carry out looking rules.

To johan mode (T - text):
	let X be the number of words in T;
	say word number 1 in T in sentence case;
	repeat with counter running from 2 to X:
		say " [word number counter in T]".

Section 3 - Greek People (in place of Section 11 - People in Standard Rules by Graham Nelson)

A person can be female or male. A person is usually male.
A person can be neuter. A person is usually not neuter.

A person has a number called carrying capacity.
The carrying capacity of a person is usually 100.

A person can be transparent. A person is always transparent.

The yourself is an undescribed person. The yourself is proper-named.

The yourself is privately-named.

Understand "your former self" or "my former self" or "former self" or
	"former" as yourself when the player is not yourself.

Understand "ο πρώην εαυτός σου" or "ο πρώην εαυτός μου" or "πρώην εαυτός" or "πρώην" as yourself when the player is not yourself.

[The description of yourself is usually "As good-looking as ever."]

The description of yourself is usually "Στις ομορφιές σου όπως πάντα"

The yourself object is accessible to Inter as "selfobj".

Volume 2 - Language

Part 2.1 - Determiners

Chapter 2.1.1 - Articles

To say ο/του/τον/οι/των/τους/η/της/την/τη/τις/το/τα (O - object):
	say "[the O]".

To say ένας/μία/ένα/ενός/έναν/μίας (O - object):[Το αόριστο άρθρο δεν έχει πληθυντικό στα ελληνικά]
	say "[a O]".

To say Ο/Του/Τον/Οι/Των/Τους/Η/Της/Την/Τη/Τις/Το/Τα (O - object):
	say "[The O]".

To say Ένας/Μία/Ένα/Ενός/Έναν/Μίας (O - object):
	say "[A O]".

To say στον/στο/στην/στη/στο/στους/στις/στα (O - object):
	if O is plural-named:
		if O is male:
			say "στους [O]";
		else if O is female:
			say "στις [O]";
		else:
			say "στα [O]";
	else if O is male:
		if "[O]" starts with a vowel:
			say "στον [O]";
		else:
			say "στο [O]";
	else if O is female:
		if "[O]" starts with a vowel:
			say "στην [O]";
		else:
			say "στη [O]";
	else:
		say "στο [O]".


Include [preform](-
language Greek

<definite-article-table> ::=
	ο η το οι οι τα			|
	τον/το την/τη το τους τις τα


<indefinite-article-table> ::=
	ένας μία/μια ένα κάποιοι κάποιες κάποια		|
	έναν/ένα μία/μια ένα κάποιους κάποιες κάποια

[ <definite-article> ::=
	/b/ le/l' |				[singular, masculine]
	/c/ la/l' |				[singular, feminine]
	/e/ les					[plural, masculine (by default)]

<np-relative-phrase-implicit> ::=
	/a/ porté/portée/portés/portées |				[replacing "worn" in English]
	/b/ tenu/tenue/tenus/tenues |			["carried"]
	/d/ ici					["here"]

<implicit-player-relationship> ::=
	/a/ porté/portée/portés/portées |
	/b/ tenu/tenue/tenus/tenues ]

-) in the Preform grammar.


Include (-
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 2;
! English has two:
! 0 = starting with a consonant
! 1 = starting with a vowel

! Greek has also two:
! 0 = starting with a consonant, except κ,π,τ,ξ,ψ or dipthongs γκ, μπ, ντ, τσ, τζ
! 1 = starting with a vowel, or the exceptions above

[ LanguageContraction text;
	if (IsAnA(text->0) || IsAnE(text->0) || IsAnI(text->0) || IsAnO(text->0) || IsAnU(text->0) || text->0 == 'h' or 'H' or 'η' or 'Η' or 'ή' or 'Ή' or 'ω' or 'Ω' or 'ώ' or 'Ώ' or 'κ' or 'Κ' or 'π' or 'Π' or 'τ' or 'Τ' or 'ξ' or 'Ξ' or 'ψ' or 'Ψ') return 1;
    ! TODO: Να προστεθούν οι δίφθογγοι γκ, μπ, ντ, τσ, τζ
	return 0;
];

Array LanguageArticles -->

!   Contraction form 0:     Contraction form 1:
!   Cdef   Def    Indef     Cdef   Def    Indef

	"Ο "   "ο "   "ένας "   "Ο "   "ο "   "ένας "		! 0: masc sing
	"Η "   "η "   "μία "    "Η "   "η "   "μία "		! 1: femi sing
	"Το "  "το "  "ένα "    "Το "  "το "  "ένα "		! 2: neut sing
	"Οι "  "οι "  "κάποιοι ""Οι "  "οι "  "κάποιοι "	! 3: masc plur
	"Οι "  "οι "  "κάποιες ""Οι "  "οι "  "κάποιες "	! 4: femi plur
	"Τα "  "τα "  "κάποια " "Τα "  "τα "  "κάποια ";	! 5: neut plur

			!             a           i
			!             s     p     s     p
			!             m f n m f n m f n m f n

Array LanguageGNAsToArticles --> 0 1 2 3 4 5 0 1 2 3 4 5;


-) replacing "Articles".

Chapter 2.1.2 - Numbers

Include [preform](-
language Greek

<cardinal-number-in-words> ::=
	μηδέν |
	ένα |
	δύο |
	τρία |
	τέσσερα |
	πέντε |
	έξι |
	επτά |
	οκτώ |
	εννέα |
	δέκα |
	έντεκα |
	δώδεκα

<ordinal-number-in-words> ::=
	μηδενικός/μηδενική/μηδενικό |
	πρώτος/πρώτη/πρώτο |
	δεύτερος/δεύτερη/δεύτερο |
	τρίτος/τρίτη/τρίτο |
	τέταρτος/τέταρτη/τέταρτο |
	πέμπτος/πέμπτη/πέμπτο |
	έκτος/έκτη/έκτο |
	έβδομος/έβδομη/έβδομο |
	όγδοος/όγδοη/όγδοο |
	ένατος/ένατη/ένατο |
	δέκατος/δέκατη/δέκατο |
	ενδέκατος/ενδέκατη/ενδέκατο |
	δωδέκατος/δωδέκατη/δωδέκατο
-) in the Preform grammar.

Include (-
Array LanguageNumbers table
    'ένα' 1 'δύο' 2 'τρία' 3 'τέσσερα' 4 'πέντε' 5
    'έξι' 6 'επτά' 7 'οκτώ' 8 'εννέα' 9 'δέκα' 10
    'έντεκα' 11 'δώδεκα' 12 'δεκατρία' 13 'δεκατέσσερα' 14 'δεκαπέντε' 15
    'δεκαέξι' 16 'δεκαεπτά' 17 'δεκαοκτώ' 18 'δεκαεννέα' 19 'είκοσι' 20
    'είκοσι ένα' 21 'είκοσι δύο' 22 'είκοσι τρία' 23 'είκοσι τέσσερα' 24
	'είκοσι πέντε' 25 'είκοσι έξι' 26 'είκοσι επτά' 27 'είκοσι οκτώ' 28
	'είκοσι εννέα' 29 'τριάντα' 30 'μία' 1
;
! TODO: Make the following work
! [ LanguageNumber n f;
!     if (n == 0) {
! 		print "μηδέν";
! 		rfalse;
! 	}

!     if (n < 0) {
!         print "μείον ";
!         n = -n;
!     }

!     if (n >= 1000) {
!         if (n / 1000 == 1) {  ! Αν είναι ακριβώς 1000
!             print "χίλια";
!         } else {  ! Αν είναι μεγαλύτερο από 1000
!             LanguageNumber(n / 1000, false);
!             print " χιλιάδες";
!         }
!         n = n % 1000;
!         if (n) {
!             print " ";
!         } else {
!             return;
!         }
!     }
! ];
-) replacing "Numbers".

Part 2.2 - Nouns

Chapter 2.2.1 - Pronouns and possessives for the player

[The adaptive text viewpoint is the viewpoint of the player when we are
writing response texts which need to work in any tense, person or number.
For example, English uses first person plural, so we write "[We] [look] up."
as a message which could come out as "I look up", "you look up", "he looks up",
and so on. It's "[We]" not "[You]" because the adaptive text viewpoint is
first person plural, not second person singular.

The reason for choosing this in English was that all the pronouns and
possessive adjectives we needed happened to be different for first person
plural: we, us, ours, ourselves, our. We also need these pronouns to be
other than third-person, so that we can define [they], [them] and so on
to refer to objects and not the player. So in practice there are only four
possible choices a language extension can make:

	first person singular (in English: I, me, mine, myself, my)
	second person plural (in English: you, you, yours, yourself, your)
	first person singular (in English: we, us, ours, ourselves, our)
	second person plural (in English: you, you, yours, yourself, your)

What shall we choose for French? We may as well use second person singular,
giving us tu, te, le tien/la tienne, te, ton. There are two complications.
Firstly we need indirect objects as well as direct objects, and although these
are the same in second person (te and te), they're different in third person
(le and lui). We'll call this "[te-lui]" for the same of this demonstration,
which is a bit awkward, but it'll do. Secondly, the reflexive pronoun is also
te, so we'll write that one "[te-se]".

In Greek, we will use first person singular.
]


[ TODO: Check if other pronouns are needed (ο ίδιος, μόνος, τόσος, τέτοιος, όσος, οποιοσδήποτε, ποιος, πόσος, + αόριστες) ]

The adaptive text viewpoint of the Greek language is first person singular.

When play begins (this is the initialise the story viewpoint rule):
	now the story viewpoint is the second person singular.

To say εγώ:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "εγώ";
	else if the story viewpoint is second person singular:
		say "εσύ";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "αυτός";
		else if the player is female:
			say "αυτή";
		otherwise:
			say "αυτό";
	else if the story viewpoint is first person plural:
		say "εμείς";
	else if the story viewpoint is second person plural:
		say "εσείς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "αυτοί";
		else if the player is female:
			say "αυτές";
		otherwise:
			say "αυτά".

To say Εγώ:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Εγώ";
	else if the story viewpoint is second person singular:
		say "Εσύ";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Αυτός";
		else if the player is female:
			say "Αυτή";
		otherwise:
			say "Αυτό";
	else if the story viewpoint is first person plural:
		say "Εμείς";
	else if the story viewpoint is second person plural:
		say "Εσείς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "Αυτοί";
		else if the player is female:
			say "Αυτές";
		otherwise:
			say "Αυτά".

To say εμένα:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "εμένα";
	else if the story viewpoint is second person singular:
		say "εσένα";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "αυτόν";
		else if the player is female:
			say "αυτή";
		otherwise:
			say "αυτό";
	else if the story viewpoint is first person plural:
		say "εμάς";
	else if the story viewpoint is second person plural:
		say "εσάς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "αυτούς";
		else if the player is female:
			say "αυτές";
		otherwise:
			say "αυτά".

To say Εμένα:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Εμένα";
	else if the story viewpoint is second person singular:
		say "Εσένα";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Αυτόν";
		else if the player is female:
			say "Αυτή";
		otherwise:
			say "Αυτό";
	else if the story viewpoint is first person plural:
		say "Εμάς";
	else if the story viewpoint is second person plural:
		say "Εσάς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "Αυτούς";
		else if the player is female:
			say "Αυτές";
		otherwise:
			say "Αυτά".

To say δικό μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "δικό μου";
	else if the story viewpoint is second person singular:
		say "δικό σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "δικό του";
		else if the player is female:
			say "δικό της";
		otherwise:
			say "δικό του";
	else if the story viewpoint is first person plural:
		say "δικό μας";
	else if the story viewpoint is second person plural:
		say "δικό σας";
	else if the story viewpoint is third person plural:
		say "δικό τους".

To say Δικό μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Δικό μου";
	else if the story viewpoint is second person singular:
		say "Δικό σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Δικό του";
		else if the player is female:
			say "Δικό της";
		otherwise:
			say "Δικό του";
	else if the story viewpoint is first person plural:
		say "Δικό μας";
	else if the story viewpoint is second person plural:
		say "Δικό σας";
	else if the story viewpoint is third person plural:
		say "Δικό τους".

To say τον εαυτό μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "τον εαυτό μου";
	else if the story viewpoint is second person singular:
		say "τον εαυτό σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "τον εαυτό του";
		else if the player is female:
			say "τον εαυτό της";
		otherwise:
			say "τον εαυτό του";
	else if the story viewpoint is first person plural:
		say "τους εαυτούς μας";
	else if the story viewpoint is second person plural:
		say "τους εαυτούς σας";
	else if the story viewpoint is third person plural:
		say "τους εαυτούς τους".

To say Τον εαυτό μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Τον εαυτό μου";
	else if the story viewpoint is second person singular:
		say "Τον εαυτό σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Τον εαυτό του";
		else if the player is female:
			say "Τον εαυτό της";
		otherwise:
			say "Τον εαυτό του";
	else if the story viewpoint is first person plural:
		say "Τους εαυτούς μας";
	else if the story viewpoint is second person plural:
		say "Τους εαυτούς σας";
	else if the story viewpoint is third person plural:
		say "Τους εαυτούς τους".

To say μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "μου";
	else if the story viewpoint is second person singular:
		say "σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "του";
		else if the player is female:
			say "της";
		otherwise:
			say "του";
	else if the story viewpoint is first person plural:
		say "μας";
	else if the story viewpoint is second person plural:
		say "σας";
	else if the story viewpoint is third person plural:
		say "τους".

To say Μου:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Μου";
	else if the story viewpoint is second person singular:
		say "Σου";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Του";
		else if the player is female:
			say "Της";
		otherwise:
			say "Του";
	else if the story viewpoint is first person plural:
		say "Μας";
	else if the story viewpoint is second person plural:
		say "Σας";
	else if the story viewpoint is third person plural:
		say "Τους".


[ TODO: figure this out ]
[ To say μου/σου/του/της/τους (O - an object):
	if O is plural-named:
		say "[O] τους";
	otherwise:
		if O is male:
			say "[O] " ]

[ TODO: Continue from here based on French]
Chapter 2.2.2 - Pronouns and possessives for other objects


[These are similar, but easier. They are named from the third-person viewpoint with the same number as the adaptive text viewpoint; so in the case of French, we'll go with third person singular. We define:]

[ TODO: Translate and continue the following, based on English ]

To say those:
	say those in the αιτιατική.

To say Those:
	say Those in the ονομαστική.


To say those in (case - grammatical case):
	if the case is nominative:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "those";
		otherwise if the item is the player:
			say "[εγώ]";
		otherwise if the item is a male person and item is not neuter:
			say "he";
		otherwise if the item is a female person and item is not neuter:
			say "she";
		otherwise:
			say "that";

Chapter 2.2.3 - Directions


[ Understand "βοράς" as North.
Understand "νότος" as South.
Understand "ανατολή" as East.
Understand "δύση" as West. ]


North translates into Greek as ο βοράς.
South translates into Greek as η νότος.
East translates into Greek as η ανατολή.
West translates into Greek as η δύση.
Northeast translates into Greek as βορειοανατολικά.
Southwest translates into Greek as νοτιοδυτικά.
Southeast translates into Greek as νοτιοανατολικά.
Northwest translates into Greek as βορειοδυτικά.
Inside translates into Greek as μέσα.
Outside translates into Greek as έξω.
Up translates into Greek as πάνω.
Down translates into Greek as κάτω.

Understand "ανατολικά" or "ανατολικα" or "α" or "ανατολική" as ανατολή.
Understand "βόρεια" or "βορεια" or "β" as βοράς.
Understand "δυτικά" or "δυτικα" or "δ" as δύση.
Understand "νότια" or "νοτια" or "νό" as νότος.
Understand "να" as νοτιοανατολικά.
Understand "νδ" as νοτιοδυτικά.
Understand "βα" as βορειοανατολικά.
Understand "βδ" as βορειοδυτικά.
Understand "μ" or "μεσα" or "εσωτερικά" or "εσωτερικα" as μέσα.
Understand "εξωτερικά" as έξω.

[TODO: Figure that out
Understand "Η περιγραφή [του]" as The description of.]

Chapter 2.2.4 - Kinds

Section 2.2.4.1 - In the Standard Rules

An object translates into Greek as ένα αντικείμενο.
A room translates into Greek as ένα δωμάτιο.
A thing translates into Greek as ένα πράγμα.
A door translates into Greek as μια πόρτα.
A container translates into Greek as ένα κιβώτιο.
A vehicle translates into Greek as ένα όχημα.
A player's holdall translates into Greek as μια τσάντα του παίκτη.
A supporter translates into Greek as ένας στήριγμα.
A backdrop translates into Greek as ένα παρασκήνιο. The plural of παρασκήνιο is παρασκήνια. [TODO: check translation]
A person translates into Greek as ένα άτομο.
A man translates into Greek as άντρας. The plural of άντρας is άντρες.
[ TODO: Ask Graham if the indefinite article is needed. If I use it as:  A man translates into Greek as άντρας. I receive: printed plural name: "άντρες"

If I use it as: A man translates into Greek as **ένας** άντρας. then I receive: printed plural name: "ένας άντρες" (which is incorrect)]

A woman translates into Greek as μια γυναίκα.
An animal translates into Greek as ένα ζώο.
A device translates into Greek as μια συσκευή.
A direction translates into Greek as μια κατεύθυνση.
A region translates into Greek as μια περιοχή.

A number translates into Greek as ένας αριθμός.
A real number translates into Greek as ένας πραγματικός αριθμός.
A time translates into Greek as μια ώρα.
[ TODO: Find correct translation for the following, fix it in the documentation as well ]
A truth state translates into Greek as μια αλήθεια.
A text translates into Greek as ένα κείμενο.
A unicode character translates into Greek as ένας χαρακτήρας unicode.
A snippet translates into Greek as ένα απόσπασμα.
A stored action translates into Greek as μια αποθηκευμένη ενέργεια.
A scene translates into Greek as μια σκηνή.
A command parser error translates into Greek as ένα σφάλμα αναλυτή εντολών.
A use option translates into Greek as μια επιλογή χρήσης.
A response translates into Greek as μια απάντηση.
A verb translates into Greek as ένα ρήμα.
A table name translates into Greek as ένα όνομα πίνακα.
An equation name translates into Greek as ένα όνομα εξίσωσης.
A rulebook outcome translates into Greek as ένα αποτέλεσμα κανόνων.
An action name translates into Greek as ένα όνομα ενέργειας.
A figure name translates into Greek as ένα όνομα μορφής.
A sound name translates into Greek as ένα όνομα ήχου.
An external file translates into Greek as ένα εξωτερικό αρχείο.

[ TODO: Test and check the following tenses ]
[ TODO: Ask Graham about the tenses ]
Grammatical tense translates into Greek as γραμματικός χρόνος.
Present tense translates into Greek as ο ενεστώτας.
Future tense translates into Greek as ο μέλλοντας.
Past tense translates into Greek as ο παρελθοντικός.
Perfect tense translates into Greek as ο αόριστος.
Past perfect tense translates into Greek as ο υπερσυντέλικος.

Narrative viewpoint translates into Greek as αφηγηματική σκοπιά.
First person singular translates into Greek as το πρώτο ενικό πρόσωπο.
Second person singular translates into Greek as το δεύτερο ενικό πρόσωπο.
Third person singular translates into Greek as το τρίτο ενικό πρόσωπο.
First person plural translates into Greek as το πρώτο πληθυντικό πρόσωπο.
Second person plural translates into Greek as το δεύτερο πληθυντικό πρόσωπο.
Third person plural translates into Greek as το τρίτο πληθυντικό πρόσωπο.

Grammatical gender translates into Greek as γραμματικό γένος.
Masculine gender translates into Greek as το αρσενικό γένος.
Feminine gender translates into Greek as το θηλυκό γένος.
Neuter gender translates into Greek as το ουδέτερο γένος.


[ Translation of the index descriptions ]
[ TODO: Test the examples given in the specifications. ]

The specification of δωμάτιο is "Αντιπροσωπεύει γεωγραφικές τοποθεσίες, τόσο εσωτερικές όσο και εξωτερικές, οι οποίες δεν είναι απαραίτητα χώροι μέσα σε ένα κτίριο. Ένας παίκτης που βρίσκεται σε ένα δωμάτιο δεν μπορεί, κατά κανόνα, να αντιληφθεί ή να αλληλεπιδράσει με οτιδήποτε σε διαφορετικό δωμάτιο. Τα δωμάτια είναι διατεταγμένα σε έναν χάρτη.".

The specification of περιοχή is "Αντιπροσωπεύει μια ευρύτερη περιοχή από ένα μόνο δωμάτιο και επιτρέπει την εφαρμογή κανόνων σε ολόκληρη μια γεωγραφική περιοχή. Κάθε περιοχή μπορεί να περιέχει πολλά δωμάτια, και οι περιοχές μπορούν ακόμη και να βρίσκονται η μία μέσα στην άλλη, αν και δεν μπορούν να αλληλεπικαλύπτονται με άλλον τρόπο. Για παράδειγμα, το δωμάτιο 'Ιταλικό Παλάτι' μπορεί να βρίσκεται μέσα στην περιοχή '13ος Δήμος', η οποία με τη σειρά της βρίσκεται μέσα στην περιοχή Παρίσι. Οι περιοχές είναι χρήσιμες κυρίως όταν ο κόσμος είναι μεγάλος και είναι προαιρετικές.".

The specification of πράγμα is "Αντιπροσωπεύει οτιδήποτε διαδραστικό στον  κόσμο που δεν είναι δωμάτιο. Άνθρωποι, στοιχεία του τοπίου, έπιπλα, πόρτες και ξεχασμένες ομπρέλες μπορεί να είναι παραδείγματα, όπως και πιο απρόσμενα πράγματα, όπως ο ήχος του κελαηδίσματος των πουλιών ή μια δέσμη ηλιακού φωτός.".

The specification of κατεύθυνση is "Αντιπροσωπεύει μια κατεύθυνση κίνησης, όπως βορειοανατολικά ή κάτω. Εμφανίζονται πάντα σε αντίθετα, ταιριαστά ζεύγη: για παράδειγμα, βορειοανατολικά και νοτιοδυτικά, κάτω και πάνω."

The specification of πόρτα is "Αντιπροσωπεύει ένα πέρασμα που ενώνει δύο δωμάτια, συνήθως μια πόρτα ή μια πύλη, αλλά μερικές φορές μια σανίδα-γέφυρα, μια τσουλήθρα ή ένα άνοιγμα καταπακτής. Συνήθως είναι ορατή και λειτουργική και από τις δύο πλευρές (για παράδειγμα, αν γράψετε 'Η μπλε πόρτα είναι ανατολικά της Αίθουσας Χορού και δυτικά του Κήπου.'), αλλά μερικές φορές είναι μονόδρομη (για παράδειγμα, αν γράψετε 'Ανατολικά της Αίθουσας Χορού βρίσκεται η μεγάλη τσουλήθρα. Μέσα από τη μεγάλη τσουλήθρα είναι το κελάρι.').".

The specification of κιβώτιο is "Αντιπροσωπεύει κάτι μέσα στο οποίο μπορούν να τοποθετηθούν φορητά αντικείμενα, όπως ένα ξύλινο σεντούκι ή μια τσάντα. Κάτι με πραγματικά μεγάλο και ακίνητο εσωτερικό χώρο, όπως η Αίθουσα Άλμπερτ, είναι προτιμότερο να θεωρηθεί δωμάτιο αντί για κιβώτιο.".

The specification of στήριγμα is "Αντιπροσωπεύει μια επιφάνεια πάνω στην οποία μπορούν να τοποθετηθούν αντικείμενα, όπως ένα τραπέζι.".

The specification of παρασκήνιο is "Αντιπροσωπεύει μια πτυχή του τοπίου ή της αρχιτεκτονικής που εκτείνεται σε περισσότερα από ένα δωμάτια: για παράδειγμα, ένα ρέμα, ο ουρανός ή ένα μακρύ χαλί.".

The specification of άτομο is "Παρά το όνομά του, δεν είναι απαραίτητα άνθρωπος, αλλά οποιαδήποτε οντότητα με τις απαραίτητες λειτουργίες για να αλληλεπιδράσει μαζί του".

The specification of άντρας is "Αντιπροσωπεύει έναν άντρα ή αγόρι.".
The specification of γυναίκα is "Αντιπροσωπεύει μια γυναίκα ή κορίτσι.".
The specification of ζώο is "Αντιπροσωπεύει ένα ζώο, ή τουλάχιστον ένα μη ανθρώπινο ζωντανό πλάσμα αρκετά μεγάλο και δυνατό να αλληλεπιδράσει: μια γιγαντιαία παγίδα της Αφροδίτης θα μπορούσε να πληροί τις προϋποθέσεις, αλλά όχι μια περιοχή από λειχήνες.".

The specification of συσκευή is "Αντιπροσωπεύει μια μηχανή ή συσκευή κάποιου είδους που μπορεί να ενεργοποιηθεί ή να απενεργοποιηθεί.".

The specification of όχημα is "Αντιπροσωπεύει ένα κιβώτιο αρκετά μεγάλο για να εισέλθει ένα άτομο, το οποίο μπορεί στη συνέχεια να μετακινείται μεταξύ των δωματίων με την οδηγία του οδηγού. (Αν χρειάζεται μια επιφάνεια στήριξης, δοκιμάστε την επέκταση Rideable Vehicles του Graham Nelson.)".

The specification of τσάντα του παίκτη is "Αντιπροσωπεύει ένα κιβώτιο που μπορεί ο παίκτης να κουβαλάει γύρω του σαν μια τσάντα, μέσα στο οποίο τα περιττά αντικείμενα αποθηκεύονται αυτόματα."

[ TODO: Continue from here with French extension examples ]

Chapter 2.2.5 - Plurals

[ TODO: Continue working on Plurals for Greek. ]

[ Σε αυτό το σημείο, αξίζει να σημειωθεί ότι στα ελληνικά, ο πληθυντικός αριθμός είναι αρκετά πιο πολύπλοκος από τα αγγλικά και τα γαλλικά. Υπάρχουν πολλές κατηγορίες, για αρσενικά, θηλυκά και ουδέτερα, ενώ η κλίση τους κάνει την διαδικασία ακόμα πιο δύσκολη. Ο τονισμός δημιουργεί εκ νέου υποκατηγορίες, δημιουργώντας τα οξύτονα, παροξύτονα & προπαραξότυνα ουστιαστικά. ]

Include [preform](-
language Greek
<singular-noun-to-its-plural> ::=
	... <en-trie-plural-uninflected> |
	... <gr-plural-exceptions> |
	... <gr-plural-by-ending> |
	... <gr-plural-default>

<en-trie-plural-uninflected> ::=


<gr-plural-exceptions> ::=
	μυς			μυς |
	πρέσβης		πρέσβεις |
	πρύτανης	πρυτάνεις |

<gr-plural-by-ending> ::=
	*ας			2ες |			[χάρακας --> χάρακες] [TODO: Add ψαράς --> ψαράδες]
	*ης			1ες	|		[επιβάτης --> επιβάτες]
	*ΗΣ			1ΕΣ	|		[επιβάτης --> επιβάτες]
	*ής			1ές			[μαθητής --> μαθητές]

<gr-plural-default> ::=
	*			0ς

-) in the Preform grammar.

Chapter 2.2.6 - Cases

Chapter 2.2.7 - Times of day
[ TODO: Understand if the following is still relevant ]
[ Include (-
[ LanguageTimeOfDay hours mins i;
    i = hours%12;
    if (i == 0) i = 12;
    if (i < 10) print " ";
    print i, ":", mins/10, mins%10;
    if ((hours/12) > 0) print " μ.μ."; else print " π.μ.";
];
-) replacing "Time". ]

Include [preform](-
language Greek

<am-pm> ::=
	π.μ. |
	μ.μ.

<elapsed-time> ::=
	<cardinal-number> ώρα/ώρες |
	<cardinal-number> λεπτό/λεπτά |
	<cardinal-number> ώρα/ώρες <cardinal-number> λεπτό/λεπτά

-) in the Preform grammar.

Part 2.3 - Adjectives

Chapter 2.3.1 - Ajectives agreement rules

[Adjectives have six forms: neuter singular, neuter plural, masculine singular,
masculine plural, feminine singular, feminine plural. They're constructed
using tries:

	n.s.		(base text unchanged)
	n.p.		base modified by <adjective-to-plural>
	m.s.		base modified by <adjective-to-masculine-singular>
	m.p.		base modified by <adjective-to-masculine-singular>
				then further by <adjective-to-masculine-plural>
	f.s.		base modified by <adjective-to-feminine-singular>
	f.p.		base modified by <adjective-to-feminine-singular>
				then further by <adjective-to-feminine-plural>]

Include [preform](-
language Greek

[ TODO: Change all the following cases to greek, similar to nouns, and add neuter ]

<adjective-to-plural> ::=
	*                0

<adjective-to-masculine-singular> ::=
	*                0

<adjective-to-feminine-singular> ::=
	*                0

<adjective-to-masculine-plural> ::=
	*                0

<adjective-to-feminine-plural> ::=
	*                0

<adjective-to-comparative> ::=
	καλός                                 καλύτερος |
	well                                  better |
	bad                                   worse |
	far                                   farther |
	*e                                    1er |
	*<bcdfghkmlnprstvwxyz>y               1ier |
	*<aeiou><aeiou><bcdfghkmlnprstvxyz>   0er |
	*<aeiou><bcdfghkmlnprstvxyz>          0+er |
	*                                     0er

<adjective-to-superlative> ::=
	good                                  best |
	well                                  best |
	bad                                   worst |
	far                                   farthest |
	*e                                    1est |
	*<bcdfghkmlnprstvwxyz>y               1iest |
	*<aeiou><aeiou><bcdfghkmlnprstvxyz>   0est |
	*<aeiou><bcdfghkmlnprstvxyz>          0+est |
	*                                     0est

<adjective-to-quiddity> ::=
	*ong                            3ength |
	*<bcdfghkmlnprstvwxyz>y         1iness |
	*                               0ness
-) in the Preform grammar.

Chapter 2.3.2 - New adjectives

[ In Greek αναμμένος is an adjective. ]

Part 2.4 - Verbs

Chapter 2.4.1 - Verb conjugations

[Most French verbs "conjugate with avoir": that is, they form tenses like
the perfect using "avoir" as an auxiliary -- "il a donné", he has given. But
a few exceptions "conjugate with être" instead. The cleanest way to handle
this is to give two conjugations: one for the avoir verbs, one for the être
verbs, even those the rules are identical except for two of our tenses.

>--> A small set of verbs conjugates with avoir when used transitively, but
with être when used intransitively:

	entrer, sortir, retourner, rentrer, monter, descendre, passer

Inform doesn't know when it prints a verb whether it's being used transitively
or not, so it has to make a decision: and we're going to conjugate all of these
cases with "avoir". So our present perfect and past perfect forms of these
verbs will be wrong when they're used intransitively. (But of course if they
are being used in Inform source text then they must be transitive anyway; so
this will only affect printed output in games told in the perfect tenses, which
I can't imagine many people will want to do.)]

[>--> Similarly we're going to ignore conjugation with être for verbs when used
reciprocally, e.g., "ils se regardent" (which in some contexts means "they look
at each other").]

[>--> In some cases modern French offers a choice of whether to give verbs
an irregular conjugation or not:

(a) There are two verbs with the infinitive "ressortir": one regular, meaning
	"to come with the jurisdiction of", and one irregular, meaning "to come out
	again" or "to stand out". I think the latter is more likely in IF.

(b) The mostly obsolete verb "vêtir" (to clothe, but "habiller" is far more
	common now) is sometimes irregular, sometimes not. Inform treats it as a
	regular -IR verb.


In Greek, we also need to define "Subjunctive" (υποτακτική) grammatical mood, because of its use with many verbs, such as can, be, could, etc.

However, in most cases, the verb conjugation is the same as the future tense, so we can just replace the word "θα" (will) with the word "να" (to).

]


Include [preform](-
language Greek

[

[ TODO: Change the position of the following ]
Guide on how to use Preform: https://ganelson.github.io/inform/words-module/4-ap.html

Wildcards στην Preform:
 - ...: Non-empty-text
 - ***: Any text
 - ......: matches any non-empty text in which brackets are used in a balanced way — thus they would match "alpha beta gamma" or "alpha (the Greek letter)", but not "alpha (the" or "Greek letter)".
 - ###: Any single word

 Πώς λειτουργεί το Inform Syntax στα ρήματα;

 Όταν λέμε "The verb to flaunt means to wear", λέμε στο Inform ότι το απαρέμφατο του νέρου ρήματος είναι το "flaunt". Το Inform χρησιμοποιεί:
 - 5 γραμματικούς χρόνους: ενεστώτα, αόριστο, παρακείμενο, υπερσυντέλικο και μέλλοντα
 - 3 πρόσωπα
 - 2 αριθμούς
 - 2 "senses" (αλήθεια ή ψέμα)
 - & 2 φωνές (ενεργτικη και παθητική)
 - απαρέφματο
 - μετοχή ενεστώτα
 - μετοχή αορίστου

 Το σύνολο όλων των παραπάνω δημιουργεί ένα δυνητικό σύνολο 123 συνδυασμών του αρχικού ρήματος.

 Η στρατηγική για την ομαδοποίηση των ρημάτων είναι η ακόλουθη:

 1. Χειρισμός των πολύ ανωμάλων ρημάτων (π.χ είμαι, έχω, πληρώ, κ.ά.)
 2. Για όλα τα άλλα ρήματα, προσδιορισμός διαφόρων σετ κλιτών μορφών
 3. Προσπάθεια χρήσης μόνο μίας κλίσης για να επίδειξη χρήσης των τύπων, δηλαδή πώς οι διαφορετικοί τύποι λέξεων αντιστοιχούν στους πιθανούς χρόνους, πρόσωπα, αριθμούς κ.ο.κ.

 Παράδειγμα για τα ελληνικά:

 Ρήμα: Κάνω

 0-1) Βασική μορφή ρήματος: κάνω
 2) Μετοχή ενεστώτα: κάνοντας
 3) Απαρέμφατο: κάνει
 4) "adjoint infinitive": π.χ. "be able to see" - see
 5) 3ο ενικό πρόσωπο ενεστώτα: κάνει
 6) 3ο ενικό πρόσωπο αορίστου: έκανε

Πώς λειτουργεί η δομή Preform για τα ρήματα στα ελληνικά:

<verb-conjugation-instructions>: Ορίζουμε την κατηγορία κλίσης στην οποία ανήκει κάθε ρήμα. Για παράδειγμα, τα ρήματα λύνω, βάφω, κάνω έχουν την ίδια κλίση, ενώ το ρήμα "είμαι" είναι ανώμαλο ρήμα.

Σημείωση: Όπου παρακάτω αναφέρεται μέλλοντας, αναφερόμαστε στον συνοπτικό μέλλοντα.

<gr-"ρήμα ή κατηγορία"-conjugation> ::=
	2	<μετοχή ενεστώτα> |
	3	<απαρέμφατο αορίστου> |
	<gr-"ρήμα ή κατηγορία"-tabulation>

Κλίση ρήματος ή κατηγορίας:
<gr-"ρήμα ή κατηγορία"-tabulation> ::=
	a1+		<gr-ρήμα-ενεστώτας> |
	a1-		άρνηση <gr-ρήμα-ενεστώτας> |
	a2+		<gr-ρήμα-αόριστος> |
	a2-		άρνηση <gr-ρήμα-αόριστος> |
	a3+		<gr-ρήμα-παρακείμενος> 3 |
	a3- 	άρνηση <gr-ρήμα-παρακείμενος> 3 |
	a4+		<gr-ρήμα-υπερσυντέλικος> 3 |
	a4-		άρνηση <gr-ρήμα-υπερσυντέλικος> 3 |
	a5+		<gr-ρήμα-μέλλοντας> |
	a5-		άρνηση <gr-ρήμα-μέλλοντας> |
	p* 		παθητική μορφή ρήματος

Ωστόσο, ο παρακείμενος και ο υπερσυντέλικος σχημαντίζονται με το ρήμα έχω, επομένως η άρνηση καθορίζεται από το βοηθητικό ρήμα έχω, και τα a3+, a3- μπορούν να συγχωνευθούν σε a3(αντίστοιχα και σε a4.)


Τέλος, ακολουθεί η κλίση για κάθε χρόνο, π.χ.:

<gr-be-present> ::=
    είμαι | είσαι | είναι | είμαστε | είστε | είναι

]

[ TODO: Change from imperative to imperfect... ]

<verb-conjugation-instructions> ::=
	είμαι 	<gr-be-conjugation> |
	έχω 	<gr-have-conjugation> |
	μπορώ 	<gr-can-conjugation> |
	μπορώ να ...	<gr-can-auxiliary> |
	κάνω 	<gr-kano-conjugation> |
	λύνω 	<gr-lyno-conjugation> |
	βλέπω 	<gr-vlepo-conjugation> |
	δω 		<gr-na-do-conjugation> |
	πάω 	<gr-na-paw-conjugation> |
	κρατάω 	<gr-kratao-conjugation> |
	χτυπάω 	<gr-xtypao-conjugation> |
	παίρνω 	<gr-pairno-conjugation> |
	πάρω 	<gr-na-paro-conjugation> |
	...		<gr-regular-verb-conjugation>

	[ TODO: αφήνω ή βάζω, στηρίζω, περιέχω, ανοίγω, κλείνω ]


<gr-regular-verb-conjugation> ::=
	2	<gr-trie-present-participle> |
	3 	<gr-trie-past-participle> |
	5	<gr-trie-present-verb-form> |
	6	<gr-trie-past-verb-form> |
	<gr-regular-verb-tabulation>

<gr-regular-verb-tabulation> ::=
	[ TODO: Fill this one ]
	a1+ <gr-regular-verb-present> |
	a1- δεν 1 |
	a2+ <gr-regular-verb-past> |
	a2- δεν 3 |
	a3 (t1 έχω) 3 |
	a4 (t2 έχω) 3 |
	a5+ θα <gr-regular-verb-future> |
	a5- δεν θα <gr-regular-verb-future> |
	[ p* TODO: Προσθήκη της παθητικής φωνής ]



[ TODO: Complete all the following ]
<gr-regular-verb-present> ::=
	1 | κάνεις | κάνει | κάνουμε | κάνετε | κάνουν

<gr-regular-verb-past> ::=
	έκανα | έκανες | έκανε | κάναμε | κάνατε | έκαναν

<gr-regular-verb-future> ::=
	θα κάνω | θα κάνεις | θα κάνει | θα κάνουμε | θα κάνετε | θα κάνουν

<gr-trie-present-participle> ::=
	...		<gr-trie-irregular-present-participle> |
	...		<gr-trie-regular-a-present-participle> |
	[ TODO: Continue the above ]

[ "Είμαι" ]

<gr-be-conjugation> ::=
	2 όντας |
    <gr-be-tabulation>

<gr-be-tabulation> ::=
    a1+ <gr-be-present> |
    a1- δεν <gr-be-present> |
    a2+ <gr-be-past> |
    a2- δεν <gr-be-past> |
    a5+ θα <gr-be-present> |
    a5- δεν θα <gr-be-present>

<gr-be-present> ::=
    είμαι | είσαι | είναι | είμαστε | είστε | είναι

<gr-be-past> ::=
    ήμουν | ήσουν | ήταν | ήμασταν | ήσασταν | ήταν

[ "Έχω" ]

<gr-have-conjugation> ::=
	2 έχοντας |
    <gr-have-tabulation>

<gr-have-tabulation> ::=
    a1+ <gr-have-present> |
    a1- δεν <gr-have-present> |
    a2+ <gr-have-past> |
    a2- δεν <gr-have-past> |
    a5+ θα <gr-have-present> |
    a5- δεν <gr-have-present>

<gr-have-present> ::=
    έχω | έχεις | έχει | έχουμε | έχετε | έχουν

<gr-have-past> ::=
    είχα | είχες | είχε | είχαμε | είχατε | είχαν


[ "Μπορώ" ]

<gr-can-conjugation> ::=
	2	μπορώντας |
	3	μπορέσει |
	<gr-can-tabulation>

<gr-can-tabulation> ::=
    a1+ 	<gr-can-present> |
    a1- 	δεν <gr-can-present> |
    a2+ 	<gr-can-past> |
    a2- 	δεν <gr-can-past> |
	a3		(t1 έχω) 3 |
	a4		(t2 έχω) 3 |
	a5+ 	θα <gr-can-future> |
    a5- 	δεν θα <gr-can-future>

<gr-can-present> ::=
    μπορώ | μπορείς | μπορεί | μπορούμε | μπορείτε | μπορούν

<gr-can-past> ::=
    μπόρεσα | μπόρεσες | μπόρεσε | μπορέσαμε | μπορέσατε | μπόρεσαν

<gr-can-future> ::=
    μπορέσω | μπορέσεις | μπορέσει | μπορέσουμε | μπορέσετε | μπορέσουν


<gr-can-auxiliary> ::=
	[ TODO: Τι χρειάζεται εδώ; ]
	<gr-can-auxiliary-tabulation>

<gr-can-auxiliary-tabulation> ::=
	a1 (t1 μπορώ) να (t1) |
	a2 (t2 μπορώ) να (t1) |
	a5 (t5 μπορώ) να (t1)
	[ TODO: Check / fix the above! ]

[ TODO: Χρειάζεται να δηλωθεί και το πρέπει; ]

[ "Κάνω" ]

<gr-kano-conjugation> ::=
	2	κάνοντας |
	3	κάνει |
	<gr-kano-tabulation>

[ ΣΗΜΑΝΤΙΚΟ: The t1 means present tense; t2 means past tense, and so on ]

<gr-kano-tabulation> ::=
	a1+ <gr-kano-present> |
	a1- δεν <gr-kano-present> |
	a2+ <gr-kano-past> |
	a2- δεν <gr-kano-past> |
	a3 (t1 έχω) 3 |
	a4 (t2 έχω) 3 |
	a5+ θα <gr-kano-present> |
	a5- δεν θα <gr-kano-present>
	[ p* έγινε από  ]

<gr-kano-present> ::=
	1 | κάνεις | κάνει | κάνουμε | κάνετε | κάνουν

<gr-kano-past> ::=
	έκανα | έκανες | έκανε | κάναμε | κάνατε | έκαναν

[ TODO: Continue using the following

Regular English verbs, then, look like so. We will, for the first time, make heavy use of our
numbered verb forms: for example, for the verb “to take”, they would be “take” (1), “taking” (2), “taken”
(3), “takes” (5) and “took” (6). We start with the infinitive (“take”) in verb form 1, but (2), (3), (5) and
(6) are initially blank – we have to make them somehow.
We do this by giving their definitions not as fixed wording, as we did for the verbs above, but as tries
which act on the infinitive to produce a wording. For example, <en-trie-present-participle> is a trie which
performs:
take --> taking
We will have to define these tries below. Note that the infinitive can consist of multiple words; if so, the first
word is run through the tries, and the remaining words are left alone. For example, “grab onto” would be
inflected to “grabs onto”, “grabbing onto” and so on.
hregular-verb-conjugationi ::=
1 2 hen-trie-present-participlei |
2 3 hen-trie-past-participlei |
3 5 hen-trie-present-verb-formi |
4 6 hen-trie-pasti |
5 hregular-verb-tabulationi

 ]


[ "Λύνω" - 'Α Συζυγία. Παρόμοια κλίνονται τα "κάνω", "βάφω", ... ]

<gr-lyno-conjugation> ::=
    5       λύν |
    6       λυσ |
    <gr-lyno-tabulation>

<gr-lyno-tabulation> ::=
    a1+ <gr-lyno-present> |
    a1- δεν <gr-lyno-present> |
    a2+ <gr-lyno-past> |
    a2- δεν <gr-lyno-past> |
    a3+ <gr-lyno-future> |
    a3- δεν <gr-lyno-future> |
    a4+ <gr-lyno-subjunctive> |
    a4- να μην <gr-lyno-subjunctive> |
    a5+ <gr-lyno-imperative> |
    a5- μην <gr-lyno-imperative> |
    a6+ <gr-lyno-aorist> |
    a6- δεν <gr-lyno-aorist> |
	a7+ θα <gr-lyno-present> |
	a7- δεν θα <gr-lyno-present> |
    a8+ <gr-lyno-infinitive>

<gr-lyno-present> ::=
	5+ω | 5+εις | 5+ει | 5+ουμε | 5+ετε | 5+ουν

<gr-lyno-past> ::=
    έλυνα | έλυνες | έλυνε | λύναμε | λύνατε | έλυναν

<gr-lyno-future> ::=
    θα λύσω | θα λύσεις | θα λύσει | θα λύσουμε | θα λύσετε | θα λύσουν

<gr-lyno-subjunctive> ::=
    να λύσω | να λύσεις | να λύσει | να λύσουμε | να λύσετε | να λύσουν

<gr-lyno-imperative> ::=
    λύσε | λύστε

<gr-lyno-aorist> ::=
    έλυσα | έλυσες | έλυσε | λύσαμε | λύσατε | έλυσαν

<gr-lyno-infinitive> ::=
    λύσει

[ "Βλέπω" ]

<gr-vlepo-conjugation> ::=
    5       βλέπ |
    6       5 |
    7       είδ |
    8       5 |
    <gr-vlepo-tabulation>

<gr-vlepo-tabulation> ::=
    a1+      <gr-vlepo-present> |
    a1-      δεν <gr-vlepo-present> |
    a2+      <gr-vlepo-past> |
    a2-      δεν <gr-vlepo-past> |
	[ TODO: Λείπουν a4, a3 ]
    a5+      <gr-vlepo-future> |
    a5-      δεν <gr-vlepo-future> |
    a6+      <gr-vlepo-imperfect> |
    a6-      δεν <gr-vlepo-imperfect> |

<gr-vlepo-present> ::=
    βλέπω | βλέπεις | βλέπει | βλέπουμε | βλέπετε | βλέπουν

<gr-vlepo-past> ::=
    είδα | είδες | είδε | είδαμε | είδατε | είδαν

<gr-vlepo-future> ::=
    θα δω | θα δεις | θα δει | θα δούμε | θα δείτε | θα δουν

<gr-vlepo-imperfect> ::=
	έβλεπα | έβλεπες | έβλεπε | βλέπαμε | βλέπατε | έβλεπαν

[ Κρατάω - Α' Τάξη, Β' Συζυγία, ρήματα σε -άω/-ω. Προς το παρόν θα κρατήσουμε μόνο την κατάληξη σε -άω]

<gr-kratao-conjugation> ::=
    5       κρατ |
    7       κράτ |
    <gr-kratao-tabulation>

<gr-kratao-tabulation> ::=
    a1+      <gr-kratao-present> |
    a1-      δεν <gr-kratao-present> |
    a2+      <gr-kratao-past> |
    a2-      δεν <gr-kratao-past> |
	[ TODO: Λείπουν a4, a3 ]
    a5+      <gr-kratao-future> |
    a5-      δεν <gr-kratao-future> |
    a6+      <gr-kratao-imperfect> |
    a6-      δεν <gr-kratao-imperfect> |

<gr-kratao-present> ::=
     5+άω | 5+άς | 5+άει | 5+άμε | 5+άτε | 5+ούν |

<gr-kratao-past> ::=
    7+ησα | 7+ησες | 7+ησε | 5+ήσαμε | 5+ήσατε | 7+ησαν |

<gr-kratao-future> ::=
    θα 5+ήσω | θα 5+ήσεις | θα 5+ήσει | θα 5+ήσουμε | θα 5+ήσετε | θα 5+ήσουν

<gr-kratao-imperfect> ::=
	δει

<gr-xtypao-conjugation> ::=
    5       χτυπ |
    7       χτύπ |
    <gr-kratao-tabulation>


[ "Παίρνω" ]

<gr-pairno-conjugation> ::=
    5       παίρν |
    6		πάρ |
    7       πήρ |
	8		έπαιρν |
    <gr-pairno-tabulation>

<gr-pairno-tabulation> ::=
    a1+      <gr-lyno-present> |
    a1-      δεν <gr-lyno-present> |
    a2+      <gr-pairno-past> |
    a2-      δεν <gr-pairno-past> |
	[ TODO: Λείπουν a4, a3 ]
    a5+      <gr-pairno-future> |
    a5-      δεν <gr-pairno-future> |
    a6+      <gr-pairno-imperfect> |
    a6-      δεν <gr-pairno-imperfect> |

<gr-pairno-past> ::=
    πήρα | πήρες | πήρε | πήραμε | πήρατε | πήραν

<gr-pairno-future> ::=
    θα πάρω | θα πάρεις | θα πάρει | θα πάρουμε | θα πάρετε | θα πάρουν

<gr-pairno-imperfect> ::=
	έπαιρνα | έπαιρνες | έπαιρνε | παίρναμε | παίρνατε | έπαιρναν


[ Υποτακτική Έγκλιση ]

[ Δυστυχώς, το Inform δεν υποστηρίζει με κάποιον τρόπο όσο έχω ψάξει την υποτακτική έγκλιση, οπότε για τα ρήματα που αυτή απαιτείται, θα την ορίσουμε ως νέο ρήμα, και θα χρησιμοποιήσουμε αποκλειστικά τον ενεστώτα (present tense) ]

[ "Να δω" ]

<gr-na-do-conjugation> ::=
	<gr-na-do-tabulation>

<gr-na-do-tabulation> ::=
	a1+      <gr-na-do-present>

<gr-na-do-present> ::=
	δω | δεις | δει | δούμε | δείτε | δουν

[ "Να πάω" ]

<gr-na-paw-conjugation> ::=
	<gr-na-paw-tabulation>

<gr-na-paw-tabulation> ::=
	a1+      <gr-na-paw-present>

<gr-na-paw-present> ::=
	πάω | πας | πάει | πάμε | πάτε | πάνε


<gr-na-paro-conjugation> ::=
	<gr-na-paro-tabulation>

<gr-na-paro-tabulation> ::=
	a1+      <gr-na-paro-present>

<gr-na-paro-present> ::=
	πάρω | πάρεις | πάρει | πάρουμε | πάρετε | πάρουν


-) in the Preform grammar.


Chapter 2.4.2 - Verb substitutions

[ TODO: Figure out tenses ]

[ To say είμαι:
	if the story viewpoint is the first person singular:
		now the prior named object is the player;
		if the story tense is the perfect tense:
			say "ήμουν";
		else if the story tense is the past tense:
			say "ήμουν";
		else if the story tense is the past perfect tense:
			say "ήμουν";
		else:
			say "[είμαι]";
	else:
		say "[είμαι]".

To say Είμαι:
	if the story viewpoint is the first person singular:
		now the prior named object is the player;
		if the story tense is the perfect tense:
			say "Ήμουν";
		else if the story tense is the past tense:
			say "Ήμουν";
		else if the story tense is the past perfect tense:
			say "Ήμουν";
		else:
			say "[Είμαι]";
	else:
		say "[Είμαι]".

To say ήμουν:
	if the story viewpoint is the first person singular and (the story tense is past historic tense or the story tense is perfect tense or the story tense is past tense):
		now the prior named object is the player;
		say "ήμουν";
	else:
		say "ήμουν".


To say Ήμουν:
	if the story viewpoint is the first person singular and (the story tense is past historic tense or the story tense is perfect tense or the story tense is past tense):
		now the prior named object is the player;
		say "Ήμουν";
	else:
		say "Ήμουν". ]

[ TODO: Complete the chapter ]

To say adapt (V - a verb) for background/bg:
	say "[adapt V]".

To say negate (V - a verb) for background/bg:
	say "[negate V]".

Chapter 2.4.3 - Meaningful verbs

Section 2.4.3.1 - In the Standard Rules

In Greek είμαι is a verb meaning to be.
In Greek έχω is a verb meaning to have.
In Greek μπορώ is a verb meaning to be able to.
In Greek παρέχω is a verb meaning to provide.
In Greek περιέχω is a verb meaning to contain.
[ TODO: Add conjugation for the following:
στηρίζω, ενσωματώνω, περικλείω, μεταφέρω, κρύβω, ξεκλειδώνω]
[ In Greek στηρίζω is a verb meaning to support. ]
[ In Greek ενσωματώνω is a verb meaning to incorporate. ]
[ In Greek περικλείω is a verb meaning to enclose. ]
[ In Greek μεταφέρω is a verb meaning to carry. ]
In Greek κρατάω is a verb meaning to hold.
[ In Greek κρύβω is a verb meaning to conceal. ]
[ In Greek ξεκλειδώνω is a verb meaning to unlock. ]

In Greek βλέπω is a verb.
In Greek δω is a verb.
In Greek πάω is a verb.
In Greek κρατάω is a verb.
In Greek παίρνω is a verb.
In Greek πάρω is a verb.

Section 2.4.3.2 - In Rideable Vehicles (for use with Rideable Vehicles by Graham Nelson)

Section 2.4.3.3 - In Locksmith (for use with Locksmith by Emily Short)

Chapter 2.4.4 - Prepositions

[ Στο σημείο αυτό, περιλαμβάνονται επιρρήματα και προθέσεις]

[We need the following in order to make definitions of "prepositions" work
properly.]


Include [preform](-
language Greek

<infinitive-usage-exceptional> ::=
	/c/ είμαι ...

-) in the Preform grammar.

[ Τοπικά επιρρήματα: αλλού, αυτού, βόρεια, δίπλα, εδώ, εκεί, εμπρός, εντός, έξω, κάτω, νότια, μέσα, παντού, πάνω, πίσω, πουθενά ]

In Greek είμαι μέσα is a verb meaning to be in.
In Greek είμαι εντός is a verb meaning to be in.
[ In Greek είμαι γεωγραφικά μέσα is a verb meaning to be regionally in. ]
[ Προκαλεί το ακόλουθο error:
line 9197/9201: Error:  No such constant as "call_U27/28"]
[ In Greek είμαι πάνω στον/στη/στο is a is a verb meaning to be on. ]

In Greek είμαι μέρος του is a verb meaning to be part of.
In Greek είμαι μέρος της is a verb meaning to be part of.
In Greek είμαι μέρος των is a verb meaning to be part of.
[ TODO: Add wear? (In French être vêtu de is a verb meaning to wear.) ]
[ In Greek είμαι δίπλα σε is a verb meaning to be adjacent to. ]
[ TODO: Resolve error for the above: line 9311: Error:  No such constant as "call_U31" ]
In Greek είμαι πάνω από is a verb meaning to be above.
In Greek είμαι κάτω από is a verb meaning to be below.
In Greek είμαι μέσα από is a verb meaning to be through.

[ TODO: Fix these for the following: new verbs can only be defined in terms of existing relations, all of
    which have names ending 'relation': thus '...implies the possession
    relation' is an example of a valid definition, this being one of the
    relations built into Inform. ]
[ In Greek είμαι βόρεια από τον is a verb meaning the mapping north relation. ]
[ In Greek είμαι βόρεια από την is a verb meaning the mapping north relation.
In Greek είμαι βόρεια από το is a verb meaning the mapping north relation. ]

In Greek είμαι ανατολικά από is a verb mapping την ανατολή relation.
In Greek είμαι δυτικά από is a verb mapping την δύση relation.

[ Παραθετικά επιρρημάτων ]

[ TODO: Check if the following works correctly. ]
In Greek είμαι μεγαλύτερος/μεγαλύτερη/μεγαλύτερο από is a verb meaning to be greater than.
[ In Greek είμαι μεγαλύτερη από is a verb meaning to be greater than.
In Greek είμαι μεγαλύτερο από is a verb meaning to be greater than. ]
In Greek είμαι μικρότερος/μικρότερη/μικρότερο από is a verb meaning to be less than.
In Greek είμαι το πολύ is a verb meaning to be at most.
In Greek είμαι το λιγότερο is a verb meaning to be at least.
In Greek είμαι τουλάχιστον is a verb meaning to be at least.


Chapter 2.4.5 - Meaningless verbs

Part 2.5 - Miscellaneous substitutions

To say τώρα:
	if the story tense is present tense, say "τώρα";
	else say "εκείνη την εποχή".

To say εδώ:
	if the story tense is present tense, say "εδώ";
	else say "σε αυτό το μέρος".

To say Τώρα:
	if the story tense is present tense, say "Τώρα";
	else say "Εκείνη την εποχή".

To say Εδώ:
	if the story tense is present tense, say "Εδώ";
	else say "Σε αυτό το μέρος".

Volume 3 - Responses

Part 3.1 - Responses

Chapter 3.1.1 - In the Standard Rules

[And now the responses from this extension. You can get a full set of these by
trying out any English source text, e.g.,

	The Amphitheatre is a room.

and then typing the command:

	RESPONSES SET 1

This produces text which can be pasted in here before being translated.]

Section 3.1.1.1 - The final question

print the final prompt rule response (A) is ">[run paragraph on]".
print the final question rule response (A) is "Θα ήθελες να ".
print the final question rule response (B) is " ή ".
standard respond to final question rule response (A) is "Παρακαλώ επίλεξε μία από τις παραπάνω επιλογές.".

Section 3.1.1.2 - Printing the locale description

you-can-also-see rule response (A) is "[Εγώ] ".
you-can-also-see rule response (B) is "Πάνω σε [the domain], [εγώ] ".
you-can-also-see rule response (C) is "Μέσα σε [the domain], [εγώ] ".
you-can-also-see rule response (D) is "[regarding the player][adapt the verb μπορώ] επίσης να [adapt the verb δω in present tense] ".
you-can-also-see rule response (E) is "[regarding the player][adapt the verb μπορώ] να [adapt the verb δω in present tense] ".
you-can-also-see rule response (F) is "".

Section 3.1.1.3 - Printing a locale paragraph about a thing

use initial appearance in room descriptions rule response (A) is "Πάνω σε [the item], ".
describe what's on scenery supporters in room descriptions rule response (A) is "Πάνω σε [the item], ".

Section 3.1.1.4 - Standard actions concerning the actor's possessions

[Taking inventory]
print empty inventory rule response (A) is "[Εγώ] δεν [adapt the verb κρατάω] τίποτα.".
print standard inventory rule response (A) is "[Εγώ] [adapt the verb κρατάω] :[line break]".
report other people taking inventory rule response (A) is "[The actor] [adapt the verb βλέπω in present tense] τα υπάρχοντά [μου].".

[Taking]

[ TODO: Test the following, see French example ]
can't take yourself rule response (A) is "Δεν [adapt the verb μπορώ in present tense] να [adapt the verb πάρω in present tense] [τον εαυτό μου]".
[ TODO: Change the following ]
can't take other people rule response (A) is "[Εγώ] [don't] suppose [the noun] [would care] for that.".
[ TODO: Translate the above segment ]

[ TODO: Replace those, check if whole needs adaptation ]
can't take component parts rule response (A) is "[regarding the noun][Those] φαίνεται να είναι μέρος από [the whole].".
can't take people's possessions rule response (A) is "[regarding the noun][Those] φαίνεται να ανήκουν σε [the owner].".
[ TODO: Adapt the verb βγω ]
can't take what you're inside rule response (A) is "Θα έπρεπε να βγεις από [the noun] πρώτα.".
can't take what's already taken rule response (A) is "[adapt the verb έχω] ήδη [regarding the noun][those]".
can't take scenery rule response (A) is "[regarding the noun]Δεν γίνεται να μετακινηθεί.".
[ TODO: Check grammar on the following ]
can't take what's fixed in place rule response (A) is "[regarding the noun][adapt the verb είμαι] στερεωμένος/στερεωμένη/στερεωμένο στην θέση του/της.".
use player's holdall to avoid exceeding carrying capacity rule response (A) is "(βάζοντας [the transferred item] μέσα σε [the current working sack] για να δημιουργηθεί χώρος)[command clarification break]".
can't exceed carrying capacity rule response (A) is "[Εγώ] [κρατάω] ήδη πάρα πολλά πράγματα.".
standard report taking rule response (A) is "Πάρθηκε.".
standard report taking rule response (B) is "[The actor] [adapt the verb παίρνω] [the noun].".

[Removing it from]
[ TODO: Continue from here ]
can't remove what's not inside rule response (A) is "But [regarding the noun][they] [aren't] there [now].".
[Dropping]
can't drop what's already dropped rule response (A) is "[The noun] [adapt the verb είμαι] ήδη [εδώ].".
[ TODO: Fix the following ]
can't drop what's not held rule response (A) is "[Εγώ] δεν [adapt the verb έχω] [regarding the noun][those].".

standard report dropping rule response (A) is "Αφέθηκε.".
standard report dropping rule response (B) is "[The actor] [put] down [the noun].".

[Putting it on]
can't put something on itself rule response (A) is "[We] [can't put] something on top of itself.".

[Inserting it into]

[Eating]

Section 3.1.1.5 - Standard actions which move the actor

[Going , Entering , Exiting , Getting off]

[ Going ]

can't go that way rule response (A) is "[Εγώ] [negate the verb μπορώ for bg] να [adapt the verb πάω in present tense] προς αυτή την κατεύθυνση".

can't go that way rule response (B) is "[Εγώ] [negate the verb μπορώ for bg] να [adapt the verb πάω in present tense] προς τα εκεί".

[Entering]

[Getting off]

Section 3.1.1.6 - Standard actions concerning the actor's vision

[Looking]

[Examining]

[Looking under]

[Searching]

[Consulting it about]

Section 3.1.1.7 - Standard actions which change the state of things

[Locking it with]

[Unlocking it with]

[Switching on]

[Switching off]

[Opening]

[ TODO: add conjugation for ανοίγω ]
reveal any newly visible interior rule response (A) is "[Εγώ] ανοίγεις [the noun], αποκαλύπτοντας ".
standard report opening rule response (A) is "[Εγώ] ανοίγεις [the noun].".
standard report opening rule response (B) is "[The actor] ανοίγεις [the noun].".
standard report opening rule response (C) is "[The noun] ανοίγει.".

[Closing]

[ TODO: add conjugation for κλείνω]
standard report closing rule response (A) is "[Εγώ] κλείνεις [the noun].".
standard report closing rule response (B) is "[The actor] κλείνει [the noun].".
standard report closing rule response (C) is "[The noun] κλείνει.".



[Wearing]

[Taking off]

Section 3.1.1.8 - Standard actions concerning other people

[Giving it to]

[Showing it to]

[Waking]

[Throwing it at]

[Attacking]

[Kissing]

Section 3.1.1.9 - Standard actions which are checked but then do nothing unless rules intervene

[Waiting]

[Touching]

[Waving]

[Pulling]

[Pushing]

[Turning]

[Pushing it to]

[Squeezing]

Section 3.1.1.10 - Standard actions which always do nothing unless rules intervene

[Saying yes, saying no]

[Burning]

[Waking up]

[Thinking]

[Smelling]

[Listening to]

[Tasting]

[Cutting]

[Jumping]

[Tying it to]

[Drinking]

[Saying sorry]

[Swinging]

[Rubbing]

[Setting it to]

[Waving hands]

[Buying]

[Climbing]

[Sleeping]

Section 3.1.1.11 - Accessibility and visibility

Section 3.1.1.12 - List writer internal rule

Section 3.1.1.13 - Action processing internal rule

Section 3.1.1.14 - Parser

parser error internal rule response (A) is "Δεν κατάλαβα αυτή την πρόταση.".
parser error internal rule response (B) is "Κατάλαβα μόνο μέχρι το σημείο που ήθελες να".
parser error internal rule response (C) is "Κατάλαβα μόνο μέχρι το σημείο που ήθελες να (πας)".
parser error internal rule response (D) is "Δεν κατάλαβα αυτόν τον αριθμό.".
parser error internal rule response (E) is "[regarding the player][negate the verb βλέπω] κάτι τέτοιο.".
parser error internal rule response (F) is "Φαίνεται πως είπες πολύ λίγα!".
parser error internal rule response (G) is "[negate the verb κρατάω] αυτό!".
parser error internal rule response (H) is "Δεν μπορείς να χρησιμοποιήσεις πολλαπλά αντικείμενα με αυτό το ρήμα.".
parser error internal rule response (I) is "Μπορείς να χρησιμοποιήσεις πολλαπλά αντικείμενα μόνο μία φορά σε μία γραμμή.".
parser error internal rule response (J) is "Δεν είμαι σίγουρος σε τι αναφέρεται το ['][pronoun i6 dictionary word]['].".
parser error internal rule response (K) is "[negate the verb μπορώ] να [adapt the verb δω in present tense] το ['][pronoun i6 dictionary word]['] ([the noun]) αυτή τη στιγμή.".
parser error internal rule response (L) is "Εξαίρεσες κάτι που δεν περιλαμβανόταν έτσι κι αλλιώς!".
parser error internal rule response (M) is "Μπορείς να το κάνεις αυτό μόνο σε κάτι που είναι έμψυχο.".
parser error internal rule response (N) is "Αυτό δεν είναι ένα από τα ρήματα που καταλαβαίνω.".
parser error internal rule response (O) is "Αυτό δεν είναι κάτι που χρειάζεται να αναφερθείς κατά τη διάρκεια αυτού του παιχνιδιού.".
parser error internal rule response (P) is "Δεν κατάλαβα τον τρόπο που ολοκληρώθηκε αυτό.".
parser error internal rule response (Q) is "[if number understood is 0]Κανένα[otherwise]Μόνο [number understood in words][end if] από αυτά [regarding the number understood][adapt the verb είμαι] διαθέσιμα.".
parser error internal rule response (R) is "Αυτό το αντικείμενο δεν είχε νόημα σε αυτό το πλαίσιο.".
parser error internal rule response (S) is "Για να επαναλάβεις μια εντολή όπως 'βάτραχε, πήδα', απλά πες 'ξανά', όχι 'βάτραχε, ξανά'.".
parser error internal rule response (T) is "Δεν μπορείς να ξεκινήσεις την πρόταση με κόμμα.".
parser error internal rule response (U) is "Φαίνεται ότι θες να μιλήσεις σε κάποιον, αλλά δε μπορώ να καταλάβω σε ποιον.".
parser error internal rule response (V) is "Δεν μπορείς να μιλήσεις στον/στην/στο [the noun].".
parser error internal rule response (W) is "Για να μιλήσεις σε κάποιον, δοκίμασε 'κάποιες, γεια σου' ή κάτι παρόμοιο.".
parser error internal rule response (X) is "Συγγνώμη;".

parser nothing error internal rule response (A) is "Δεν υπάρχει κάτι να κάνεις!".
parser nothing error internal rule response (B) is "[negate the verb είμαι from the third person plural] καθόλου διαθέσιμα!".
parser nothing error internal rule response (C) is "[The noun] [negate the verb έχω] τίποτα.".
[ TODO: adapt the verb περιέχω in present tense - change those]
parser nothing error internal rule response (D) is "[regarding the noun][Those] [negate the verb μπορώ] να περιέχουν πράγματα.".
[ TODO: Adapt ανοιχτό και άδειο ]
parser nothing error internal rule response (E) is "[The noun] [negate the verb είμαι] ανοιχτό.".
parser nothing error internal rule response (F) is "[The noun] [adapt the verb είμαι] άδειο.".

darkness name internal rule response (A) is "Σκοτάδι".

parser command internal rule response (A) is "Συγνώμη, αυτό δεν μπορεί να διορθωθεί.".
parser command internal rule response (B) is "Μην το σκέφτεσαι καθόλου.".
parser command internal rule response (C) is "Το 'Ουπς' μπορεί να διορθώσει μόνο μία λέξη.".
parser command internal rule response (D) is "Δύσκολα μπορείς να το επαναλάβεις.".

Section 3.1.1.15 - Yes or no question internal rule

yes or no question internal rule response (A) is "Παρακαλώ απάντησε με ναι ή όχι.".

Section 3.1.1.16 - Print protagonist internal rule

Section 3.1.1.17 - Standard implicit taking rule

Section 3.1.1.18 - Player's obituary

Section 3.1.1.19 - Standard actions which happen out of world

[Undoing (though not technically an action)]

[Quitting the game]
quit the game rule response (A) is "Σίγουρα θες να φύγεις από το παιχνίδι; ".

[Saving the game]

[Restoring the game]

[Restarting the game]

[Verifying the story file]

[Switching the story transcript on]

[Switching the story transcript off]

[Requesting the score]

[Switching score notification on/off]

Part 3.2 - The Final Question

Part 3.3 - Description of the player

Part 3.4 - The banner

Part 3.5 - The bibliographical data

[ TODO: Ask Graham about this one ]
[ Section 3.5.1 - The bibliographical data - Unindexed (in place of Section 7 - Unindexed Standard Rules variables - Unindexed in Standard Rules by Graham Nelson) ]

The release number is usually 1.
The story title is usually "Χωρίς Τίτλο".
The story author is usually "Ανώνυμος/η".
The story headline is usually "Ένα Διαδραστικό Μυθιστόρημα". [TODO: Doesn't translate]
The story genre is usually "Ιστορία".

[ The story title variable translates into I6 as "Story". ]

Part 3.6 - Rule replacements

Volume 4 - Command parsing

Part 4.1 - Pronouns and possessives in commands

Include (-
Array LanguagePronouns table

    ! word        possible GNAs                   connected
    !             to follow:                      to:
    !             a     i
    !             s  p  s  p
    !             mfnmfnmfnmfn

    'αυτός'     $$100000100000                    NULL
    'αυτή'      $$010000010000                    NULL
    'αυτό'      $$001000001000                    NULL
    'αυτοί'     $$000100000100                    NULL
    'αυτές'     $$000010000010                    NULL
    'αυτά'      $$000001000001                    NULL;
-) replacing "Pronouns".

Include(-

Array LanguageDescriptors table

  ! word        possible GNAs   descriptor      connected
  !             to follow:      type:           to:
  !             a     i
  !             s  p  s  p
  !             mfnmfnmfnmfn

    'μου'     $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'these'   $$000111000111    POSSESS_PK      0
    'that'    $$111111111111    POSSESS_PK      1
    'those'   $$000111000111    POSSESS_PK      1
    'his'     $$111111111111    POSSESS_PK      'him'
    'her'     $$111111111111    POSSESS_PK      'her'
    'their'   $$111111111111    POSSESS_PK      'them'
    'its'     $$111111111111    POSSESS_PK      'it'
    'ο'       $$100000100000    DEFART_PK       NULL
    'του'     $$101000101000    DEFART_PK       NULL
    'τον'     $$100000100000    DEFART_PK       NULL
    'στον'    $$100000100000    DEFART_PK       NULL
    'η'       $$010000010000    DEFART_PK       NULL
    'της'     $$010000010000    DEFART_PK       NULL
    'την'     $$010000010000    DEFART_PK       NULL
    'στην'    $$010000010000    DEFART_PK       NULL
    'το'      $$001000001000    DEFART_PK       NULL
    'στο'     $$001000001000    DEFART_PK       NULL
    'οι'      $$000110000110    DEFART_PK       NULL
    'των'     $$000111000111    DEFART_PK       NULL
    'τους'    $$000100000100    DEFART_PK       NULL
    'στους'   $$000100000100    DEFART_PK       NULL
    'τις'     $$000010000010    DEFART_PK       NULL
    'στις'    $$000010000010    DEFART_PK       NULL
    'τα'      $$000001000001    DEFART_PK       NULL
    'στα'     $$000001000001    DEFART_PK       NULL
    'ένας'    $$100000100000    INDEFART_PK     NULL
    'ενός'    $$101000101000    INDEFART_PK     NULL
    'έναν'    $$100000100000    INDEFART_PK     NULL
    'μία'     $$010000010000    INDEFART_PK     NULL
    'μίας'    $$010000010000    INDEFART_PK     NULL
    'ένα'     $$001000001000    INDEFART_PK     NULL
    ! Το κάποιος/α/ο... βγάζει complexity error οπότε το αγνοούμε προς το παρόν
    'lit'     $$111111111111    LIGHTED_PK      NULL
    'lighted' $$111111111111    LIGHTED_PK      NULL
    'unlit'   $$111111111111    UNLIGHTED_PK    NULL;
-) replacing "Descriptors".

Part 4.2 - Understand grammar

Chapter 4.2.1 - New Grammar Tokens

Chapter 4.2.2 - Standard actions concerning the actor's possessions

Understand "ευρετήριο" as taking inventory.
Understand the command "ε", "ευρ", "ευρετηριο" as "ευρετήριο".

Understand "πάρε [things]" as taking.
Understand the command "π", "παρε", "κράτησε", "σήκωσε", "άρπαξε", "μάζεψε", "πιάσε" and "βούτα" as "πάρε".

Understand "αφαίρεσε [things inside] από [something]", "αφαιρεσε [things inside] από [something]", "πάρε [things inside] από [something]", "παρε [things inside] από [something]" as removing it from.

Understand "ρίξε [things preferably held]", "ριξε [things preferably held]", "άφησε [things preferably held]", "άσε [things preferably held]", "αφησε [things preferably held]", "ασε [things preferably held]" as dropping.

[ TODO: Add στον, στην, στο... ]
Understand "βάλε [other things] πάνω σε [something]" as putting it on.

[ TODO: Find a way for:  Understand the command "πανω" as "πάνω" ]

Understand "βάλε [other things] μέσα σε [something]" as inserting it into.

Understand "πέταξε [something preferably held] σε/προς [something]" as throwing it at.

Understand the command "τοποθέτησε", "τοποθετησε", "βαλε" as "βάλε".

Understand "φάε [something preferably held]" as eating.
Understand the command "φαε" as "φάε".

Chapter 4.2.3 - Standard actions which move the actor

[ TODO: Add synonyms in this chapter ]

Understand "πήγαινε" as going.
Understand "πήγαινε προς [direction]" or "πήγαινε [direction]" as going.
Understand the command "πηγαινε" as "πήγαινε".

[ TODO: Replace σε with στον/στην/στη/στο + πληθ. in all occurences ]
Understand "μπες στον/στην/στη/στο [something]" as entering.
Understand the command "μπεσ" as "μπες".

Understand "ανέβα στον/στην/στη/στο [something]" as entering.
Understand "κάθισε στον/στην/στη/στο [something]" as entering.
Understand "κάθισε στην κορυφή του/της [something]" as entering.
Understand the command "κάτσε" as "κάθισε".

Understand "βγες" as exiting.
Understand the command "βγεσ" as "βγες".
Understand "σήκω" as exiting.

Understand "βγες από [something]" as getting off.
Understand the command "κατέβα" and "κατεβα" as "βγες".

Chapter 4.2.4 - Standard actions concerning the actor's vision

Understand "κοίτα" as looking.
Understand the command "κοιτα", "δες", "δεσ" as "κοίτα".

Understand "εξέτασε [something]" as examining.
Understand the command "εξετασε", "τσέκαρε", "τσεκαρε" as "εξέτασε".
Understand the command "ξ" as "εξέτασε".

Understand "δες κάτω από [something]" and "εξέτασε κάτω από [something]" as looking under.

Understand "δες μέσα/γύρω/πίσω από [something]" and "εξέτασε μέσα/γύρω/πίσω από [something]" as searching.

Understand "συμβουλεύσου [text] σε [something]" as consulting it about (with nouns reversed).

Understand "διάβασε σχετικά με [text] σε [something]" as consulting it about (with nouns reversed).

Chapter 4.2.5 - Standard actions which change the state of things

Understand "κλείδωσε [something] με [something preferably held]" as locking it with.
Understand the command "κλειδωσε" as "κλείδωσε".

Understand "ξεκλείδωσε [something] με [something preferably held]" as unlocking it with.
Understand the command "ξεκλειδωσε", as "ξεκλείδωσε".

Understand "γύρισε [something]" as turning.
Understand the command "γυρισε" as "γύρισε".

Understand "άναψε [something]" as switching on.
Understand the command "αναψε" as "άναψε".
Understand "σβήσε [something]" as switching off.
Understand the command "σβησε" as "σβήσε".

Understand the commands "περίστρεψε", "περιστρεψε", "στρίψε", "στριψε", "ξεβίδωσε", "ξεβιδωσε", "βίδωσε" and "βιδωσε" as "γύρισε".

Understand "άνοιξε [something]" as opening.
Understand the command "ανοιξε" as "άνοιξε".

Understand "κλείσε [something]" as closing.
Understand the command "κλεισε" as "κλείσε".

Understand "φόρεσε [something preferably held]" as wearing.
Understand the command "φορεσε", "φόρα", "φορα" as "φόρεσε".

Understand "βγάλε [something preferably held]" as taking off.
Understand the command "βγαλε" as "βγάλε".

Chapter 4.2.6 - Standard actions concerning other people

Understand "δώσε [something preferably held] σε [someone]" as giving it to.
Understand "δώσε [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand the commands "πλήρωσε" and "πρόσφερε" and "τάισε" as "δώσε".

Understand "δείξε σε [someone] [something preferably held]" as showing it to (with nouns reversed).
Understand "δείξε [something preferably held] σε [someone]" as showing it to.
Understand the commands "παρουσίασε" as "δείξε".

Understand "ξύπνα" as waking up.
Understand "ξύπνα [someone]" or "σήκωσε [someone] " as waking.

Understand "επιθέσου σε [something]" as attacking.
Understand "χτύπα [something]" as attacking.
Understand the commands "χτύπησε", "πολέμησε", "βασάνισε", "κατάστρεψε", "σπάσε", "ράγισε", "δολοφόνησε", "σκότωσε", "γρονθοκόπησε" as "χτύπα".

Understand "φίλησε [someone]" as kissing.
Understand the commands "φίλα" and "αγκάλιασε" as "φίλησε".

Understand "απάντησε [text] σε [someone]" as answering it that (with nouns reversed).
Understand the commands "απάντα", "φώναξε", "πες" and "μίλα" as "απάντησε".

Understand "πες σε [someone] σχετικά με [text]" as telling it about.

Understand "ρώτησε [someone] σχετικά με [text]" as asking it about.
Understand "ρώτησε [someone] για [something]" as asking it for.

Chapter 4.2.7 - Standard actions which are checked but then do nothing unless rules intervene

Understand "περίμενε" as waiting.
Understand the command "ζ" as "περίμενε".

Understand "ακούμπησε [something]" as touching.
Understand the command "ακούμπα", "πίεσε", "πάτα", "νιώσε" as "ακούμπησε".

Understand "κυμάτισε [something]" as waving.

Understand "τράβηξε [something]" as pulling.
Understand the command "τράβα", "σύρε" as "τράβηξε".

Understand "σπρώξε [something]" as pushing.
Understand "σπρώξε [something] [direction]" or "σπρώξε [something] προς [direction]" as pushing it to.
Understand the commands "μετακίνησε", "διώξε" as "σπρώξε".

Understand "συμπίεσε [something]" as squeezing.
Understand the command "συμπιεσε" as "συμπίεσε".

Chapter 4.2.8 - Standard actions which always do nothing unless rules intervene

Understand "ναι" as saying yes.
Understand the command "οκ" as "ναι".

Understand "όχι" as saying no.

Understand "κάψε [something]" as burning.
Understand the command "καψε" as "κάψε".

Understand "σκέψου" as thinking.

Understand "μύρισε" as smelling.
Understand "μύρισε [something]" as smelling.
Understand the command "οσμίσου" and "σνίφαρε" as "smell".

Understand "άκουσε" as listening to.
Understand "άκουσε [something]" as listening to.
Understand "άκουσε σε [something]" as listening to.
Understand the command "άκου" as "άκουσε".

Understand "γεύσου [something]" as tasting.
Understand the command "δοκίμασε" as "γεύσου".

Understand "κόψε [something]" as cutting.
Understand the commands "τεμάχισε", "κομμάτιασε" and "ψιλόκοψε" as "κόψε".

Understand "πήδησε" as jumping.
Understand the command "χοροπήδησε", "πήδα" as "πήδησε".

Understand "δέσε [something] σε [something]" as tying it to.
Understand the commands "προσκόλλησε" and "σύνδεσε" as "δέσε".

Understand "πιες [something]" as drinking.
Understand the command "καταπιές" as "πιες".

Understand "συγγνώμη" or "συγνώμη" as saying sorry.

Understand "ισορρόπησε [something]" or "ισορρόπησε πάνω στον/στη/στο [something]" as swinging.

Understand "τρίψε [something]" as rubbing.
Understand the commands "γυάλισε", "καθάρισε", "ξεσκόνισε", "σκούπισε", "σφουγγάρισε" as "τρίψε".

Understand "σέταρε [something] σε [text]" as setting it to.
Understand the command "προσάρμοσε"and "ρύθμισε" as "σέταρε".

Understand "αγόρασε [something]" as buying.
Understand the command "απόκτησε" as "αγόρασε".

Understand "σκαρφάλωσε [something]" or "σκαρφάλωσε πάνω σε/από [something]" as climbing.

Understand "κοιμήσου" as sleeping.
Understand the command "αποκοιμήσου" as "κοιμήσου".

Chapter 4.2.9 - Standard actions which happen out of world

Understand "τέλος" as quitting the game.

Understand "αποθήκευση" as saving the game.

Understand "επαναφορά" as restoring the game.

Understand "επανεκκίνηση" as restarting the game.

Understand "σύντομο" as preferring abbreviated room descriptions.

Understand "αναλυτικό"  as preferring unabbreviated room descriptions.

Understand "κανονικό" as preferring sometimes abbreviated room descriptions.

Understand "ειδοποίηση σκορ" or "ειδοποίηση σκορ ενεργή" as switching score notification on.

Understand "ειδοποίηση σκορ ανενεργή" as switching score notification off.

Understand "αντωνυμίες" as requesting the pronoun meanings.

Chapter 4.2.10 - Miscellaneous

Part 4.3 - Additional language-specific actions

Chapter 4.3.1 - InGoing

InGoing is an action applying to nothing.
Understand "entrer" as InGoing.

Chapter 4.3.2 - OutGoing

Chapter 4.3.3 - DownGoing

Chapter 4.3.4 - UpGoing

Chapter 4.3.5 - UpStanding

Part 4.4 - Clarifying the parser's choice of something

Part 4.5 - Actions specifications

[ TODO: Add specifications ]

Chapter 4.5.1 - Standard actions concerning the actor's possessions

The specification of the taking inventory action is "Απογραφή του ευρετηρίου των άμεσων αντικειμένων κάποιου: τα πράγματα που φέρει μαζί του, είτε άμεσα είτε σε οποιοδήποτε κιβώτιο που έχει. Όταν ο παίκτης εκτελεί αυτήν την ενέργεια, εμφανίζεται είτε η λίστα των αντικειμένων του, είτε ένα ειδικό μήνυμα αν δεν φέρει ή φορά τίποτα, κατά τη διάρκεια των κανόνων εκτέλεσης: δεν συμβαίνει τίποτα στο στάδιο της αναφοράς. Το αντίθετο συμβαίνει για άλλους χαρακτήρες που εκτελούν την ενέργεια: δεν συμβαίνει τίποτα κατά την εκτέλεση, αλλά παράγεται μια αναφορά, όπως 'Ο κ. Χ κοιτάζει τα αντικείμενά του.' (εφόσον ο κ. Χ είναι ορατός)."

The specification of the taking action is "Η ανάληψη δράσης είναι ο μόνος τρόπος σύμφωνα με τους 'Βασικούς Κανόνες (Standard Rules)' για να προκληθεί μεταφορά σε κάτι από έναν ηθοποιό. Είναι μια πολύ απλή διαδικασία (το στάδιο εκτέλεσης περιλαμβάνει μόνο τη φράση 'τώρα ο ηθοποιός μεταφέρει το αντικείμενο'), αλλά πολλές επαληθεύσεις πρέπει να γίνουν (σύμφωνα με τους κανόνες 'check') πριν επιτραπεί να πραγματοποιηθεί η δράση αυτή."

The specification of the removing it from action is "Η αφαίρεση δεν είναι πραγματικά μια ενέργεια από μόνη της. Ενώ υπάρχουν πολλοί τρόποι να βάλει κανείς κάτι κάπου (στο πάτωμα, πάνω σε κάτι άλλο, μέσα σε κάτι άλλο, να το δώσει σε κάποιον, κ.λπ.), στο Inform υπάρχει μόνο ένας τρόπος για να πάρει κάποιος κάτι: 'taking action'. Η αφαίρεση υπάρχει μόνο για να παρέχει κατάλληλες απαντήσεις σε αδύνατες αιτήσεις και, σε όλες τις λογικές περιπτώσεις, μετατρέπεται σε πάρσιμο. Για το λόγο αυτό, συνήθως είναι κακή ιδέα να γράφετε κανόνες για την αφαίρεση: αν γράψετε έναν κανόνα όπως 'Αντί να αφαιρέσετε το κλειδί, ...', τότε δεν θα εφαρμοστεί αν ο παίκτης απλά πληκτρολογήσει 'ΠΑΡΕ το κλειδί'. Ο ασφαλής τρόπος να το κάνετε αυτό είναι να γράψετε έναν κανόνα για την ενέργεια 'πάρε', ο οποίος καλύπτει όλες τις δυνατότητες."

[ TODO: Change rule can't drop clothes being worn after translating it ]
The specification of the dropping action is "Η ενέργεια 'ρίξε' είναι μία από τις πέντε ενέργειες με τις οποίες ο ηθοποιός μπορεί να απαλλαγεί από κάτι που μεταφέρει: οι άλλες είναι η εισαγωγή (σε έναν αποθηκευτικό χώρο), η τοποθέτηση (σε ένα κιβώτιο), η δωρεά (σε κάποιον άλλον) και η κατανάλωση. Η ρίψη σημαίνει την τοποθέτηση στο πάτωμα του ηθοποιού, το οποίο είναι συνήθως το πάτωμα ενός δωματίου, αλλά μπορεί να είναι και το εσωτερικό ενός κουτιού αν ο ηθοποιός είναι μέσα σε αυτό το κουτί, κ.λπ.

Ο κανόνας 'can't drop clothes being worn' προσπαθεί σιωπηρά να εκτελέσει την ενέργεια 'αφαίρεση' σε οποιοδήποτε ρούχο ρίπτεται: η αφαίρεση αυτού του κανόνα αφαιρεί τόσο αυτήν τη συμπεριφορά όσο και την απαίτηση ότι τα ρούχα δεν μπορούν απλά να ριχτούν.".

The specification of the putting it on action is "Με αυτήν την ενέργεια, ο ηθοποιός τοποθετεί κάτι που κρατάει πάνω σε έναν υποστηρικτή: για παράδειγμα, τοποθετώντας ένα μήλο πάνω σε ένα τραπέζι.".

The specification of the inserting it into action is "Με αυτήν την ενέργεια, ο ηθοποιός τοποθετεί κάτι που κρατάει σε ένα κιβώτιο: για παράδειγμα, τοποθετώντας ένα νόμισμα σε ένα κουτί συλλογής."

[ TODO: Translate carry out ]
The specification of the eating action is "Η ενέργεια 'φάε' είναι η μοναδική από τις ενέργειες που ενσωματώνονται από προεπιλογή που μπορεί, ουσιαστικά, να καταστρέψει κάτι: ο κανόνας 'carry out' αφαιρεί το αντικείμενο που τρώγεται από το παιχνίδι, και τίποτα στους 'Standard Rules' δεν μπορεί να το ανακτήσει ξανά."

Chapter 4.5.2 - Standard actions which move the actor

The specification of the going action is "Αυτή είναι η ενέργεια που επιτρέπει στους ανθρώπους να μετακινηθούν από ένα δωμάτιο σε ένα άλλο, χρησιμοποιώντας όποιες συνδέσεις και πόρτες στο χάρτη είναι διαθέσιμες. Οι 'Standard Rules' είναι γραμμένοι έτσι ώστε το όνομα αυτής της ενέργειας να μπορεί να είναι είτε κατεύθυνση είτε πόρτα στο σημείο όπου βρίσκεται ο ηθοποιός: ενώ οι εντολές του παίκτη οδηγούν μόνο σε ενέργειες με κατευθύνσεις ως ονόματα, οι ενέργειες 'going' μπορούν επίσης να συμβούν ως αποτέλεσμα ενεργειών 'entering', και τότε το ουσιαστικό μπορεί πράγματι να είναι μια πόρτα."

[ TODO: Translate the rule ]
The specification of the entering action is "Ενώ η ενέργεια 'going' επιτρέπει σε ένα άτομο να μετακινηθεί από ένα μέρος σε ένα άλλο, η ενέργεια αυτή αφορά την κίνηση μέσα σε έναν ίδιο χώρο: για παράδειγμα, το να ανέβει κάποιος σε ένα κλουβί ή να καθίσει σε έναν καναπέ (η ενέργεια 'entering' δεν επιτρέπεται να αλλάξει το χώρο, οπότε οποιαδήποτε προσπάθεια να μπεις σε μια πόρτα μετατρέπεται σε ενέργεια 'going'). Αυτό που κάνει την ενέργεια 'entering' πιο δύσκολη από ό,τι φαίνεται είναι ότι ο παίκτης μπορεί να προσπαθήσει να μπει σε ένα αντικείμενο που είναι και το ίδιο μέσα ή μέρος ενός άλλου αντικειμένου, το οποίο με τη σειρά του μπορεί να είναι... και ούτω καθεξής. Για να διατηρηθεί ο ρεαλισμός, ο κανόνας 'implicitly pass through other barriers' δημιουργεί αυτόματα τις ενέργειες 'entering' και 'exiting' που απαιτούνται για να περάσει οποιοδήποτε εμπόδιο βρίσκεται στο δρόμο του ηθοποιού: για παράδειγμα, σε έναν χώρο με δύο ανοιχτά κλουβιά, ένας ηθοποιός που βρίσκεται στο κλουβί A και προσπαθεί να μπει στο κλουβί B, πρέπει πρώτα να βγει από το A πριν μπορέσει να μπει στο B."

[ TODO: Translate the actions ]
The specification of the exiting action is "Ενώ η ενέργεια 'going' επιτρέπει σε ένα άτομο να μετακινηθεί από ένα μέρος σε ένα άλλο και η ενέργεια 'entering' επιτρέπει την κίνηση σε πιο βαθιά μέρη άλλων αντικειμένων, η ενέργεια 'exiting' αφορά την επιστροφή προς την κύρια επιφάνεια του χώρου. Για παράδειγμα, το να βγει κάποιος από μια ντουλάπα είναι μια ενέργεια 'exiting'. Αν ο ηθοποιός βρίσκεται ήδη στο κύριο δάπεδο ενός χώρου με σύνδεση στο εξωτερικό, η ενέργεια 'exiting' μετατρέπεται σε ενέργεια 'going'. Τέλος, σημειώστε ότι, σε αντίθεση με την ενέργεια 'entering', η ενέργεια 'exiting' αφορά μόνο την έξοδο από περιέκτες: αν ο ηθοποιός βρίσκεται πάνω σε έναν υποστηρικτή, η ενέργεια 'exiting' μετατρέπεται σε ενέργεια 'getting off'."

[ TODO: Translate the actions ]
The specification of the getting off action is "Η ενέργεια 'getting off' χρησιμοποιείται όταν ο ηθοποιός βρίσκεται πάνω σε έναν υποστηρικτή: ίσως στέκεται σε μια πλατφόρμα, κάθεται σε μια καρέκλα ή ακόμα και ξαπλώνει σε ένα κρεβάτι. Σε αντίθεση με την παρόμοια ενέργεια 'exiting', η ενέργεια 'getting off' απαιτεί ένα όνομα: την πλατφόρμα, την καρέκλα ή το κρεβάτι, για παράδειγμα."

Chapter 4.5.3 - Standard actions concerning the actor's vision

The specification of the looking action is "Η ενέργεια 'κοίτα' περιγράφει το τρέχον δωμάτιο του παίκτη και οποιαδήποτε ορατά αντικείμενα, αλλά περιπλέκεται από το πρόβλημα της ορατότητας. Το Inform το υπολογίζει διαιρώντας το δωμάτιο σε επίπεδα ορατότητας. Για έναν ηθοποιό στο πάτωμα ενός δωματίου, υπάρχει μόνο ένα τέτοιο επίπεδο: το ίδιο το δωμάτιο. Αλλά ένας ηθοποιός που κάθεται σε μια καρέκλα μέσα σε ένα κιβώτιο συσκευασίας, το οποίο βρίσκεται πάνω σε μια πλατφόρμα, θα είχε τέσσερα επίπεδα ορατότητας: καρέκλα, κιβώτιο, πλατφόρμα, δωμάτιο. Οι κανόνες του 'looking' χρησιμοποιούν μια ειδική φράση, 'ο visibility-holder του X', για να ανεβαίνουν από το ένα επίπεδο στο επόμενο: έτσι, ο visibility-holder του κιβωτίου είναι η πλατφόρμα.

Το 'visibility level count' είναι ο αριθμός των επιπέδων που ο παίκτης μπορεί πραγματικά να δει, και το 'visibility ceiling' είναι το ανώτατο ορατό επίπεδο. Για έναν παίκτη που στέκεται στο πάτωμα ενός φωτισμένου δωματίου, αυτό θα είναι ένας αριθμός 1 με το ceiling να έχει οριστεί στο δωμάτιο. Αλλά ένας παίκτης που κάθεται σε μια καρέκλα μέσα σε ένα κλειστό αδιαφανές κιβώτιο συσκευασίας θα είχε visibility level count 2, και visibility ceiling ίσο με το κιβώτιο. Επιπλέον, πρέπει να υπάρχει φως για να μπορεί να δει κάτι: αν ο παίκτης βρίσκεται στο σκοτάδι, το level count είναι 0 και το ceiling είναι τίποτα.

Τέλος, σημειώστε ότι αρκετές ενέργειες πέρα από το 'κοίτα' παράγουν επίσης περιγραφές δωματίου σε ορισμένες περιπτώσεις. Η πιο συνηθισμένη είναι το 'πήγαινε', αλλά το να βγει κάποιος από ένα κιβώτιο ή να κατεβεί από έναν υποστηρικτή θα δημιουργήσει επίσης μια περιγραφή δωματίου. (Η φράση που χρησιμοποιείται από τους σχετικούς κανόνες είναι 'produce a room description with going spacing conventions', και οι κανόνες 'carry out' ή 'report' για νέες ενέργειες μπορούν επίσης να τη χρησιμοποιήσουν, αν το επιθυμούν. Οι συμβάσεις διαστήματος επηρεάζουν τη διαίρεση των παραγράφων, και σημειώστε ότι η κύρια περιγραφή της παραγράφου μπορεί να παραλειφθεί για έναν χώρο που δεν είναι νεο-επισκεπτόμενος, ανάλογα με τις ρυθμίσεις VERBOSE.) Περιγραφές δωματίου όπως αυτή παράγονται εκτελώντας τους κανόνες 'check', 'carry out' και 'report' του 'looking', αλλά δεν υπόκεινται στους κανόνες 'before', 'instead' ή 'after': συνεπώς, δεν θεωρούνται νέες ενέργειες. Η μεταβλητή 'room-describing action' του 'κοίτα' διατηρεί το όνομα της ενέργειας που προκάλεσε τη δημιουργία μιας περιγραφής δωματίου: αν ο παίκτης πληκτρολόγησε LOOK, αυτή θα έχει την τιμή της ενέργειας 'κοίτα', αλλά αν περιγράφουμε ένα δωμάτιο στο οποίο μόλις φτάσαμε μέσω 'πήγαινε ανατολικά', για παράδειγμα, θα έχει την τιμή της ενέργειας 'πήγαινε'. Αυτό μπορεί να χρησιμοποιηθεί για να προσαρμόσουμε τους κανόνες 'carry out looking' ώστε να χρησιμοποιούνται διαφορετικές μορφές περιγραφής κατά την είσοδο σε ένα δωμάτιο σε σύγκριση με την περιήγηση ενώ ο παίκτης βρίσκεται ήδη εκεί."

The specification of the examining action is "Η πράξη του να κοιτάζει κανείς προσεκτικά κάτι. Σημειώστε ότι το noun μπορεί να είναι είτε μια κατεύθυνση είτε ένα αντικείμενο, γι' αυτό οι Standard Rules περιλαμβάνουν τον 'examine directions rule' για να διαχειρίζονται τις κατευθύνσεις: απλώς λέει 'You see nothing unexpected in that direction.' και σταματά την ενέργεια. (Αν θέλετε να διαχειριστείτε τις κατευθύνσεις διαφορετικά, προσθέστε έναν άλλο κανόνα στη θέση αυτού στους carry out examining rules.)

Ορισμένα αντικείμενα δεν έχουν την ιδιότητα 'description', ή μάλλον, έχουν μόνο ένα κενό κείμενο ως περιγραφή. Είναι πιθανό να ειπωθεί κάτι ενδιαφέρον ούτως ή άλλως (δείτε τους κανόνες για κατευθύνσεις, containers, supporters και devices), αλλά αν όχι, τότε εγκαταλείπουμε με μια τυπική απάντηση. Αυτό γίνεται από τον 'examine undescribed things rule'."

The specification of the looking under action is "Το τυπικό μοντέλο κόσμου του Inform δεν περιλαμβάνει την έννοια των αντικειμένων που βρίσκονται κάτω από άλλα αντικείμενα, επομένως αυτή η ενέργεια παρέχεται μόνο ελάχιστα από τους Standard Rules. Ωστόσο, υπάρχει για παραδοσιακούς λόγους (και επειδή, τελικά, η εντολή 'κοίτα κάτω από το τραπέζι' είναι από αυτές που θα έπρεπε να αναγνωρίζονται, ακόμη κι αν δεν έχουν κάποια χρησιμότητα).

Η ενέργεια αυτή συνήθως είτε πληροφορεί τον παίκτη ότι δεν βρίσκει κάτι ενδιαφέρον είτε αναφέρει ότι κάποιος άλλος κοίταξε κάτω από κάτι.

Ο συνηθισμένος τρόπος να δώσουμε κάποια χρησιμότητα σε αυτήν την ενέργεια είναι να γράψουμε έναν κανόνα όπως 'Instead of looking under the cabinet for the first time: now the player has the silver key; say ...' και ούτω καθεξής."

The specification of the searching action is "Η ενέργεια 'searching' επιτρέπει την εξέταση του περιεχομένου ενός ανοιχτού ή διαφανούς περιέκτη, ή των αντικειμένων που βρίσκονται πάνω σε μια επιφάνεια. Συχνά αυτά αναφέρονται ήδη στις περιγραφές των δωματίων, καθιστώντας την ενέργεια περιττή. Ωστόσο, αυτό δεν ισχύει για κάτι όπως ένα ντουλάπι κουζίνας που θεωρείται μέρος του σκηνικού – αναφέρεται εν συντομία σε μια περιγραφή δωματίου, αλλά δεν δίνεται έμφαση στην ύπαρξή του. Η αναζήτηση σε ένα τέτοιο ντουλάπι, καταγράφοντας το περιεχόμενό του, παρέχει στον παίκτη περισσότερες πληροφορίες από ό,τι η απλή περιγραφή του δωματίου.

Οι συνήθεις 'check' κανόνες περιορίζουν την ενέργεια αυτή σε περιέκτες και επιφάνειες: έτσι, οι Standard Rules δεν επιτρέπουν την αναζήτηση πάνω σε ανθρώπους, για παράδειγμα. Ωστόσο, είναι εύκολο να προστεθούν 'instead' κανόνες ('Instead of searching Dr Watson: ...') ή ακόμη και νέοι 'carry out' κανόνες ('Check searching someone (called the suspect): ...') ώστε να επεκταθεί η τυπική λειτουργία της αναζήτησης."

The specification of the consulting it about action is "Η ενέργεια 'συμβουλεύσου' είναι μια πολύ ευέλικτη και δυνητικά ισχυρή ενέργεια, αλλά μόνο επειδή αφήνει σχεδόν όλη τη δουλειά στον συγγραφέα να την καθορίσει άμεσα. Η ιδέα είναι να ανταποκρίνεται σε εντολές όπως 'διάβασε σχετικά με τον HENRY FITZROY στο βιβλίο ιστορίας', όπου το θέμα θα είναι το απόσπασμα της εντολής HENRY FITZROY και το αντικείμενο θα είναι το βιβλίο.

Τα Standard Rules απλώς αποφεύγουν τέτοιες εντολές λέγοντας ότι ο παίκτης δεν βρίσκει κάτι ενδιαφέρον. Όλες οι ενδιαφέρουσες αποκρίσεις πρέπει να παρέχονται από τον συγγραφέα, χρησιμοποιώντας κανόνες όπως 'Instead of consulting the history book about...'"



Chapter 4.5.4 - Standard actions which change the state of things

The specification of the locking it with action is "Το 'κλείδωσε' είναι η πράξη της χρήσης ενός αντικειμένου, όπως ένα κλειδί, για να διασφαλιστεί ότι κάτι, όπως μια πόρτα ή ένα κιβώτιο, δεν μπορεί να ανοιχθεί εκτός αν ξεκλειδωθεί πρώτα. (Μόνο κλειστά αντικείμενα μπορούν να κλειδωθούν.)

Το κλείδωμα μπορεί να εκτελεστεί σε οποιοδήποτε είδος αντικειμένου που παρέχει τις δυαδικές ιδιότητες lockable, locked, openable και open. Ο κανόνας 'can't lock without a lock rule' ελέγχει αν το noun παρέχει την ιδιότητα lockable και αν είναι πράγματι κλειδωσιμό. Θεωρείται τότε ότι οι υπόλοιπες ιδιότητες μπορούν να ελεγχθούν με ασφάλεια. Στα Standard Rules, οι κατηγορίες κιβώτιο και πόρτα ικανοποιούν αυτές τις προϋποθέσεις.

Μπορούμε να δημιουργήσουμε ένα νέο είδος στο οποίο οι ενέργειες opening, closing, locking και unlocking θα λειτουργούν ως εξής: 'A briefcase is a kind of thing. A briefcase can be openable. A briefcase can be open. A briefcase can be lockable. A briefcase can be locked. A briefcase is usually openable, lockable, open and unlocked.'

Το Inform ελέγχει αν το κλειδί ταιριάζει χρησιμοποιώντας τον κανόνα 'can't lock without the correct key rule'. Για να ικανοποιηθεί αυτός ο κανόνας, ο ηθοποιός πρέπει να κρατά απευθείας το second noun, και αυτό πρέπει να είναι η τρέχουσα τιμή της ιδιότητας 'matching key' για το noun. (Αυτή η ιδιότητα σπάνια αναφέρεται άμεσα, καθώς ορίζεται αυτόματα με δηλώσεις όπως 'The silver key unlocks the wicket gate.')

Οι Standard Rules παρέχουν τις ενέργειες locking και unlocking σε αρκετά βασικό επίπεδο: μπορούν να επεκταθούν σημαντικά με τη χρήση της επέκτασης Locksmith από την Emily Short, η οποία περιλαμβάνεται σε όλες τις διανομές του Inform."

[ TODO: Continue from here ]


Chapter 4.5.5 - Standard actions concerning other people

Chapter 4.5.6 - Standard actions which are checked but then do nothing unless rules intervene

Chapter 4.5.7 - Standard actions which always do nothing unless rules intervene

Part 4.6 - Command parser internals

Include (-
Constant AGAIN1__WD     = 'ξανά';
Constant AGAIN2__WD     = 'πάλι';
Constant AGAIN3__WD     = 'again';
Constant OOPS1__WD      = 'λάθος';
Constant OOPS2__WD      = 'σφάλμα';
Constant OOPS3__WD      = 'ουπς';
Constant UNDO1__WD      = 'ακύρωση';
Constant UNDO2__WD      = 'αναίρεση';
Constant UNDO3__WD      = 'undo';

Constant ALL1__WD       = 'όλοι';
Constant ALL2__WD       = 'όλες';
Constant ALL3__WD       = 'όλα';
Constant ALL4__WD       = 'everything';
Constant ALL5__WD       = 'both';
Constant AND1__WD       = 'και';
Constant AND2__WD       = 'κι';
Constant AND3__WD       = 'and';
Constant BUT1__WD       = 'αλλά';
Constant BUT2__WD       = 'εκτός_από';
Constant BUT3__WD       = 'όμως';
Constant BY__WD         = 'από';
Constant ME1__WD        = 'εγώ';
Constant ME2__WD        = 'εμένα';
Constant ME3__WD        = 'με';
Constant OF1__WD        = 'of';
Constant OF2__WD        = 'of';
Constant OF3__WD        = 'of';
Constant OF4__WD        = 'of';
Constant OTHER1__WD     = 'another';
Constant OTHER2__WD     = 'other';
Constant OTHER3__WD     = 'other';
Constant THEN1__WD      = 'έπειτα';
Constant THEN2__WD      = 'μετά';
Constant THEN3__WD      = 'τότε';

Constant NO1__WD        = 'όχι';
Constant NO2__WD        = 'ο//';
Constant NO3__WD        = 'οχι';
Constant YES1__WD       = 'ναι';
Constant YES2__WD       = 'ν//';
Constant YES3__WD       = 'yes';

Constant AMUSING__WD    = 'amusing';
Constant FULLSCORE1__WD = 'αποτέλεσμα';
Constant FULLSCORE2__WD = 'βαθμολογία';
Constant QUIT1__WD      = 'τέλος';
Constant QUIT2__WD      = 'ΤΕΛΟΣ';
Constant RESTART__WD    = 'επανεκκίνηση';
Constant RESTORE__WD    = 'επαναφορά';
-) replacing "Vocabulary".

Part 4.7 - Informese translation of commands

Include (-
[ IsAnA c;
	! αά + κεφαλαία
	if ((c == 'α' or 'Α' or 'ά' or 'Ά') || (c == 'a' or 'A') || (c > 191 && c < 199) || (c > 223 && c < 231)) return true;
	return false;
];
[ IsAnE c;
	! εέ + κεφαλαία
	if ((c == 'ε' or 'Ε' or 'έ' or 'Έ') || (c == 'e' or 'E') || (c > 199 && c < 204) || (c > 231 && c < 236)) return true;
	return false;
];
[ IsAnI c;
	! ιί + κεφαλαία
	if ((c == 'ι' or 'Ι' or 'ί' or 'Ί') || (c == 'i' or 'I') || (c > 203 && c < 208) || (c > 235 && c < 240)) return true;
	return false;
];
[ IsAnO c;
	! οό + κεφαλαία
	if ((c == 'ο' or 'Ο' or 'ό' or 'Ό') || (c == 'o' or 'O') || (c > 209 && c < 215) || (c == 216 or 248 or 338 or 339) || (c > 241 && c < 247)) return true;
	return false;
];
[ IsAnU c;
	! υύ + κεφαλαία
	if ((c == 'υ' or 'Υ' or 'ύ' or 'Ύ') || (c == 'u' or 'U') || (c > 216 && c < 221) || (c > 248 && c < 253)) return true;
	return false;
];
-)

Include [preform](-
language Greek
<grammatical-case-names> ::=
	nominative | accusative [ TODO: Προσθήκη γενικής ]

<noun-declension> ::=
	*    <gr-noun-declension-group> <gr-noun-declension-tables>

<gr-noun-declension-group> ::=
	*            1

<gr-noun-declension-tables> ::=
	<gr-noun-declension-uninflected>

<gr-noun-declension-uninflected> ::=
	0 | 0 |   [Singular | Plural]
	0 | 0


<article-declension> ::=
	*           <gr-article-declension>

<gr-article-declension> ::=
	the         ο    η    το  |  [Singular]
	            τον  την  το  |
	            του  της  του  |
	the         οι   οι   τα  |  [Plural]
	            τους τις τα  |
	            των  των  των
-) in the Preform grammar.

Part 5 - Unindexed sections of translation

Include [preform](-
language Greek

<s-literal-truth-state> ::=
	μύθος |
	αλήθεια

<s-literal-real-number> ::=
	_ πι |
	_ e |
	συν άπειρο |
	μείον άπειρο |
	<literal-real-in-digits>

-) in the Preform grammar.


Greek Language ends here.

---- DOCUMENTATION ----

Section: Παρουσίαση

Section: Εγκατάσταση

Section: Συγγραφή της ιστορίας σας στα ελληνικά

Με αυτή την επέκταση, είναι δυνατό (αλλά όχι υποχρεωτικό) να γράψετε μέρος του κώδικά σας στα ελληνικά, δηλαδή την αρχική κατάσταση του κόσμου και τις συνθήκες. Για παράδειγμα:

	κουζίνα είναι ένα δωμάτιο.
	[ TODO: Add the article ]

[ TODO: Πρέπει είτε να δημιουργηθούν κανόνες για την αναγνώριση του γένους μιας λέξης, ειδάλλως θα πρέπει να ζητείται από τον παίκτη να εισάγει (m), (f), ή (n) (ή αντίστοιχα στα ελληνικά) για να μπορεί να κατανοήσει το Inform το γένος της λέξης]

Ακολουθεί μια λίστα με αντιστοιχία ελληνικών - αγγλικών όρων που αφορούν το συγκεκριμένο extension:

	αντικείμενο -> object
	δωμάτιο -> room
	πράγμα -> thing
	πόρτα -> door
	δοχείο -> container
	όχημα -> vehicle
	τσάντα του παίκτη -> player's holdall
	στήριγμα -> supporter
	παρασκήνιο -> backdrop
	άτομο -> person
	άντρας -> man
	γυναίκα -> woman
	ζώτο -> animal
	συσκευή -> device
	κατεύθυνση -> direction
	περιοχή -> region
	αριθμός -> number
	πραγματικός αριθμός -> real number
	ώρα -> time
	αλήθεια -> truth state
	κείμενο -> text
	χαρακτήρας unicode  -> unicode character
	απόσπασμα -> snippet
	αποθηκευμένη ενέργεια -> stored action


