Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560A32B1BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKMNgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:36:55 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:55224 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgKMNgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:36:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 42067135A;
        Fri, 13 Nov 2020 14:36:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1605274606; x=1607089007;
         bh=JQN0RYwDs6e+HKrdiOe7tOryex0oEI0osiuMn9jOxmE=; b=GcFlASrGCq4E
        4VelU8M1UoZp+D/Aydqfef2PStn0pUJYjEs9cx8CWGIfA9nlUiNZiFETYpFsbXWW
        ri9+GTmhk8xM3bHt5Trg3lEW5ngFbKtcJP/o3lZWvG+in3rC+NmbFECvH2fCnxqg
        DXGYXFzmAGS2or+M7/bYn1xYeZUIOfkg8BkAcqfzM1jKRrMJAk8b1ywAZV+JzMEV
        bYaQR2aiathVuvRMTJ5xe9gNlQLOtlG/F3BrWq0Z2gV66cLigoPKV9Y9WKttbB3h
        jHCmD9LTbbAxs+WIQYCXfDUJfA0zZnNHqHX9fvji88n4ne43ZMXfUzQ9qguhf1YQ
        KiQHiDoP7RpzlDkvxGCqNN5Nj0QXTnFgquJrQFyStaWTx42cbyKzXaSwpW0llwVw
        00H6NrikLikvjxfqYvSslQmqmjBvWWenRn5GzN7DAl6/L6LxRQbf7q1Aryt+tD3Y
        qFgI5dRPRO1JGfzmT04O0xh0de8ILpo5Wi59C7IXlN1h0SmlYHS+7Yav2cSrVUs6
        msM9LqYO6bsvV7a+VHg674/FgCIVKEccg00OhxoOapV+v8LqaEULFauwOQf1DT0s
        Te12fXn+Mi9iFP2gkrOgkaZ2xQzlEhSMercFMkfjq1zWIfKSiaOdWSWw3EaTqDqR
        GggMz3btFu/7Dq68A0bCSmes+Xmjhh8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GjMV7ycQXF3y; Fri, 13 Nov 2020 14:36:46 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 1662C1356;
        Fri, 13 Nov 2020 14:36:45 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id A517B2C0E;
        Fri, 13 Nov 2020 14:36:45 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v2] doc:it_IT: align Italian documentation
Date:   Fri, 13 Nov 2020 14:36:38 +0100
Message-Id: <20201113133638.7989-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit 905705a8fd43 ("docs: programming-languages: refresh blurb on clang support")
commit 5ff4aa70bf34 ("docs: submitting-patches: use :doc: for references")
commit 030f066f677f ("docs: submitting-patches: describe preserving review/test tags")
commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element arrays")
commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")
commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST format")
commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")
commit c170f2eb9648 ("docs: Document cross-referencing between documentation pages")
commit 7c8b9e3000f8 ("kernel-doc: Update "cross-referencing from rST" section to use automarkup")
commit 27def953b63b ("docs: deprecated.rst: Expand str*cpy() replacement notes")
commit 17dca0502314 ("docs: deprecated.rst: Update zero-length/one-element arrays section")
commit 3519c4d6e08e ("Documentation: add minimum clang/llvm version")
commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
commit 9f364b605f34 ("submitting-patches.rst: presume git will be used")
commit 4ebdf7be21d6 ("Documentation/maintainer: rehome sign-off process")
commit 7433ff33e8ba ("Documentation/process: expand plain-text advice")
commit eb45fb2fb16d ("docs: process: Add cross-link to security-bugs")
commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
commit f67281a72b30 ("Documentation: process: step 2: Link to email list fixed")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/doc-guide/kernel-doc.rst            |  30 +-
 .../translations/it_IT/doc-guide/sphinx.rst   |  20 ++
 .../translations/it_IT/process/2.Process.rst  |   4 +-
 .../translations/it_IT/process/changes.rst    |  18 +-
 .../it_IT/process/coding-style.rst            |  26 +-
 .../translations/it_IT/process/deprecated.rst | 147 ++++++++-
 .../it_IT/process/email-clients.rst           |   5 +
 .../it_IT/process/programming-language.rst    |   8 +-
 .../it_IT/process/submitting-patches.rst      | 295 +++++-------------
 9 files changed, 292 insertions(+), 261 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 524ad86cadbb..009cdac014b6 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -419,26 +419,24 @@ del `dominio Sphinx per il C`_.
 Riferimenti usando reStructuredText
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Per fare riferimento a funzioni e tipi di dato definiti nei commenti kernel-doc
-all'interno dei documenti reStructuredText, utilizzate i riferimenti dal
-`dominio Sphinx per il C`_. Per esempio::
+Nei documenti reStructuredText non serve alcuna sintassi speciale per
+fare riferimento a funzioni e tipi definiti nei commenti
+kernel-doc. Sarà sufficiente terminare i nomi di funzione con ``()``,
+e scrivere ``struct``, ``union``, ``enum``, o ``typedef`` prima di un
+tipo. Per esempio::
 
-  See function :c:func:`foo` and struct/union/enum/typedef :c:type:`bar`.
+  See foo()
+  See struct foo.
+  See union bar.
+  See enum baz.
+  See typedef meh.
 
-Nonostante il riferimento ai tipi di dato funzioni col solo nome,
-ovvero senza specificare struct/union/enum/typedef, potreste preferire il
-seguente::
+Tuttavia, la personalizzazione dei collegamenti è possibile solo con
+la seguente sintassi::
 
-  See :c:type:`struct foo <foo>`.
-  See :c:type:`union bar <bar>`.
-  See :c:type:`enum baz <baz>`.
-  See :c:type:`typedef meh <meh>`.
+  See :c:func:`my custom link text for function foo <foo>`.
+  See :c:type:`my custom link text for struct bar <bar>`.
 
-Questo produce dei collegamenti migliori, ed è in linea con il modo in cui
-kernel-doc gestisce i riferimenti.
-
-Per maggiori informazioni, siete pregati di consultare la documentazione
-del `dominio Sphinx per il C`_.
 
 Commenti per una documentazione generale
 ----------------------------------------
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index f1ad4504b734..090d2949d345 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -364,6 +364,26 @@ Che verrà rappresentata nel seguente modo:
 
         - column 3
 
+Riferimenti incrociati
+----------------------
+
+Per fare dei riferimenti incrociati da una pagina ad un'altra
+specificando il percorso a partire dalla cartella *Documentation*.
+Per esempio, se volete aggiungere un riferimento a questa pagina
+(l'estensione .rst è opzionale)::
+
+    See Documentation/translations/it_IT/doc-guide/sphinx.rst.
+
+Se preferite usare un percorso relative allora vi serve la direttiva
+Sphinx ``doc``.  Per esempio, se volete aggiungere un riferimento a
+questa pagina dalla stessa cartella::
+
+    See :doc:`sphinx`.
+
+Per maggiori informazioni su come aggiungere riferimenti incrociati a
+commenti kernel-doc di funzioni o tipi, leggete
+Documentation/translations/it_IT/doc-guide/sphinx.rst.
+
 .. _it_sphinx_kfigure:
 
 Figure ed immagini
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 30dc172f06b0..62826034e0b2 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -123,7 +123,7 @@ iniziale, i kernel ricevono aggiornamenti per più di un ciclo di sviluppo.
 Quindi, per esempio, la storia del kernel 5.2 appare così (anno 2019):
 
 	==============  ===============================
-	15 settembre	5.2 rilascio stabile FIXME settembre è sbagliato
+	 7 luglio	5.2 rilascio stabile
 	14 luglio	5.2.1
 	21 luglio	5.2.2
 	26 luglio	5.2.3
@@ -434,7 +434,7 @@ l'elenco principale lo si trova sul sito:
 	http://vger.kernel.org/vger-lists.html
 
 Esistono liste gestite altrove; un certo numero di queste sono in
-lists.redhat.com.
+redhat.com/mailman/listinfo.
 
 La lista di discussione principale per lo sviluppo del kernel è, ovviamente,
 linux-kernel.  Questa lista è un luogo ostile dove trovarsi; i volumi possono
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 02da4408983d..cc883f8d96c4 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -32,7 +32,8 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 ====================== =================  ========================================
         Programma       Versione minima       Comando per verificare la versione
 ====================== =================  ========================================
-GNU C                  4.6                gcc --version
+GNU C                  4.9                gcc --version
+Clang/LLVM (optional)  10.0.1             clang --version
 GNU make               3.81               make --version
 binutils               2.23               ld -v
 flex                   2.5.35             flex --version
@@ -71,6 +72,16 @@ GCC
 La versione necessaria di gcc potrebbe variare a seconda del tipo di CPU nel
 vostro calcolatore.
 
+Clang/LLVM (opzionale)
+----------------------
+
+L'ultima versione di clang e *LLVM utils* (secondo `releases.llvm.org
+<https://releases.llvm.org>`_) sono supportati per la generazione del
+kernel. Non garantiamo che anche i rilasci più vecchi funzionino, inoltre
+potremmo rimuovere gli espedienti che abbiamo implementato per farli
+funzionare. Per maggiori informazioni
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
 Make
 ----
 
@@ -338,6 +349,11 @@ gcc
 
 - <ftp://ftp.gnu.org/gnu/gcc/>
 
+Clang/LLVM
+----------
+
+- :ref:`Getting LLVM <getting_llvm>`.
+
 Make
 ----
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index a346f1f2ce21..c86c4543f249 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -92,16 +92,22 @@ delle righe.
 Lo stile del codice riguarda la leggibilità e la manutenibilità utilizzando
 strumenti comuni.
 
-Il limite delle righe è di 80 colonne e questo e un limite fortemente
-desiderato.
-
-Espressioni più lunghe di 80 colonne saranno spezzettate in pezzi più piccoli,
-a meno che eccedere le 80 colonne non aiuti ad aumentare la leggibilità senza
-nascondere informazioni.  I pezzi derivati sono sostanzialmente più corti degli
-originali e vengono posizionati più a destra.  Lo stesso si applica, nei file
-d'intestazione, alle funzioni con una lista di argomenti molto lunga. Tuttavia,
-non spezzettate mai le stringhe visibili agli utenti come i messaggi di
-printk, questo perché inibireste la possibilità d'utilizzare grep per cercarle.
+Come limite di riga si preferiscono le 80 colonne.
+
+Espressioni più lunghe di 80 colonne dovrebbero essere spezzettate in
+pezzi più piccoli, a meno che eccedere le 80 colonne non aiuti ad
+aumentare la leggibilità senza nascondere informazioni.
+
+I nuovi pezzi derivati sono sostanzialmente più corti degli originali
+e vengono posizionati più a destra. Uno stile molto comune è quello di
+allineare i nuovi pezzi alla parentesi aperta di una funzione.
+
+Lo stesso si applica, nei file d'intestazione, alle funzioni con una
+lista di argomenti molto lunga.
+
+Tuttavia, non spezzettate mai le stringhe visibili agli utenti come i
+messaggi di printk, questo perché inibireste la possibilità
+d'utilizzare grep per cercarle.
 
 3) Posizionamento di parentesi graffe e spazi
 ---------------------------------------------
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index a642ff3fdc8b..07c79d4bafca 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -95,6 +95,11 @@ Invece, usate la seguente funzione::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+.. note:: Se per caso state usando struct_size() su una struttura dati che
+	  in coda contiene un array di lunghezza zero o uno, allora siete
+	  invitati a riorganizzare il vostro codice usando il
+	  `flexible array member <#zero-length-and-one-element-arrays>`_.
+
 Per maggiori dettagli fate riferimento a array_size(),
 array3_size(), e struct_size(), così come la famiglia di
 funzioni check_add_overflow() e check_mul_overflow().
@@ -116,7 +121,11 @@ di destinazione. Questo può portare ad un overflow oltre i limiti del
 buffer e generare svariati tipi di malfunzionamenti. Nonostante l'opzione
 `CONFIG_FORTIFY_SOURCE=y` e svariate opzioni del compilatore aiutano
 a ridurne il rischio, non c'è alcuna buona ragione per continuare ad usare
-questa funzione. La versione sicura da usare è strscpy().
+questa funzione. La versione sicura da usare è strscpy(), tuttavia va
+prestata attenzione a tutti quei casi dove viene usato il valore di
+ritorno di strcpy().  La funzione strscpy() non ritorna un puntatore
+alla destinazione, ma un contatore dei byte non NUL copiati (oppure
+un errno negativo se la stringa è stata troncata).
 
 strncpy() su stringe terminate con NUL
 --------------------------------------
@@ -127,8 +136,12 @@ causati, appunto, dalla mancanza del terminatore. Questa estende la
 terminazione nel buffer di destinazione quando la stringa d'origine è più
 corta; questo potrebbe portare ad una penalizzazione delle prestazioni per
 chi usa solo stringe terminate. La versione sicura da usare è
-strscpy(). (chi usa strscpy() e necessita di estendere la
-terminazione con NUL deve aggiungere una chiamata a memset())
+strscpy(), tuttavia va prestata attenzione a tutti quei casi dove
+viene usato il valore di ritorno di strncpy().  La funzione strscpy()
+non ritorna un puntatore alla destinazione, ma un contatore dei byte
+non NUL copiati (oppure un errno negativo se la stringa è stata
+troncata). Tutti i casi che necessitano di estendere la
+terminazione con NUL dovrebbero usare strscpy_pad().
 
 Se il chiamate no usa stringhe terminate con NUL, allore strncpy()
 può continuare ad essere usata, ma i buffer di destinazione devono essere
@@ -140,7 +153,10 @@ strlcpy()
 La funzione strlcpy(), per prima cosa, legge interamente il buffer di
 origine, magari leggendo più di quanto verrà effettivamente copiato. Questo
 è inefficiente e può portare a overflow di lettura quando la stringa non è
-terminata con NUL. La versione sicura da usare è strscpy().
+terminata con NUL. La versione sicura da usare è strscpy(), tuttavia
+va prestata attenzione a tutti quei casi dove viene usato il valore di
+ritorno di strlcpy(), dato che strscpy() ritorna un valore di errno
+negativo quanto la stringa viene troncata.
 
 Segnaposto %p nella stringa di formato
 --------------------------------------
@@ -227,3 +243,126 @@ modi:
 * ``continue;``
 * ``goto <label>;``
 * ``return [expression];``
+
+Array di lunghezza zero o con un solo elemento
+----------------------------------------------
+All'interno del kernel ricorre spesso la necessita di avere membri
+di dimensione variabile all'interno di una struttura dati. In questi
+casi il codice del kernel dovrebbe usare sempre i `"flexible array
+member" <https://en.wikipedia.org/wiki/Flexible_array_member>`_. La
+tecnica degli array a lunghezza nulla o di un solo elemento non
+dovrebbe essere più usata.
+
+Nel codice C più vecchio, la dichiarazione di un membro di dimensione
+variabile in coda ad una struttura dati veniva fatto dichiarando un
+array di un solo elemento posizionato alla fine della struttura dati::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+Questo ha portato ad un calcolo di sizeof() traballante (dovrebbe
+rimuovere la dimensione del singolo elemento in coda per calcolare la
+dimensione esatta dell' "intestazione"). Per evitare questi problemi è
+stata introdotta un' `estensione a GNU C
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_ che
+permettesse la dichiarazione di array a lungezza zero::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+Ma questo ha portato nuovi problemi, e non ha risolto alcuni dei
+problemi che affliggono entrambe le tecniche: per esempio
+l'impossibilità di riconoscere se un array di quel tipo viene usato
+nel mezzo di una struttura dati e _non_ alla fine (potrebbe accadere
+sia direttamente, sia indirettamente quando si usano le unioni o le
+strutture di strutture).
+
+Lo standard C99 introduce i "flexible array members". Questi array non
+hanno una dimensione nella loro dichiarazione::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+Questo è il modo con cui ci si aspetta che vengano dichiarati gli
+elementi di lunghezza variabile in coda alle strutture dati.  Permette
+al compilatore di produrre errori quando gli array flessibili non si
+trovano alla fine della struttura dati, il che permette di prevenire
+alcuni tipi di bachi dovuti a `comportamenti inaspettati
+<https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_.
+Inoltre, permette al compilatore di analizzare correttamente le
+dimensioni degli array (attraverso sizeof(), `CONFIG_FORTIFY_SOURCE`,
+e `CONFIG_UBSAN_BOUNDS`). Per esempio, non esiste alcun meccanismo in
+grado di avvisarci che il seguente uso di sizeof() dia sempre come
+zero come risultato::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+Il valore di ``size`` nell'ultima riga sarà ``zero``, quando uno
+invece si aspetterebbe che il suo valore sia la dimensione totale in
+byte dell'allocazione dynamica che abbiamo appena fatto per l'array
+``items``. Qui un paio di esempi reali del problema: `collegamento 1
+<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
+`collegamento 2
+<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
+Invece, `i flexible array members hanno un tipo incompleto, e quindi
+sizeof() non può essere applicato
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_; dunque ogni
+uso scorretto di questo operatore verrà identificato immediatamente
+durante la compilazione.
+
+Per quanto riguarda gli array di un solo elemento, bisogna essere
+consapevoli che `questi array occupano almeno quanto lo spazio di un
+singolo oggetti dello stesso tipo
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_, e quindi
+contribuiscono al calcolo della dimensione della struttura che li
+contiene. In questo caso è facile commettere errori quando si vuole
+calcolare la dimensione totale della memoria totale da allocare per
+una struttura dati::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count - 1), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+In questo esempio ci siamo dovuti ricordare di usare ``count - 1`` in
+struct_size(), altrimenti avremmo --inavvertitamente-- allocato
+memoria per un oggetti ``items`` in più. Il modo più pulito e meno
+propenso agli errori è quello di usare i `flexible array member`, in
+combinazione con struct_size() e flex_array_size()::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+	memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index ccdededb56c6..b792f2f06a74 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -32,6 +32,11 @@ impostato come ``text/plain``.  Tuttavia, generalmente gli allegati non sono
 ben apprezzati perché rende più difficile citare porzioni di patch durante il
 processo di revisione.
 
+Inoltre, è vivamente raccomandato l'uso di puro testo nel corpo del
+messaggio, sia per la patch che per qualsiasi altro messaggio. Il sito
+https://useplaintext.email/ può esservi d'aiuto per configurare il
+vostro programma di posta elettronica.
+
 I programmi di posta elettronica che vengono usati per inviare le patch per il
 kernel Linux dovrebbero inviarle senza alterazioni.  Per esempio, non
 dovrebbero modificare o rimuovere tabulazioni o spazi, nemmeno all'inizio o
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
index c4fc9d394c29..41db2598ce11 100644
--- a/Documentation/translations/it_IT/process/programming-language.rst
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -11,13 +11,15 @@ Linguaggio di programmazione
 Il kernel è scritto nel linguaggio di programmazione C [it-c-language]_.
 Più precisamente, il kernel viene compilato con ``gcc`` [it-gcc]_ usando
 l'opzione ``-std=gnu89`` [it-gcc-c-dialect-options]_: il dialetto GNU
-dello standard ISO C90 (con l'aggiunta di alcune funzionalità da C99)
+dello standard ISO C90 (con l'aggiunta di alcune funzionalità da C99).
+Linux supporta anche ``clang`` [it-clang]_, leggete la documentazione
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
 Questo dialetto contiene diverse estensioni al linguaggio [it-gnu-extensions]_,
 e molte di queste vengono usate sistematicamente dal kernel.
 
-Il kernel offre un certo livello di supporto per la compilazione con ``clang``
-[it-clang]_ e ``icc`` [it-icc]_ su diverse architetture, tuttavia in questo momento
+Il kernel offre un certo livello di supporto per la compilazione con
+``icc`` [it-icc]_ su diverse architetture, tuttavia in questo momento
 il supporto non è completo e richiede delle patch aggiuntive.
 
 Attributi
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 7c23c08e4401..8aa2865ec6cc 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -16,21 +16,19 @@ vostre patch accettate.
 
 Questo documento contiene un vasto numero di suggerimenti concisi.  Per
 maggiori dettagli su come funziona il processo di sviluppo del kernel leggete
-:ref:`Documentation/translations/it_IT/process <it_development_process_main>`.
-Leggete anche :ref:`Documentation/translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`
-per una lista di punti da verificare prima di inviare del codice.  Se state
-inviando un driver, allora leggete anche :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`;
-per delle patch relative alle associazioni per Device Tree leggete
-Documentation/devicetree/bindings/submitting-patches.rst.
-
-Molti di questi passi descrivono il comportamento di base del sistema di
-controllo di versione ``git``; se utilizzate ``git`` per preparare le vostre
-patch molto del lavoro più ripetitivo lo troverete già fatto per voi, tuttavia
-dovete preparare e documentare un certo numero di patch.  Generalmente, l'uso
-di ``git`` renderà la vostra vita di sviluppatore del kernel più facile.
-
-0) Ottenere i sorgenti attuali
-------------------------------
+:doc:`development-process`.
+Leggete anche :doc:`submit-checklist` per una lista di punti da
+verificare prima di inviare del codice.  Se state inviando un driver,
+allora leggete anche :doc:`submitting-drivers`; per delle patch
+relative alle associazioni per Device Tree leggete
+:doc:`submitting-patches`.
+
+Questa documentazione assume che sappiate usare ``git`` per preparare le patch.
+Se non siete pratici di ``git``, allora è bene che lo impariate;
+renderà la vostra vita di sviluppatore del kernel molto più semplice.
+
+Ottenere i sorgenti attuali
+---------------------------
 
 Se non avete un repositorio coi sorgenti del kernel più recenti, allora usate
 ``git`` per ottenerli.  Vorrete iniziare col repositorio principale che può
@@ -45,69 +43,10 @@ Guardate l'elemento **T:** per un determinato sottosistema nel file MAINTANERS
 che troverete nei sorgenti, o semplicemente chiedete al manutentore nel caso
 in cui i sorgenti da usare non siano elencati il quel file.
 
-Esiste ancora la possibilità di scaricare un rilascio del kernel come archivio
-tar (come descritto in una delle prossime sezioni), ma questa è la via più
-complicata per sviluppare per il kernel.
-
-1) ``diff -up``
----------------
-
-Se dovete produrre le vostre patch a mano, usate ``diff -up`` o ``diff -uprN``
-per crearle.  Git produce di base le patch in questo formato; se state
-usando ``git``, potete saltare interamente questa sezione.
-
-Tutte le modifiche al kernel Linux avvengono mediate patch, come descritte
-in :manpage:`diff(1)`.  Quando create la vostra patch, assicuratevi di
-crearla nel formato "unified diff", come l'argomento ``-u`` di
-:manpage:`diff(1)`.
-Inoltre, per favore usate l'argomento ``-p`` per mostrare la funzione C
-alla quale si riferiscono le diverse modifiche - questo rende il risultato
-di ``diff`` molto più facile da leggere.  Le patch dovrebbero essere basate
-sulla radice dei sorgenti del kernel, e non sulle sue sottocartelle.
-
-Per creare una patch per un singolo file, spesso è sufficiente fare::
-
-	SRCTREE=linux
-	MYFILE=drivers/net/mydriver.c
-
-	cd $SRCTREE
-	cp $MYFILE $MYFILE.orig
-	vi $MYFILE	# make your change
-	cd ..
-	diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch
-
-Per creare una patch per molteplici file, dovreste spacchettare i sorgenti
-"vergini", o comunque non modificati, e fare un ``diff`` coi vostri.
-Per esempio::
-
-	MYSRC=/devel/linux
-
-	tar xvfz linux-3.19.tar.gz
-	mv linux-3.19 linux-3.19-vanilla
-	diff -uprN -X linux-3.19-vanilla/Documentation/dontdiff \
-		linux-3.19-vanilla $MYSRC > /tmp/patch
-
-``dontdiff`` è una lista di file che sono generati durante il processo di
-compilazione del kernel; questi dovrebbero essere ignorati in qualsiasi
-patch generata con :manpage:`diff(1)`.
-
-Assicuratevi che la vostra patch non includa file che non ne fanno veramente
-parte.  Al fine di verificarne la correttezza, assicuratevi anche di
-revisionare la vostra patch -dopo- averla generata con :manpage:`diff(1)`.
-
-Se le vostre modifiche producono molte differenze, allora dovrete dividerle
-in patch indipendenti che modificano le cose in passi logici;  leggete
-:ref:`split_changes`.  Questo faciliterà la revisione da parte degli altri
-sviluppatori, il che è molto importante se volete che la patch venga accettata.
-
-Se state utilizzando ``git``, ``git rebase -i`` può aiutarvi nel procedimento.
-Se non usate ``git``, un'alternativa popolare è ``quilt``
-<http://savannah.nongnu.org/projects/quilt>.
-
 .. _it_describe_changes:
 
-2) Descrivete le vostre modifiche
----------------------------------
+Descrivete le vostre modifiche
+------------------------------
 
 Descrivete il vostro problema. Esiste sempre un problema che via ha spinto
 ha fare il vostro lavoro, che sia la correzione di un baco da una riga o una
@@ -208,10 +147,15 @@ precedente::
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
+Un esempio::
+
+       $ git log -1 --pretty=fixes 54a4f0239f2e
+       Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+
 .. _it_split_changes:
 
-3) Separate le vostre modifiche
--------------------------------
+Separate le vostre modifiche
+----------------------------
 
 Separate ogni **cambiamento logico** in patch distinte.
 
@@ -312,7 +256,8 @@ sfruttato, inviatela a security@kernel.org.  Per bachi importanti, un breve
 embargo potrebbe essere preso in considerazione per dare il tempo alle
 distribuzioni di prendere la patch e renderla disponibile ai loro utenti;
 in questo caso, ovviamente, la patch non dovrebbe essere inviata su alcuna
-lista di discussione pubblica.
+lista di discussione pubblica. Leggete anche
+:doc:`/admin-guide/security-bugs`.
 
 Patch che correggono bachi importanti su un kernel già rilasciato, dovrebbero
 essere inviate ai manutentori dei kernel stabili aggiungendo la seguente riga::
@@ -354,8 +299,8 @@ Le patch banali devono rientrare in una delle seguenti categorie:
   "patch monkey" in modalità ritrasmissione)
 
 
-6) Niente: MIME, links, compressione, allegati.  Solo puro testo
-----------------------------------------------------------------
+Niente: MIME, links, compressione, allegati.  Solo puro testo
+-------------------------------------------------------------
 
 Linus e gli altri sviluppatori del kernel devono poter commentare
 le modifiche che sottomettete.  Per uno sviluppatore è importante
@@ -364,7 +309,11 @@ programmi di posta elettronica, cosicché sia possibile commentare
 una porzione specifica del vostro codice.
 
 Per questa ragione tutte le patch devono essere inviate via e-mail
-come testo.
+come testo. Il modo più facile, e quello raccomandato, è con ``git
+send-email``.  Al sito https://git-send-email.io è disponibile una
+guida interattiva sull'uso di ``git send-email``.
+
+Se decidete di non usare ``git send-email``:
 
 .. warning::
 
@@ -381,28 +330,20 @@ così la possibilità che il vostro allegato-MIME venga accettato.
 Eccezione: se il vostro servizio di posta storpia le patch, allora qualcuno
 potrebbe chiedervi di rinviarle come allegato MIME.
 
-Leggete :ref:`Documentation/translations/it_IT/process/email-clients.rst <it_email_clients>`
+Leggete :doc:`/translations/it_IT/process/email-clients`
 per dei suggerimenti sulla configurazione del programmi di posta elettronica
 per l'invio di patch intatte.
 
-7) Dimensione delle e-mail
---------------------------
-
-Le grosse modifiche non sono adatte ad una lista di discussione, e nemmeno
-per alcuni manutentori.  Se la vostra patch, non compressa, eccede i 300 kB
-di spazio, allora caricatela in una spazio accessibile su internet fornendo
-l'URL (collegamento) ad essa.  Ma notate che se la vostra patch eccede i 300 kB
-è quasi certo che necessiti comunque di essere spezzettata.
-
-8) Rispondere ai commenti di revisione
---------------------------------------
+Rispondere ai commenti di revisione
+-----------------------------------
 
-Quasi certamente i revisori vi invieranno dei commenti su come migliorare
-la vostra patch.  Dovete rispondere a questi commenti; ignorare i revisori
-è un ottimo modo per essere ignorati.  Riscontri o domande che non conducono
-ad una modifica del codice quasi certamente dovrebbero portare ad un commento
-nel changelog cosicché il prossimo revisore potrà meglio comprendere cosa stia
-accadendo.
+In risposta alla vostra email, quasi certamente i revisori vi
+invieranno dei commenti su come migliorare la vostra patch.  Dovete
+rispondere a questi commenti; ignorare i revisori è un ottimo modo per
+essere ignorati.  Riscontri o domande che non conducono ad una
+modifica del codice quasi certamente dovrebbero portare ad un commento
+nel changelog cosicché il prossimo revisore potrà meglio comprendere
+cosa stia accadendo.
 
 Assicuratevi di dire ai revisori quali cambiamenti state facendo e di
 ringraziarli per il loro tempo.  Revisionare codice è un lavoro faticoso e che
@@ -410,8 +351,12 @@ richiede molto tempo, e a volte i revisori diventano burberi.  Tuttavia, anche
 in questo caso, rispondete con educazione e concentratevi sul problema che
 hanno evidenziato.
 
-9) Non scoraggiatevi - o impazientitevi
----------------------------------------
+Leggete :doc:`/translations/it_IT/process/email-clients` per
+le raccomandazioni sui programmi di posta elettronica e l'etichetta da usare
+sulle liste di discussione.
+
+Non scoraggiatevi - o impazientitevi
+------------------------------------
 
 Dopo che avete inviato le vostre modifiche, siate pazienti e aspettate.
 I revisori sono persone occupate e potrebbero non ricevere la vostra patch
@@ -424,17 +369,19 @@ aver inviato le patch correttamente.  Aspettate almeno una settimana prima di
 rinviare le modifiche o sollecitare i revisori - probabilmente anche di più
 durante la finestra d'integrazione.
 
-10) Aggiungete PATCH nell'oggetto
----------------------------------
+Aggiungete PATCH nell'oggetto
+-----------------------------
 
 Dato l'alto volume di e-mail per Linus, e la lista linux-kernel, è prassi
 prefiggere il vostro oggetto con [PATCH].  Questo permette a Linus e agli
 altri sviluppatori del kernel di distinguere facilmente le patch dalle altre
 discussioni.
 
+``git send-email`` lo fa automaticamente.
 
-11) Firmate il vostro lavoro - Il certificato d'origine dello sviluppatore
---------------------------------------------------------------------------
+
+Firmate il vostro lavoro - Il certificato d'origine dello sviluppatore
+----------------------------------------------------------------------
 
 Per migliorare la tracciabilità su "chi ha fatto cosa", specialmente per
 quelle patch che per raggiungere lo stadio finale passano attraverso
@@ -477,65 +424,15 @@ poi dovete solo aggiungere una riga che dice::
 	Signed-off-by: Random J Developer <random@developer.example.org>
 
 usando il vostro vero nome (spiacenti, non si accettano pseudonimi o
-contributi anonimi).
+contributi anonimi). Questo verrà fatto automaticamente se usate ``git
+commit -s``.
 
 Alcune persone aggiungono delle etichette alla fine.  Per ora queste verranno
 ignorate, ma potete farlo per meglio identificare procedure aziendali interne o
 per aggiungere dettagli circa la firma.
 
-Se siete un manutentore di un sottosistema o di un ramo, qualche volta dovrete
-modificare leggermente le patch che avete ricevuto al fine di poterle
-integrare; questo perché il codice non è esattamente lo stesso nei vostri
-sorgenti e in quelli dei vostri contributori.  Se rispettate rigidamente la
-regola (c), dovreste chiedere al mittente di rifare la patch, ma questo è
-controproducente e una totale perdita di tempo ed energia.  La regola (b)
-vi permette di correggere il codice, ma poi diventa davvero maleducato cambiare
-la patch di qualcuno e addossargli la responsabilità per i vostri bachi.
-Per risolvere questo problema dovreste aggiungere una riga, fra l'ultimo
-Signed-off-by e il vostro, che spiega la vostra modifica.  Nonostante non ci
-sia nulla di obbligatorio, un modo efficace è quello di indicare il vostro
-nome o indirizzo email fra parentesi quadre, seguito da una breve descrizione;
-questo renderà abbastanza visibile chi è responsabile per le modifiche
-dell'ultimo minuto.  Per esempio::
-
-	Signed-off-by: Random J Developer <random@developer.example.org>
-	[lucky@maintainer.example.org: struct foo moved from foo.c to foo.h]
-	Signed-off-by: Lucky K Maintainer <lucky@maintainer.example.org>
-
-Questa pratica è particolarmente utile se siete i manutentori di un ramo
-stabile ma al contempo volete dare credito agli autori, tracciare e integrare
-le modifiche, e proteggere i mittenti dalle lamentele.  Notate che in nessuna
-circostanza è permessa la modifica dell'identità dell'autore (l'intestazione
-From), dato che è quella che appare nei changelog.
-
-Un appunto speciale per chi porta il codice su vecchie versioni.  Sembra che
-sia comune l'utile pratica di inserire un'indicazione circa l'origine della
-patch all'inizio del messaggio di commit (appena dopo la riga dell'oggetto)
-al fine di migliorare la tracciabilità.  Per esempio, questo è quello che si
-vede nel rilascio stabile 3.x-stable::
-
-  Date:   Tue Oct 7 07:26:38 2014 -0400
-
-    libata: Un-break ATA blacklist
-
-    commit 1c40279960bcd7d52dbdf1d466b20d24b99176c8 upstream.
-
-E qui quello che potrebbe vedersi su un kernel più vecchio dove la patch è
-stata applicata::
-
-    Date:   Tue May 13 22:12:27 2008 +0200
-
-        wireless, airo: waitbusy() won't delay
-
-        [backport of 2.6 commit b7acbdfbd1f277c1eb23f344f899cfa4cd0bf36a]
-
-Qualunque sia il formato, questa informazione fornisce un importante aiuto
-alle persone che vogliono seguire i vostri sorgenti, e quelle che cercano
-dei bachi.
-
-
-12) Quando utilizzare Acked-by:, Cc:, e Co-developed-by:
---------------------------------------------------------
+Quando utilizzare Acked-by:, Cc:, e Co-developed-by:
+----------------------------------------------------
 
 L'etichetta Signed-off-by: indica che il firmatario è stato coinvolto nello
 sviluppo della patch, o che era nel suo percorso di consegna.
@@ -604,8 +501,8 @@ Esempio di una patch sottomessa dall'autore Co-developed-by:::
 	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
 	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
-13) Utilizzare Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: e Fixes:
------------------------------------------------------------------------------
+Utilizzare Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: e Fixes:
+-------------------------------------------------------------------------
 
 L'etichetta Reported-by da credito alle persone che trovano e riportano i bachi
 e si spera che questo possa ispirarli ad aiutarci nuovamente in futuro.
@@ -654,6 +551,13 @@ revisori conosciuti per la loro conoscenza sulla materia in oggetto e per la
 loro serietà nella revisione, accrescerà le probabilità che la vostra patch
 venga integrate nel kernel.
 
+Quando si riceve una email sulla lista di discussione da un tester o
+un revisore, le etichette Tested-by o Reviewd-by devono essere
+aggiunte dall'autore quando invierà nuovamente la patch. Tuttavia, se
+la patch è cambiata in modo significativo, queste etichette potrebbero
+non avere più senso e quindi andrebbero rimosse. Solitamente si tiene traccia
+della rimozione nel changelog della patch (subito dopo il separatore '---').
+
 L'etichetta Suggested-by: indica che l'idea della patch è stata suggerita
 dalla persona nominata e le da credito. Tenete a mente che questa etichetta
 non dovrebbe essere aggiunta senza un permesso esplicito, specialmente se
@@ -669,8 +573,8 @@ Questo è il modo suggerito per indicare che un baco è stato corretto nella
 patch. Per maggiori dettagli leggete :ref:`it_describe_changes`
 
 
-14) Il formato canonico delle patch
------------------------------------
+Il formato canonico delle patch
+-------------------------------
 
 Questa sezione descrive il formato che dovrebbe essere usato per le patch.
 Notate che se state usando un repositorio ``git`` per salvare le vostre patch
@@ -788,8 +692,8 @@ Maggiori dettagli sul formato delle patch nei riferimenti qui di seguito.
 
 .. _it_explicit_in_reply_to:
 
-15) Usare esplicitamente In-Reply-To nell'intestazione
-------------------------------------------------------
+Usare esplicitamente In-Reply-To nell'intestazione
+--------------------------------------------------
 
 Aggiungere manualmente In-Reply-To: nell'intestazione dell'e-mail
 potrebbe essere d'aiuto per associare una patch ad una discussione
@@ -802,65 +706,6 @@ giungla di riferimenti all'interno dei programmi di posta.  Se un collegamento
 ad una versione precedente di una serie di patch (per esempio, potete usarlo
 per l'email introduttiva alla serie).
 
-16) Inviare richieste ``git pull``
-----------------------------------
-
-Se avete una serie di patch, potrebbe essere più conveniente per un manutentore
-tirarle dentro al repositorio del sottosistema attraverso l'operazione
-``git pull``.  Comunque, tenete presente che prendere patch da uno sviluppatore
-in questo modo richiede un livello di fiducia più alto rispetto a prenderle da
-una lista di discussione.  Di conseguenza, molti manutentori sono riluttanti
-ad accettare richieste di *pull*, specialmente dagli sviluppatori nuovi e
-quindi sconosciuti.  Se siete in dubbio, potete fare una richiesta di *pull*
-come messaggio introduttivo ad una normale pubblicazione di patch, così
-il manutentore avrà la possibilità di scegliere come integrarle.
-
-Una richiesta di *pull* dovrebbe avere nell'oggetto [GIT] o [PULL].
-La richiesta stessa dovrebbe includere il nome del repositorio e quello del
-ramo su una singola riga; dovrebbe essere più o meno così::
-
-  Please pull from
-
-      git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus
-
-  to get these changes:
-
-Una richiesta di *pull* dovrebbe includere anche un messaggio generico
-che dica cos'è incluso, una lista delle patch usando ``git shortlog``, e una
-panoramica sugli effetti della serie di patch con ``diffstat``.  Il modo più
-semplice per ottenere tutte queste informazioni è, ovviamente, quello di
-lasciar fare tutto a ``git`` con il comando ``git request-pull``.
-
-Alcuni manutentori (incluso Linus) vogliono vedere le richieste di *pull*
-da commit firmati con GPG; questo fornisce una maggiore garanzia sul fatto
-che siate stati proprio voi a fare la richiesta.  In assenza di tale etichetta
-firmata Linus, in particolare, non prenderà alcuna patch da siti pubblici come
-GitHub.
-
-Il primo passo verso la creazione di questa etichetta firmata è quello di
-creare una chiave GNUPG ed averla fatta firmare da uno o più sviluppatori
-principali del kernel.  Questo potrebbe essere difficile per i nuovi
-sviluppatori, ma non ci sono altre vie.  Andare alle conferenze potrebbe
-essere un buon modo per trovare sviluppatori che possano firmare la vostra
-chiave.
-
-Una volta che avete preparato la vostra serie di patch in ``git``, e volete che
-qualcuno le prenda, create una etichetta firmata col comando ``git tag -s``.
-Questo creerà una nuova etichetta che identifica l'ultimo commit della serie
-contenente una firma creata con la vostra chiave privata.  Avrete anche
-l'opportunità di aggiungere un messaggio di changelog all'etichetta; questo è
-il posto ideale per descrivere gli effetti della richiesta di *pull*.
-
-Se i sorgenti da cui il manutentore prenderà le patch non sono gli stessi del
-repositorio su cui state lavorando, allora non dimenticatevi di caricare
-l'etichetta firmata anche sui sorgenti pubblici.
-
-Quando generate una richiesta di *pull*, usate l'etichetta firmata come
-obiettivo.  Un comando come il seguente farà il suo dovere::
-
-  git request-pull master git://my.public.tree/linux.git my-signed-tag
-
-
 Riferimenti
 -----------
 
-- 
2.20.1


