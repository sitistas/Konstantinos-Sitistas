# Greek Language Extension for Inform 7 / Επέκταση Ελληνικής Γλώσσας για το Inform 7

---

## **English**

This repository contains the source code for a comprehensive [Greek language extension](Greek%20Language-v0_1.i7xd/) for the modern version of the **Inform 7** authoring system (specifically for the unreleased version 10.2.0 and later). This project was developed as part of a diploma thesis for the Department of Electrical and Computer Engineering at the University of Patras.

The primary goal of this extension is the complete **Hellenization of the Inform 7**, enabling both players and authors to interact with and create Interactive Fiction in Modern Greek.

### **Key Features**

* **Full Greek Parser:** Understands a wide range of Greek commands (e.g., `εξέτασε το βιβλίο`, `πήγαινε βόρεια`) including synonyms and abbreviations.
* **Translated System Messages:** The entire library of approximately 400 standard game responses has been translated into natural-sounding Greek.
* **Advanced Grammatical Support:**
    * Automatic pluralization of nouns based on complex declension rules (`-ος` -> `-οι`, `-α` -> `-ες`, etc.) using Preform `tries`.
    * Correct inflection of adjectives according to the gender and number of the noun they describe.
    * A robust verb conjugation system for regular and irregular verbs across different tenses and persons.
* **Adaptive Text:** Makes extensive use of Inform 7's adaptive text capabilities to ensure grammatical consistency in dynamically generated text (e.g., correct use of articles and pronouns).

### **Requirements**

Due to technical challenges with Unicode support in the official builds, this extension **requires compiling the latest version of Inform 7 from its source code**.

---

## **Ελληνικά**

Το παρόν αποθετήριο περιέχει τον πηγαίο κώδικα για μια [ελληνική γλωσσική επέκταση](Greek%20Language-v0_1.i7xd/) για τη σύγχρονη έκδοση του συστήματος συγγραφής **Inform 7** (συγκεκριμένα για την ακυκλοφόρητη έκδοση 10.2.0 και μεταγενέστερες). Το έργο αυτό υλοποιήθηκε στα πλαίσια διπλωματικής εργασίας για το Τμήμα Ηλεκτρολόγων Μηχανικών και Τεχνολογίας Υπολογιστών του Πανεπιστημίου Πατρών.

Ο κύριος στόχος της επέκτασης είναι ο πλήρης **εξελληνισμός του Inform 7**, δίνοντας τη δυνατότητα σε παίκτες και συγγραφείς να αλληλεπιδρούν και να δημιουργούν Διαδραστική Μυθοπλασία στα ελληνικά.

### **Βασικά Χαρακτηριστικά**

* **Πλήρης Ελληνικός Parser:** Κατανοεί ένα ευρύ φάσμα ελληνικών εντολών (π.χ., `εξέτασε το βιβλίο`, `πήγαινε βόρεια`), συμπεριλαμβανομένων συνωνύμων και συντομογραφιών.
* **Μεταφρασμένα Μηνύματα Συστήματος:** Ολόκληρη η βιβλιοθήκη των περίπου 400 τυπικών απαντήσεων του παιχνιδιού έχει μεταφραστεί σε φυσικά ελληνικά.
* **Προηγμένη Γραμματική Υποστήριξη:**
    * Αυτόματος σχηματισμός πληθυντικού των ουσιαστικών βάσει σύνθετων κανόνων κλίσης (`-ος` -> `-οι`, `-α` -> `-ες`, κ.λπ.) με χρήση `tries` της Preform.
    * Ορθή κλίση επιθέτων ώστε να συμφωνούν σε γένος και αριθμό με το ουσιαστικό που περιγράφουν.
    * Ένα στιβαρό σύστημα κλίσης ρημάτων για ομαλά και ανώμαλα ρήματα σε διάφορους χρόνους και πρόσωπα.
* **Προσαρμοστικό Κείμενο (Adaptive Text):** Εκτεταμένη χρήση των δυνατοτήτων του Inform 7 για τη διασφάλιση γραμματικής συνέπειας σε δυναμικά παραγόμενο κείμενο (π.χ. σωστή χρήση άρθρων και αντωνυμιών).

### **Απαιτήσεις**

Λόγω τεχνικών προκλήσεων με την υποστήριξη Unicode στις επίσημες εκδόσεις, η παρούσα επέκταση **απαιτεί τη μεταγλώττιση της τελευταίας έκδοσης του Inform 7 από τον πηγαίο του κώδικα**.

## **Documentation**

Για λεπτομέρειες σχετικά με την εγκατάσταση και τη χρήση της επέκτασης, ανατρέξτε στο έγγραφο [Documentation.md](Greek%20Language-v0_1.i7xd/Documentation/Documentation.md).

---
