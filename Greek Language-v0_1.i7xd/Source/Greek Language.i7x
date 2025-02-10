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


Part 1.1 SR Hack - Greek Bibliographical Data (in place of Section 7 - Unindexed Standard Rules variables in Standard Rules)

[ TODO: Does it work? ]
[ Check with:
Section 3.5.1 - The bibliographical data - Unindexed (in place of Section SR2/6a - Unindexed Standard Rules variables - Unindexed in Standard Rules by Graham Nelson) ]
The story title, the story author, the story headline, the story genre and the story description are text variables. [*****]
The release number and the story creation year are number variables. [**]

The release number is usually 1.
The story headline is usually "Ένα διαδραστικό μυθιστόρημα".
The story genre is usually "Ιστορία".

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
			say " (σχετικά με το [the intermediate level])" (B);
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

The specification of person is "Παρά το όνομά του, δεν είναι απαραίτητα άνθρωπος, αλλά οποιαδήποτε οντότητα με τις απαραίτητες λειτουργίες για να αλληλεπιδράσει μαζί του".

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

To say ο/η/το/οι/τα (O - object):
	say "[the O]".

To say ένας/μία/ένα (O - object):[Το αόριστο άρθρο δεν έχει πληθυντικό στα ελληνικά]
	say "[a O]".

To say Ο/Η/Το/Οι/Τα (O - object):
	say "[The O]".

To say Ένας/Μία/Ένα (O - object):
	say "[A O]".


Include (-
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 2;     ! English has two:
                                           ! 0 = starting with a consonant
                                           ! 1 = starting with a vowel

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
! ];
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

In Greek, we will use second person singular as well.
]

The adaptive text viewpoint of the Greek language is second person singular.

When play begins (this is the initialise the story viewpoint rule):
	now the story viewpoint is the second person singular.

To say εσύ:
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

To say Εσύ:
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

To say εσάς:
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

To say Εσάς:
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

To say δικό σου:
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

To say Δικό σου:
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

To say τον εαυτό σου:
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

To say τον εαυτό σου:
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

To say σου:
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

To say Σου:
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

[ TODO: Continue from here based on French]
Chapter 2.2.2 - Pronouns and possessives for other objects

[ TODO: Change the following to Greek ]

To say those:
	say those in the αιτιατική.

To say Those:
	say Those in the ονομαστική.

[ TODO: Translate and continue the following, based on English ]

To say those in (case - grammatical case):
	if the case is nominative:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "those";
		otherwise if the item is the player:
			say "[εσύ]";
		otherwise if the item is a male person and item is not neuter:
			say "he";
		otherwise if the item is a female person and item is not neuter:
			say "she";
		otherwise:
			say "that";

Chapter 2.2.3 - Directions

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

Understand "ανατολικά" or "ανατολικα" or "α" as ανατολή.
Understand "βόρεια" or "βορεια" or "β" as βοράς.
Understand "δυτικά" or "δυτικα" or "δ" as δύση.
Understand "νότια" or "νοτια" or "νό" as νότος.
Understand "να" as νοτιοανατολικά.
Understand "νδ" as νοτιοδυτικά.
Understand "βα" as βορειοανατολικά.
Understand "βδ" as βορειοδυτικά.
Understand "μ" or "μεσα" or "εσωτερικά" or "εσωτερικα" as μέσα.
Understand "εξωτερικά" as έξω.

Chapter 2.2.4 - Kinds

Section 2.2.4.1 - In the Standard Rules

An object translates into Greek as ένα αντικείμενο.
A room translates into Greek as ένα δωμάτιο.
A thing translates into Greek as ένα πράγμα.
A door translates into Greek as μια πόρτα.
A container translates into Greek as ένα δοχείο.
A vehicle translates into Greek as ένα όχημα.
A player's holdall translates into Greek as μια τσάντα του παίκτη.
A supporter translates into Greek as ένας υποστηρικτής.
A backdrop translates into Greek as μια παρασκήνιο. The plural of παρασκήνιο is παρασκήνια. [TODO: check translation]
A person translates into Greek as ένα άτομο.
A man translates into Greek as ένας άντρας.
A woman translates into Greek as μια γυναίκα.
An animal translates into Greek as ένα ζώο.
A device translates into Greek as μια συσκευή.
A direction translates into Greek as μια κατεύθυνση.
A region translates into Greek as μια περιοχή.

A number translates into Greek as ένας αριθμός.
A real number translates into Greek as ένας πραγματικός αριθμός.
A time translates into Greek as μια ώρα.
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
Grammatical tense translates into Greek as γραμματικός χρόνος.
Present tense translates into Greek as ο ενεστώτας.
Future tense translates into Greek as ο μέλλοντας.
Past tense translates into Greek as ο παρελθοντικός.
Perfect tense translates into Greek as ο αόριστος.
Past perfect tense translates into Greek as ο υπερσυντέλικος.

Narrative viewpoint translates into Greek as αφηγηματική σκοπιά.
First person singular translates into Greek as το πρώτο πρόσωπο του ενικού.
Second person singular translates into Greek as το δεύτερο πρόσωπο του ενικού.
Third person singular translates into Greek as το τρίτο πρόσωπο του ενικού.
First person plural translates into Greek as το πρώτο πρόσωπο του πληθυντικού.
Second person plural translates into Greek as το δεύτερο πρόσωπο του πληθυντικού.
Third person plural translates into Greek as το τρίτο πρόσωπο του πληθυντικού.

Grammatical gender translates into Greek as γραμματικό γένος.
Masculine gender translates into Greek as το αρσενικό γένος.
Feminine gender translates into Greek as το θηλυκό γένος.
Neuter gender translates into Greek as το ουδέτερο γένος.

[ TODO: Add index descriptions ]

Chapter 2.2.5 - Plurals

[ TODO: Can't make the following work ]

Include [preform](-
language Greek
<singular-noun-to-its-plural> ::=
	<gr-plural-exceptions> |
	... <gr-plural-by-ending> |
	... <gr-plural-default>

<gr-plural-exceptions> ::=
	μυς			μυς |
	πρέσβης		πρέσβεις |
	πρύτανης	πρυτάνεις |

<gr-plural-by-ending> ::=
	*ας			1ες |			[χάρακας --> χάρακες] [TODO: Add ψαράς --> ψαράδες]
	*ης			1ες	|		[επιβάτης --> επιβάτες]
	*ΗΣ			1ΕΣ	|		[επιβάτης --> επιβάτες]
	*ής			1ές			[μαθητής --> μαθητές]

<gr-plural-default> ::=
	*			0ς

-) in the Preform grammar.

Chapter 2.2.6 - Cases

Chapter 2.2.7 - Times of day

Include (-
[ LanguageTimeOfDay hours mins i;
    i = hours%12;
    if (i == 0) i = 12;
    if (i < 10) print " ";
    print i, ":", mins/10, mins%10;
    if ((hours/12) > 0) print " μ.μ."; else print " π.μ.";
];
-) replacing "Time".

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

Πώς λειτουργεί η δομή Preform για τα ρήματα στα ελληνικά:

<verb-conjugation-instructions>: Ορίζουμε την κατηγορία κλίσης στην οποία ανήκει κάθε ρήμα. Για παράδειγμα, τα ρήματα λύνω, βάφω, κάνω έχουν την ίδια κλίση, ενώ το ρήμα "είμαι" είναι ανώμαλο ρήμα.

Σημείωση: Όπου παρακάτω αναφέρεται μέλλοντας, αναφερόμαστε στον συνοπτικό μέλλοντα.

<gr-"ρήμα ή κατηγορία"-conjugation> ::=
	2	<μετοχή ενεστώτα> |
	3	<απαρέμφατο αορίστου>????
	<gr-"ρήμα ή κατηγορία"-tabulation>

[slot 5 we use for the stem of the verb]

Κλίση ρήματος ή κατηγορίας:
<gr-"ρήμα ή κατηγορία"-tabulation> ::=
	a1+		<gr-ρήμα-ενεστώτας> |
	a1-		άρνηση <gr-ρήμα-ενεστώτας> |
	a2+		<gr-ρήμα-παρατατικός> |
	a2-		άρνηση <gr-ρήμα-παρατατικός> |
	a3+		<gr-ρήμα-παρακείμενος> 3 |
	a3- 	άρνηση <gr-ρήμα-παρακείμενος> 3 |
	a4+		<gr-ρήμα-υπερσυντέλικος> 3 |
	a4-		άρνηση <gr-ρήμα-υπερσυντέλικος> 3 |
	a5+		<gr-ρήμα-μέλλοντας> |
	a5-		άρνηση <gr-ρήμα-μέλλοντας> |
	a6+		 <gr-ρήμα-αόριστος> |
	a6-		άρνηση <gr-ρήμα-αόριστος> |
	[ p* TODO: Figure out what is its purpose ]


Τέλος, ακολουθεί η κλίση για κάθε χρόνο, π.χ.:

<gr-be-present> ::=
    είμαι | είσαι | είναι | είμαστε | είστε | είναι

]

[ TODO: Change from imperative to imperfect... ]

<verb-conjugation-instructions> ::=
	-είμαι <gr-be-conjugation> |
	-έχω <gr-have-conjugation> |
	-μπορώ <gr-can-conjugation> |
	-λύνω <gr-lyno-conjugation> |
	-βλέπω <gr-vlepo-conjugation> |
	-δω <gr-na-do-conjugation> |
	-πάω <gr-na-paw-conjugation> |
	-κρατάω <gr-kratao-conjugation> |
	-χτυπάω <gr-xtypao-conjugation> |
	-παίρνω <gr-pairno-conjugation> |
	-πάρω <gr-na-paro-conjugation> |

	[ TODO: αφήνω ή βάζω,  ]

[ "Είμαι" ]

<gr-be-conjugation> ::=
    <gr-be-tabulation>

<gr-be-tabulation> ::=
    a1+ <gr-be-present> |
    a1- δεν <gr-be-present> |
    a2+ <gr-be-past> |
    a2- δεν <gr-be-past> |
    a5+ <gr-be-future> |
    a5- δεν <gr-be-future>

<gr-be-present> ::=
    είμαι | είσαι | είναι | είμαστε | είστε | είναι

<gr-be-past> ::=
    ήμουν | ήσουν | ήταν | ήμασταν | ήσασταν | ήταν

<gr-be-future> ::=
    θα είμαι | θα είσαι | θα είναι | θα είμαστε | θα είστε | θα είναι


[ "Έχω" ]

<gr-have-conjugation> ::=
    <gr-have-tabulation>

<gr-have-tabulation> ::=
    a1+ <gr-have-present> |
    a1- δεν <gr-have-present> |
    a2+ <gr-have-past> |
    a2- δεν <gr-have-past> |
    a5+ <gr-have-future> |
    a5- δεν <gr-have-future>

<gr-have-present> ::=
    έχω | έχεις | έχει | έχουμε | έχετε | έχουν

<gr-have-past> ::=
    είχα | είχες | είχε | είχαμε | είχατε | είχαν

<gr-have-future> ::=
    θα έχω | θα έχεις | θα έχει | θα έχουμε | θα έχετε | θα έχουν


[ "Μπορώ" ]

<gr-can-conjugation> ::=
    5       μπορ |
    6       5 |
    <gr-can-tabulation>

<gr-can-tabulation> ::=
    a1+ 	<gr-can-present> |
    a1- 	δεν <gr-can-present> |
    a2+ 	<gr-can-past> |
    a2- 	δεν <gr-can-past> |
    a4+ 	<gr-can-imperfect> |
    a4- 	δεν <gr-can-imperfect> |
	a5+ 	θα <gr-can-future> |
    a5- 	δεν θα <gr-can-future>

<gr-can-present> ::=
    μπορώ | μπορείς | μπορεί | μπορούμε | μπορείτε | μπορούν

<gr-can-past> ::=
    μπορούσα | μπορούσες | μπορούσε | μπορούσαμε | μπορούσατε | μπορούσαν

<gr-can-future> ::=
    μπορώ | μπορείς | μπορεί | μπορούμε | μπορείτε | μπορούν

<gr-can-imperfect> ::=
    μπορούσα | μπορούσες | μπορούσε | μπορούσαμε | μπορούσατε | μπορούσαν


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


[ TODO: Complete the chapter ]

To say adapt (V - a verb) for background/bg:
	say "[adapt V]".

To say negate (V - a verb) for background/bg:
	say "[negate V]".

Chapter 2.4.3 - Meaningful verbs

Section 2.4.3.1 - In the Standard Rules

Chapter 2.4.4 - Prepositions

Chapter 2.4.5 - Meaningless verbs

In Greek είμαι is a verb.
In Greek έχω is a verb.
In Greek μπορώ is a verb.
In Greek βλέπω is a verb.
In Greek δω is a verb.
In Greek πάω is a verb.
In Greek κρατάω is a verb.
In Greek παίρνω is a verb.
In Greek πάρω is a verb.

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

you-can-also-see rule response (A) is "[Εσύ] ".
you-can-also-see rule response (B) is "Πάνω σε [the domain], [εσύ] ".
you-can-also-see rule response (C) is "Μέσα σε [the domain], [εσύ] ".
you-can-also-see rule response (D) is "[regarding the player][adapt the verb μπορώ] επίσης να [adapt the verb δω in present tense] ".
[ TODO: Adapt the verb μπορώ ]
you-can-also-see rule response (E) is "[regarding the player][adapt the verb μπορώ] να [adapt the verb δω in present tense] ".
you-can-also-see rule response (F) is "".

Section 3.1.1.3 - Printing a locale paragraph about a thing

use initial appearance in room descriptions rule response (A) is "Πάνω σε [the item], ".
describe what's on scenery supporters in room descriptions rule response (A) is "Πάνω σε [the item], ".

Section 3.1.1.4 - Standard actions concerning the actor's possessions

[Taking inventory]
print empty inventory rule response (A) is "[Εσύ] δεν [adapt the verb κρατάω] τίποτα.".
print standard inventory rule response (A) is "[Εσύ] [adapt the verb κρατάω] :[line break]".
report other people taking inventory rule response (A) is "[The actor] [adapt the verb βλέπω in present tense] τα υπάρχοντά [σου].".

[Taking]

[ TODO: Test the following, see French example ]
can't take yourself rule response (A) is "Δεν [adapt the verb μπορώ in present tense] να [adapt the verb πάρω in present tense] [τον εαυτό σου]".
[ TODO: Change the following ]
can't take other people rule response (A) is "[We] [don't] suppose [the noun] [would care] for that.".
[ TODO: Continue from here ]


standard report taking rule response (A) is "Πάρθηκε.".
standard report taking rule response (B) is "[The actor] [adapt the verb παίρνω] [the noun].".
[ TODO: Continue from here ]

[Removing it from]

[Dropping]
can't drop what's already dropped rule response (A) is "[The noun] [adapt the verb είμαι] ήδη [εδώ].".
[ TODO: Fix the following ]
can't drop what's not held rule response (A) is "[Εσύ] δεν [adapt the verb έχω] [regarding the noun][those].".

standard report dropping rule response (A) is "Αφέθηκε.".
standard report dropping rule response (B) is "[The actor] [put] down [the noun].".

[Putting it on]
can't put something on itself rule response (A) is "[We] [can't put] something on top of itself.".

[Inserting it into]

[Eating]

Section 3.1.1.5 - Standard actions which move the actor

[Going , Entering , Exiting , Getting off]

[ Going ]

can't go that way rule response (A) is "[Εσύ] [negate the verb μπορώ for bg] να [adapt the verb πάω in present tense] προς αυτή την κατεύθυνση".

can't go that way rule response (B) is "[Εσύ] [negate the verb μπορώ for bg] να [adapt the verb πάω in present tense] προς τα εκεί".

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

[Closing]

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

parser error internal rule response (N) is "Αυτό δεν είναι ένα από τα ρήματα που καταλαβαίνω.".
parser error internal rule response (T) is "Δεν μπορείς να ξεκινήσεις την πρόταση με κόμμα.".
parser error internal rule response (U) is "Φαίνεται ότι θες να μιλήσεις σε κάποιον, αλλά δε μπορώ να καταλάβω σε ποιον.".


parser error internal rule response (X) is "Συγγνώμη;".

darkness name internal rule response (A) is "Σκοτάδι".

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

Understand "μπες σε [something]" as entering.
Understand the command "μπεσ" as "μπες".

Understand "βγες" as exiting.
Understand the command "βγεσ" as "βγες".

Understand "βγες από [something]" as getting off.
Understand the command "κατέβα" and "κατεβα" as "βγες".

Chapter 4.2.4 - Standard actions concerning the actor's vision

Understand "κοίτα" as looking.
Understand the command "κοιτα", "δες", "δεσ" as "κοίτα".

Understand "εξέτασε [something]" as examining.
Understand the command "εξετασε", "τσέκαρε", "τσεκαρε" as "εξέτασε".

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

Understand "ξύπνα" or "σήκω" as waking up.
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
Understand the command "ανέβα" as "σκαρφάλωσε".

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

Chapter 4.5.2 - Standard actions which move the actor

Chapter 4.5.3 - Standard actions concerning the actor's vision

Chapter 4.5.4 - Standard actions which change the state of things

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

Greek Language ends here.

---- DOCUMENTATION ----

Section: Παρουσίαση

Section: Εγκατάσταση