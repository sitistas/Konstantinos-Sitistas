Version 0.1 of Greek Language by Konstantinos Sitistas begins here.

"To make Greek the language of play."

Use authorial modesty.

Volume 1 - Settings

The language of play is the Greek language.

An object has a grammatical gender.

The grammatical gender of a woman is usually feminine gender.
The grammatical gender of an object is usually neuter gender.

Volume 2 - Language

Part 2.1 - Determiners

Chapter 2.1.1 - Articles

To say ο/η/το/οι/τα (O - object):
	say "[the O]".

[ Include [preform](-
language Greek)

<definite-article> ::=
    /b/ un |				[singular, masculine]
	/c/ une |				[singular, feminine]
	/e/ des					[plural, masculine (by default)]

-) in the Preform grammar. ]

[ Include (-
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 2;     ! English has two:
                                           ! 0 = starting with a consonant
                                           ! 1 = starting with a vowel
! Πρέπει να αλλαχθεί και για τα ελληνικά αντίστοιχα

[ LanguageContraction text
    ch;
    #Iftrue CHARSIZE == 1;
    ch = text->0;
    #Ifnot;
    ch = text-->0;
    #Endif; ! CHARSIZE
    if (ch == 'a' or 'e' or 'i' or 'o' or 'u'
           or 'A' or 'E' or 'I' or 'O' or 'U') return 1;
    return 0;
];

Array LanguageArticles -->

 !   Contraction form 0:     Contraction form 1:
 !   Cdef   Def    Indef     Cdef   Def    Indef

     "O "   "o "   "enas "   "O "   "o "   "enas "        ! Articles 0
     "The " "the " "some "   "The " "the " "some ";       ! Articles 1

                   !             a           i
                   !             s     p     s     p
                   !             m f n m f n m f n m f n

Array LanguageGNAsToArticles --> 0 0 0 1 1 1 0 0 0 1 1 1;

-) replacing "Articles". ]

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

-) in the Preform grammar.

Include (-
Array LanguageNumbers table
    'ένα' 1 'δύο' 2 'τρία' 3 'τέσσερα' 4 'πέντε' 5
    'έξι' 6 'επτά' 7 'οκτώ' 8 'εννέα' 9 'δέκα' 10
    'έντεκα' 11 'δώδεκα' 12 'δεκατρία' 13 'δεκατέσσερα' 14 'δεκαπέντε' 15
    'δεκαέξι' 16 'δεκαεπτά' 17 'δεκαοκτώ' 18 'δεκαεννέα' 19 'είκοσι' 20
    'είκοσι ένα' 21 'είκοσι δύο' 22 'είκοσι τρία' 23 'είκοσι τέσσερα' 24
	'είκοσι πέντε' 25 'είκοσι έξι' 26 'είκοσι επτά' 27 'είκοσι οκτώ' 28
	'είκοσι εννέα' 29 'τριάντα' 30
;
-)

Volume 3 - Responses

Part 3.1 - Responses

Chapter 3.1.1 - In the Standard Rules

Section 3.1.1.1 - The final question

Section 3.1.1.2 - Standard actions which move the actor

[Going , Entering , Exiting , Getting off]

[ Going ]

    can't go that way rule response (A) is "Δεν μπορείς να πας προς αυτή την κατεύθυνση".

    can't go that way rule response (B) is "Δεν μπορείς να πας τα εκεί".

Volume 4 - Command parsing

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
Constant BUT2__WD       = 'εκτός από';
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
Constant NO2__WD        = 'ό//';
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

Greek Language ends here.

