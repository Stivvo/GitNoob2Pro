\newcommand{\links}[1]{{\color{blue}\underline{#1}}}
\newcommand{\link}[2]{\href{#1}{\links{#2}}}
\newcommand{\reff}[1]{\links{\ref{#1}}}

\pagebreak

# Cos'è un sistema di controllo di versione {#sec:vercontrol}

Nella realizzazione di un progetto software potresti esserti accorto di voler tenere traccia dei
tuoi progressi, magari registrandoli in modo da sapere cosa hai fatto e quando, o di voler tornare
al momento esattamente prima a quella modifica che non fa funzionare più nulla.

Potresti provare, ogni volta che apporti modifiche importanti, a creare una nuova copia del
progetto, numerarla e magari annotarti quali cambiamenti ha portato. Man mano che il progetto
avanza, le copie possono diventare moltissime e serve comunque confrontare i file riga per riga per
capire cosa cambia da una copia all'altra.

Se al progetto lavorano più persone (e quindi carichi il progetto su drive) non è comunque possibile
che modifichino il codice nello stesso momento. Se ognuno modifica una copia diversa, queste vanno
poi unite sempre a mano con dei copia e incolla.

Un sistema di controllo di versione tiene traccia di tutte le modifiche effettuate ad un insieme di
file (che compongono il progetto), di chi le ha fatte, quando, quali righe sono state tolte e quali
aggiunte. Ogni registrazione di modifica è associata ad un titolo e ad una descrizione che la
spiega in dettaglio, in modo da facilitarne la comprensione ad altri sviluppatori e la rilettura in
futuro è possibile tornare a qualsiasi punto della storia del progetto.

Per permettere a più persone di lavorare nello stesso momento, ognuno copia in locale il progetto da
un punto di riferimento (server comune ad esempio), e dopo aver apportato le modifiche necessarie è
possibile caricarle sul server e unirle a quelle degli altri tenendo traccia di chi ha modificato
cosa ed in quale ordine.

Esistono molti software di controllo versione, tra i più famosi ci sono Git, CVS, Subversion,
Mercurial, Bazaar e BitKeeper.

# Il sistema di controllo versione Git {#sec:git}

Git è il sistema di controllo versione più utilizzato, ed è anche uno dei più semplici da usare. é
nato nel 2005 ed è stato ideato da Linus Torvalds (il creatore di Linux) per facilitare lo sviluppo
del kernel di Linux, uno dei progetti opensource più grandi, a cui lavorano moltissime persone.
Anche git è opensource. è scritto principalmente in C e shell.

Git è __distribuito__, ciò significa che l'intero __repository__, ovvero tutti i file che compongono
un progetto, tra cui sorgenti, readme e file creati da git per tenere traccia dello storico delle
modifiche può essere memorizzato su un server a cui possono accedere tutti i membri del progetto.
Allo stesso tempo ognuno può tenere una copia completa del del repository in locale e utilizzare
tutte le funzionalità di git anche __offline__. L'interazione col server è limiata a quando lo
sviluppatore desidera scaricare le modifiche effettuate da altri o vuole caricare le proprie sul
server.

Il server viene spesso fornito da una __piattaforma di hosting__. Le più famose sono GitHub, GitLab,
BitBuckets e Gitea. è tuttavia possibile creare un proprio server git.

Git è nato come un programma a riga di comando, e anche se viene considerato più efficiente quando
utilizzato in questo modo, oggi esistono molti client grafici ed estensioni che permettono di
usufruire della maggior parte delle funzionalità di git direttamente dagli IDE.

# Branching {#sec:branching}

Git è in grado di gestire contemporaneamente più sviluppi all'interno della stessa copia del
progetto, questi si chiamano __branch__. Con più sviluppi si intendono più tipologie di modifiche
differenti anche all'interno dello stesso file. Si può saltare da uno sviluppo all'altro senza
perdere nessuna modifica evitando di avere più copie del progetto.

Ogni repository git possiede almeno un branch, chiamato __master__. Possono essere creati infiniti
branch, ognuno dei quali può essere utilizzato per la realizzazione di una particolare funzionalità,
in modo che modifiche su parti molto diverse del codice non possano causare conflitti. Spesso un
singolo sviluppatore lavora su un proprio branch, in modo da non dover gestire anche i cambiamenti
fatti da altri mentre svolge il suo compito.

Oppure il branch master può essere quello che viene distribuito agli utilizzatori del software
perchè considerato stabile, mentre gli altri possono essere sperimentali e dunque contenere bug o
modifiche che possono essere scartate senza compromettere tutto il resto.

A volte vari branch servono a separare versioni con funzionalità leggermente diverse dello stesso
software.

Un branch viene creato a partire da un altro. Dopo la creazione di un branch _figlio_ le modifiche
che nel tempo vengono apportate su questo rimangono completamente separate da quelle che
eventualmente continuano ad essere apportate sul padre. Se vengono creati più branch, almeno uno di
questi discende da master.

Ovviamente, due branch possono essere uniti tramite un __merge__. Gli algoritmi di merge confrontano
due branch riga per riga, manentendo quella appartenente al branch in cui è stata modificata a
partire della divisione tra i branch. Se però la stessa riga è stata cambiata in entrambi i branch
si crea un conflitto e git richiede all'utente di risolverlo a mano.

Si può passare in qualsiasi momento da un branch all'altro.

\pagebreak

# Comandi principali {#sec:comandi}

Git offre moltissimi comandi, ognuno dei quali svolge un piccolo insieme di funzionalità. Ogni
comando (in questa sezione tratteremo i principali) è sempre preceduto da ``git``. Ognuno può
accettare un diverso numero di argomenti e di opzioni (tratteremo le principali per ogni comando),
spesso precedute da un singolo o da un doppio meno. Gli argomenti e le opzioni dei comandi possono
essere combinati in moltissimi modi per ottenere il comportamento desiderato da git.

## init, clone {#sec:initClone}

Per creare un nuovo repository locale si utilizza init (stando all'interno della cartella del
progetto del quale si vuole tenere traccia):

```
$ git init prova
Inizializzato repository Git vuoto in /home/user/prova/.git/
```

Per copiare un intero repository remoto si utilizza clone. Viene scaricato solo il branch master, ma
una volta clonato si può accedere a tutti gli altri

```
$ git clone https://github.com/torvalds/linux.git
```

Per utilizzare tutti gli altri comandi, occorre posizionarsi all'interno della cartella del
repository, che viene creata in automatico da clone e init.

## Commit \label{commit} {#sec:commit}

Ogni volta che si fa una certa quantità di cambiamenti è utile fare un commit, ovvero segnare un
punto nello sviluppo a cui sarà sempre possibile tornare, quindi registrare e descrivere queste
modifiche.

```
$ git commit
```

Questo comando aprirà l'editor di default (vedere [@sec:configurazione]) di git. Nella prima riga va
scritto il titolo del commit, è pensato per contenere solo nomi e verbi al presente. La seconda si
lascia sempre vuota e dalla terza inizia la descrizione, che può essere molto lunga e dettagliata
per spiegare in modo discorsivo cosa si è fatto e se eventualmente ha causato dei problemi. é
consigliato mantenere il una lunghezza massima di 50 caratteri per il titolo e di 75 per il testo
del commit in modo da poter visualizzare l'output di ``git log`` ([@sec:log]) e ``git log
--oneline`` su uno split.

Un commit rimane sempre associato al proprio autore, riconoscibile da come ha configurato il punto
[@sec:configurazione], e all'orario in cui è stato fatto.

Tutte queste informazioni sono visibili con log.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/vimEditCommit.png}
\centering
\caption{scrittura del testo di un commit (sec. \ref{commit}) con vim}
\end{figure}
<!-- end latex -->

Se non si necessita di una descrizione si può utilizzare l'opzione ``-m`` "message":

```
$ git commit -m "add options page"
```

Ci sono varie teorie sulla lunghezza e il contenuto dei messaggi e delle descrizioni dei commit e su
_ogni quanto_ si debba committare. In genere un commit deve essere relativo ad un solo argomento e
non comprendere modifiche totalmente indipendenti tra di loro. I messaggi di commit non devono
essere generici (come _fix crash_) altrimenti col passare del tempo sarà impossibile capire cosa è
stato fatto senza controllare il codice.
\link{https://chris.beams.io/posts/git-commit/}{Questo} è un buon approfondimento dell'argomento.

``-s`` ( _signed_ ) aggiunge la firma dell'autore nella descrizione:

```
Signed-off-by: Stivvo entattis15@itsvinci.com
```

Infine, può capitare di essersi dimenticati di aggiungere un file, di aver effettuato il commit
troppo presto o di aver sbagliato la scrittura del messaggio. ``--amend`` permette di riscrivere il
commit.

## Add, restore, status {#sec:add}

I file coinvolti dal commit devono essere prima selezionati con add. In questo modo si entra nella
__staging area__ o index. è uno stato intermedio che sta prima del commit per tracciare le modifiche
momentanee in caso di più prove.

In un determinato momento, si può decidere di mettere le modifiche effettuate ad alcuni file nella
staging area per poi committarle, mentre quelle effettuate su altri lasciarle nello stadio
precedente, chiamato __working tree__, anche per diversi commit di fila; non verranno incluse in
alcun commit fino a quando non le si aggiungerà alla staging area. Capita spesso infatti di volere
dividere modifiche sovlte contemporaneamente su commit diversi.

Se ad esempio si modificano ``functions.cpp``, ``functions.hpp`` e ``main.cpp``:

```
$ git add functions.cpp functions.hpp
$ git commit -m "added get function"
```

In questo caso le modifiche di main.cpp non verranno aggiunte al commit ``added get function``.
Qualsiasi modifica effettuata su ``functions.cpp`` o ``functions.hpp`` dopo l'utilizzo di add
verrebbe anch'essa esclusa dal commit.

Add si comporta in modo indifferente sia per file appena creati che per le modifiche di file già
esistenti.

L'opzione ``-a`` "all" passata al comando di commit include automaticamente tutte le modifiche
attualmente pendenti.

Alcune opzioni utili per add:

+ ``-A`` aggiunge qualsiasi modifica all'area di staging
+ ``.`` come ``-A`` ma non aggiunge file eliminati
+ ``-u`` non aggiunge i nuovi file

__Restore__ annulla l'azione di add. Prende come parametri uno o più file e ha due funzionalità:

L'opzione ``--worktree`` riporta i file nel working tree (non sottoposti ad add) alle modifiche
dell'ultimo commit locale, anche se sono stati eliminati. ``--staged``, rimuove i file dalla
staging area. è possibile combinare entrambe le opzioni:

```
$ git commmit -m "new commit"
$ echo "newline" >> README.md
$ add README.md
$ echo "yet another line" >> README.md
$ git restore --worktree --staged README.md
$ git status
Sul branch master
non c'è nulla di cui eseguire il commit, l'albero di lavoro è pulito
```

In questo modo README.md tutte le modifiche effettuate a README.md vengono annullate (si può anche
ripristinare file eliminati).

Se non si specifica nessuna opzione, ``--worktree`` viene aggiunta di default. Prima dell'aggiunta
di restore, parte delle sue funzionalità erano già offerte da reset [@sec:heads], che vedremo in
contesti diversi; se non si desidera modificare i commit restore è più appropriato.

Per vedere quali modifiche sono già nella staging area e quali invece non sono ancora state aggiunte
con add:

```
$ git status
Sul branch master
Il tuo branch è aggiornato rispetto a 'origin/master'.

Modifiche di cui verrà eseguito il commit:
  (usa "git restore --staged <file>..." per rimuovere gli elementi dall'area di staging)
	modificato:             git.pdf
	modificato:             git.tex

Modifiche non nell'area di staging per il commit:
  (usa "git add <file>..." per aggiornare gli elementi di cui sarà eseguito il commit)
  (usa "git restore <file>..." per scartare le modifiche nella directory di lavoro)
	modificato:             README.md
```

Questo comando mostra anche informazioni relative al branch su cui si è posizionati e se si è
aggiornati rispetto al remote (vedere [@sec:remoti]).

## Push {#sec:push}

è __l'unico__ comando che permette di modificare il repository remoto. Le modifiche locali vengono
unite a quelle remote.

Git non permette di effettuare un push se la __storia__, intesa come sequenza di commit, del branch
remoto non è uguale al branch locale, escludendo i commit appena aggiunti fatti in locale. Se ci si
trova in questa situazione occorre effettuare un riallineamento (pull/rebase) oppure utilizzare
l'opzione ``-f`` (a tuo rischio e pericolo).

```
$ git push
Username for 'https://github.com': Stivvo
Password for 'https://Stivvo@github.com':
To https://github.com/Stivvo/msTest.git
 ! [rejected]        master -> master (fetch first)
error: push di alcuni riferimenti su 'https://github.com/Stivvo/msTest.git' non riuscito
Gli aggiornamenti sono stati rifiutati perché il remoto contiene delle
modifiche che non hai localmente. Ciò solitamente è causato da un push
da un altro repository allo stesso riferimento. Potresti voler integrare
le modifiche remote (ad es. con 'git pull ...') prima di eseguire
nuovamente il push.
Vedi la 'Nota sui fast forward' in 'git push --help' per ulteriori
dettagli
```

## Fetch, merge, pull \label{merge} {#sec:merge}

__Fetch__ permette di aggiornare lo stato dei branch in remoto per controllore se ci sono branch
nuovi o magari nuovi commit sul branch al quale si sta lavorando per evitare di rimanere
disallineati con il repository di riferimento. Fetch da solo tuttavia non modifica mai alcun file
sul repository locale.

__Merge__ permette di fondere le modifiche di due branch, locali o remoti, o commit diversi dello
stesso branch. Si usa se ad esempio la versione locale è rimasta indietro rispetto a quella remota.
oppure quando bisogna unire su un branch le modifiche fatte su un altro. Tuttavia, merge non preleva
mai nulla dal repository remoto, per farlo occorre effettuare prima un fetch.

__Pull__ è in sostanza un fetch seguito da un merge, ed è quello che capita di utilzzare più spesso,
anche se la combinazione fetch e merge sarebbe sempre un alternativa più sicura. In generale pull
fonde ciò che si trova al momento sul branch del repository remoto con quello locale. Se si effettua
un pull come suggerito nel codice della sezione \ref{push} avverrà infatti un merge.

Pull e fetch e merge chiamati senza argomenti vanno a prelevare la versione remota del branch su cui
si è localmente, ma nel caso di merge è aggiornata all' ultimo fetch.

Quindi se si vuole fondere ad esempio le modifiche di develop su master:

```
$ git checkout master
$ git fetch
$ git merge develop
```

Questo permette di vedere prima le nuove modifiche remote: dopo l'utilizzo di fetch, si possono
guardare al volo facendo ad esempio ``git checkout origin/develop`` (si entra in deatached head
[@sec:heads]). Poi si può decidere se effettuare il merge o no, oppure di effettuare il merge in
assenza di internet (in casi estremi le modifiche solitamente prelevate con fetch potrebbero venire
da un altro disco).

```
$ git checkout master
$ git pull develop
```

Utilizzando pull si ottiene un risultato identico ma l'operazione di merge non è annullabile. In
ogni caso è sempre necessario non avere modifiche non committate quando si effettua pull o merge.

```
<<<<<<< HEAD
class FirstClass {
=======
class SecondClass {
>>>>>>> 4ceb8e7c4fe78b59c00be99418f54280df19078c
```

Questo è il caso in cui mentre il repository locale rimaneva indietro di alcuni commit la classe è
stata rinominata in FirstClass da un primo sviluppatore. Nel frattempo un secondo ha fatto un push
di un commit in cui l'ha chiamata SecondClass. Quando il primo sviluppatore si trova a dover fare il
pull delle modifiche del secondo, si creano dei conflitti di merge, e git obbliga l'utente a
risolverli. Per farlo, deve scegliere tra la versione locale (HEAD, vedere [@sec:heads]) e quella
dell'altro, identificata dal codice hash (vedere [@sec:log]) del commit che ha rinominato la classe
in SecondClass. Il prossimo push sarà quello del commit di merge, automaticamente creato da git.

## Checkout, branch, switch {#sec:checkout}

Git branch senza opzioni viene utilizzato per creare un nuovo branch locale. La creazione del branch
develop:

```
$ git branch develop
```

Per posizionarsi su develop:

```
$ git switch develop
Si è passati al branch 'develop'
```

Prima dell'aggiunta di switch veniva utilizzato checkout, che però è finito con accorpare troppe
funzionalità. Così, come nel caso di reset [@sec:heads] la propria funzionalità principale (cambiare
branch) è stata spostata su switch. ``git checkout file.txt`` infatti elimina tutte le modifiche nel
worktree di quel file (equivalente a ``git restore --worktree file.txt``). In presenza di un file ed
un branch omonimi, questo può creare confusione e __perdite di dati__ involontarie. Inoltre nel caso
di switch è necessario aggiungere l'opzione ``--detach`` (o ``-d``) per posizionarsi su un commit
(entrando nello stato di deatached head (sec:heads)).

Se si prova a eseguire un push dal branch appena creato occorre aggiungerlo alla lista dei branch
remoti:

```
fatal: Il branch corrente develop non ha alcun branch upstream.
Per eseguire il push del branch corrente ed impostare il remoto come upstream, usa

    git push --set-upstream origin develop
```

L'opzione ``--all`` mostra tutti i branch locali e remoti. Il branch seguito dall'asterisco è quello
su cui si è posizionati correntemtente.

```
$ git branch --all
* develop
  master
  temp
  remotes/origin/HEAD -> origin/master
  remotes/origin/develop
  remotes/origin/master
```

In questo caso, temp è solamente locale.

L'opzione ``-d`` invece elimina un branch. Non è possibile eliminare il branch su cui si è
attualmente posizionati:

```
$ git branch -d develop
error: Impossibile eliminare il branch 'develop' di cui è stato eseguito
il checkout in '/home/stefano/prog/GitNoob2ProIta'
```

Per eliminare lo stesso branch anche dal repository remoto:

```
$ git push -d origin develop
```

L'opzione ``-C`` di switch (equivalente all'opzione ``-b`` di checkout) crea un branch se quello
passato come parametro non esiste, utilizzando quindi prima ``git branch`` e poi ``git switch``.

Per fondere due branch si utilizza ovviamente merge ([@sec:merge]).

## Log \label{log} {#sec:log}

Molto di quanto appena spiegato sarebbe inutile se non si potesse vedere la storia dei commit.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/logOutput.png}
\centering
\caption{l'output del comando git log (sec. \ref{log}) sul pager less}
\end{figure}
<!-- end latex -->

Git log mostra l'intera storia dei commit visualizzata nel pager di default (vedere
[@sec:configurazione]). La lunga serie di caratteri sono i codici __hash__, univoci per ogni commit.
L'output del comando mostra anche a quale commit puntano la HEAD e i repository remoti (se abbiamo
dei commit di cui non abbiamo fatto ancora il push è probabile che quest'ultima sia più indietro
rispetto ad HEAD).

Questo comando può generare molto output. Sarà più semplice trovare un commit con l'opzione
``pretty=oneline``, che assegna una sola riga ad ogni commit. Dopodichè sarà utile passare l'hash
del commit trovato come argomento di log, per vedere informazioni puù dettagliate. L'output di log
escluderà semplicemente tutti i commit precedenti a quello.

è anche possibile ricercare il testo del commit interessato passandolo come ``--grep=`` (grep è un
altro tool unix utilizzato da git):

```
$ git log --grep='git log'
commit 4b64be5218bed736d357d61471b87c4f5363d954 (HEAD -> master, origin/master, origin/HEAD)
Author: Stivvo <entattis15@itisvinci.com>
Date:   Sun Feb 23 17:37:09 2020 +0100

    git log
```

Si può ottenere la lista dei commit in cui è stata aggiunta o rimossa una determinata stringa
all'interno dei file del repository passandola come ``-S`` "string".

Se invece si è interessati a vedere tutti i commit effettuati da una stessa persona:

```
$ git log --author="Stivvo"
```

Se si vuole vedere rapidamente i titoli di tutti i commit senza il loro hash ``git shortlog``.

## Diff {#sec:diff}

Diff è un programma presente in tutti i sistemi unix-like che ha il semplice compito di dare in
output tutte le linee che differiscono tra due file, ``<`` se quella determinata riga è presente
solo nel file ``>``.

```
$ cat file1
prima
seconda
$ cat file2
prima
terza
$ diff file1.txt file2.txt
< seconda
> terza
```

Git utilizza una propria versione di diff, ad esempio per effettuare i merge, che mette anche a
disposizione dell'utente. Aggiunge la capacità di non trattare un file rinominato o spostato come un
nuovo file e di comparare la differenze tra i commit.

```
$ git diff 1fd15c30db68c1d9826204f571e4053a5ed89b49 9b004eae46dca7525156f57b9cf048ab147dd67d
```

Visualizza le modifiche apportate tra due commit qualsiasi (compresi quelli in mezzo). Se si
specifica un solo commit, si compara ad HEAD di default.

```
$ git diff --staged
```

``--staged`` mostra tutte le modifiche aggiunte alla staging area rispetto all'ultimo commit.

```
$ git diff HEAD
```

Questo mostra le modifiche nel working tree.

Un modo comodo per vedere quali modifiche si sono introdotte con i commit che si stanno per pushare
su master:

```
$ git diff origin/master
```

L'output di diff può essere ristretto ad uno o più file passati sempre come ultimi argomenti.

Diff diventa ancora più utile quando utilizzato insieme a log:

```
$ git log -p
```

Mostra tutti possibili output di diff, separandoli per commit. L'output può essere ovviamente
ristretto ad uno o più file passati come argomento.

``git show`` mostra tutte le mofidiche introdotte con un commit passato come parametro (se non
presente mostra HEAD di default), i file modificati utilizzando diff e il testo del commit
utilizzando log.

\pagebreak

# la cartella .git {#sec:dotGit}

La cartella .git si trova nella root del repository e contiene tutti i file utilizzati da git, tra
cui informazioni sui branch, sui commit. Nei sistemi operativi unix una cartella preceduta da un
punto è nascosta e quindi occorre utilizzare il parametro -a di ls per poterla vedere.

```
$ ls .git/
branches/  COMMIT_EDITMSG  config  description  FETCH_HEAD  HEAD  hooks/  index
info/  logs/  objects/  ORIG_HEAD  packed-refs  refs/
```

è molto importante la cartella refs:

```
$ ls .git/refs
heads/  remotes/  tags/
```

Dietro a questi tre nomi ci sono concetti importanti di git che tornano utili con la maggior parte
dei comandi

## heads {#sec:heads}

In git una head è un riferimento ad un branch o ad un commit di un determinato branch, locale o
remoto. Una lista delle head disponibili:

```
$ ls .git/refs/heads
master/ develop/
```

__HEAD__ è un file che punta all'ultimo commit del branch in cui si è attualmente posizionati nel
repository locale.

```
$ cat .git/HEAD
ref: refs/heads/master
```

Nel caso in cui si voglia ritornare ad un commit precedente si entra nello stato di ___deatached
head___, ovvero facendo il checkout su uno specifico commit (identificato con il suo codice hash).

```
$ git checkout 8b10ce361a08e03179d46bab5d691148805bf8d8
Nota: eseguo il checkout di '8b10ce361a08e03179d46bab5d691148805bf8d8'.

Sei nello stato 'HEAD scollegato'. Puoi dare un'occhiata, apportare modifiche
sperimentali ed eseguirne il commit, e puoi scartare qualunque commit eseguito
in questo stato senza che ciò abbia alcuna influenza sugli altri branch tornando
su un branch.

Se vuoi creare un nuovo branch per mantenere i commit creati, puoi farlo
(ora o in seguito) usando l'opzione -c con il comando switch. Ad esempio:

  git switch -c <nome nuovo branch>

Oppure puoi annullare quest'operazione con:

  git switch -

HEAD si trova ora a b0451d9 immagine scrittura commit
```

Al posto di andare a recuperare l'hash del commit:

```
$ git checkout master~2
```

``~`` indica di quanti commit si deve tornare indietro per trovare il commit su cui effettaure il
checkout. ``~`` e ``~1`` sono equivalenti.

Se si vuole mantenere i commit fatti in questo stato è buona cosa spostarsi su un nuovo branch come
suggerito.

Se si sceglie di rimanere sullo stesso, non si può effettuare direttamente il push dei commit
effettuati in questo stato, perché non si è di fatto posizionati su nessun branch:

```
$ git push
fatal: Attualmente non sei su un branch.
Per eseguire ora il push della cronologia che ha condotto
allo stato corrente (HEAD scollegato), usa
git push origin HEAD:<nome del branch remoto>
```

Il comando suggerito da git serve per caricare le modifiche effettuate in deatached head
direttamente sul branch remoto, come spiegato nella sezione [@sec:remoti]. è molto probabile che non
funzioni, perché andrebbe ad eliminare delle modifiche remote successive al commit in cui ci si è
posizionati; è necessario aggiungere l'opzione -f "force" a push se si vuole eliminarle.

Questo non risolve lo stato di deatached head. Infatti il branch (in questo caso master), contiene
contiene ancora i commit che vogliamo eliminare: un push li riporterebbe sul repository remoto.

Quindi dopo aver fatto ``git checkout master``, tornando sul branch da cui ci si era distaccati, si
può utilizzare __reset__, che è come un merge forzato che invece di fondere le modifiche sovrascrive
il branch remoto su quello locale:

```
$ git reset --hard origin/master
```

Oppure si può clonare nuovamente il progetto, ma è sempre la soluzione peggiore. Sia in questo modo
che utilizzando reset c'è sempre il pericolo di eliminare qualcosa che invece si voleva tenere,
perché si cancellano dei commit o delle modifiche non ancora committate.

Per questo esiste un modo migliore per ritornare a un commit precedente, senza modificare i commit
già effettuati:

```
$ git revert 0552dd1c6e3c11c8c5246836e9994e6fcd431a0f..HEAD
$ git commit -m "torno al commit precedente"
```

``torno al commit precedente`` conterrà delle modifiche che riportano allo stato del commit di cui
si è specificato il codice come argomento di __revert__.

``..HEAD`` indica che si ripristinano le modifiche effettuate da quel commit fino a HEAD (questo
intervallo può dunque comprendere diversi commit), ovvero lo stato corrente del branch.

è sempre bene evitare di modificare o eliminare commit già pushati, soprattutto se si collabora con
altri. Infatti reset è più appropriato per operare su commit locali. A differenza di checkout, non
sposta solo il puntatore HEAD su un determinato commit, ma elimina localmente tutti i commit
precedenti. Infatti revert è il comando di git che più ci espone a __perdite di dati__ in caso di
errore.

``git reset --mixed README.md`` è equivalente a ``git restore --staged README.md``.

``git reset --hard README.md`` è equivalente a ``git restore --staged --worktree README.md``.

``git reset --mixed HEAD~2`` torna indietro di due commit ma non modifica nessun file. Infatti tutti
i file vengono rimossi dall'area di staging e le modifiche non ancora committate tornano tutte nel
worktree insieme a quelle dei due commit precedenti. Questo comportamento è simile allo squash con
rebase [@sec:rebase].

Con ``git reset --hard HEAD~2`` è come se tutte le modifiche non committate e gli ultimi due commit
non fossero mai esistiti.

``git reset --soft`` non fa nulla. Infatti a differenza di ``--mixed`` non toglie le modifiche dalla
staging area: lascia tutto così com'è. Si limita ad annullare i commit, per questo ha effetto solo
se si specifica un commit precedente. Le modifiche dei commit precedenti vengono automaticamente
aggiunte alla staging area.

Se nessuna opzione viene specificata per reset, ``--mixed`` è utilizzata di default. Se non viene
specificato nessun file, agisce su tutti i file del repository. Se non viene specificato nessun
commit, viene utilizzato ``HEAD`` di default (l'ultimo commit) diventando in parte analogo a restore
[@sec:restore].

## Tags {#sec:tags}

Possono essere assegnati ad un commit in cui si è raggiunto un traguardo nel progetto (ad esempio
1.3.5).

Per visualizzare i tag:

```
$ git tag
v1.0
v2.0
```

Oppure:

```
$ ls .git/refs/tags
v1.0 v2.0
```

Per creare un tag basta dare al comando un argomento, che sarà il nome del tag:

```
$ git tag v2.1
```

I tag possono essere utilizzati in questo modo per descrivere piccoli progressi nello sviluppo. Per
segnare il punto di una release è bene utilizzare l'opzione -a "annotated":

```
$ git tag -a v3.0
```

In questo modo, verrà aperto l'editor di default per poter inserire informazioni su sulle le novità
portate da quella release. Come per i commit, l'opzione -m permette di scrivere un breve titolo
senza aprire l'editor.

Per visualzzare queste informazioni:

```
$ git show v3.0
commit ca82a6dff817ec66f44342007202690a93763949
Author: User <user@email.com>
Date:   Mon Mar 17 21:52:11 2020 -0700

    new release 3.0!
```

L'output è molto simile a quello di log. Se si vuole vedere le descrizioni di tutti i tag basta
chiamare show senza argomenti.

Si può aggiungere un tag ad un qualsiasi commit precedente specificando il suo codice:

```
$ git tag -a v1.2 9fceb02
```

I tag possono anche essere eliminati con l'opzione -d e si può fare il checkout su uno specifico tag
come si fa con i commit. Anche sull' assegnazione dei nomi alle versioni ci sono
\link{https://semver.org/}{norme} da seguire.

Per eliminare un tag remoto:

```
$ git push --delete origin v1.2
```

## Remotes {#sec:remoti}

Un remote è il percorso di un repository remoto, di solito è quello del repository sul server. Il
primo remote che viene utilizzato in un repository viene chiamato di default __origin__ (non è
obbligatorio). I remote infatti possono essere aggiunti, rinominati o rimossi:

```
$ git remote add amanjot https://github.com/samanjot/GitNoob2Pro
$ git remote rename amanjot samanjot
$ git remote remove samanjot
$ git remote add amanjot https://github.com/samanjot/GitNoob2Pro
```

Con ``-v`` "verbose" otteniamo una lista dei remote disponibili. Di default le operazioni come pull
sottointendono che si voglia utilizzare il remote origin, ma l'operazione può essere eseguita su
qualsiasi altro remote ``git pull amanjot master``).

```
$ git remote -v
amanjot	https://github.com/samanjot/GitNoob2Pro (fetch)
amanjot	https://github.com/samanjot/GitNoob2Pro (push)
origin	https://github.com/Stivvo/GitNoob2Pro.git (fetch)
origin	https://github.com/Stivvo/GitNoob2Pro.git (push)
```

oppure:

```
$ ls .git/refs/remotes
origin/ amanjot/
```

Il remote amanjot è un fork ([@sec:fork]) del repository di questa dispensa.

\pagebreak

# Installazione e configurazione {#sec:configurazione}

L'installazione di Git su Linux avviene dal package manager della propria distribuzione ed è un
processo che richiede pochi secondi. Su Windows, occorre
\link{https://git-scm.com/download/win}{scaricare} un wizard che installa un emulatore di una
versione minimale di linux che comprende tool come bash, rm e diff, da cui Git dipende.

```
$ git config --global user.name Stivvo
$ git config --global user.email entattis15@itsvinci.com
```

In questo modo si imposta lo username e l'email che verranno associati a tutti i futuri commit. Non
sono da confondere con le credenziali di Github [@sec:github]. Per impostare editor e pager
utilizzati da git (di solito vim e less sono già impostati di default):

```
$ git config --global core.editor vim
$ git config --global core.pager less
```

Un pager è un programma a linea di comando pensato per visualizzare in modo comodo l'output di
qualsiasi programma o il contenuto di un file, permettendo di effettuare lo scroll avanti e indietro
e ricerche sul testo. Se invece si preferisce visualizzare sempre l'output sul terminale:

```
$ git config --global core.pager ""
```

Per utilizzare comunque less per visualizzare l'output di git log sarebbe necessario:

```
$ git log --color=always | less -r
```

``git`` davanti ad ogni comando può risultare scomodo. Esiste un modo per evitarlo, sfruttando le
funzionalità di alias messe a disposizione dalla shell. Per impostarli occorre modificare il file di
configurazione della propria shell (``~/.bashrc`` se si utilizza bash).
\link{https://github.com/Stivvo/dotfiles/blob/master/fish/common.fish}{Questo} è un esempio.

\pagebreak

# Github {#sec:github}

Github è la più famosa piattaforma di hosting Git al mondo. è estremamente utilizzato da software
__opensource__ ma si rivolge anche al mondo closed source attraverso github enterprise, che è
ovviamente a pagamento, con il quale ci si può affidare ai server di Github oppure installarlo su
uno proprio.

Per utilizzare Github è necessario registrarsi. Utente e password scelti verranno richiesti al push
su un qualsiasi repository Github e anche al pull o clone di un repository privato.

Conoscendo Git, l' interfaccia del sito diventa presto molto facile da usare. A volte può risultare
più comodo svolgere alcune operazioni sul sito piuttosto che sul terminale. Ci sono comunque alcune
funzionalità extra che vanno comprese, perchè si basano su concetti importanti spesso collegati a
Git che non sono stati ancora trattati.

## Readme \label{readme} {#sec:readme}

Il readme è la prima cosa con cui un visitatore di un repository pubblico viene a contatto. Nel
readme si scrive che cosa contiene il repository, come si utilizza il software, si forniscono
istruzioni per chi vuole contribuire o compilare il software da sorgente. è scritto in markdown, un
metalinguaggo utilizzato per scrivere testi che viene spesso compilato in file .html.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/readme.png}
\centering
\caption{il readme (sec. \ref{readme}) di qt creator, uno dei maggiori progetti opensource }
\end{figure}
<!-- endlatex -->

## Fork \label{fork} {#sec:fork}

Un gruppo di sviluppatori effettua il fork di un software quando ne crea una copia per continuarne
lo sviluppo in modo indipendente dal team originale. Il concetto è simile a quello della creazione
di un branch, che diventa però indipendente da tutti gli altri e viene sviluppato da persone
diverse. Spesso un fork porta un nome diverso dal progetto originale.

Come si potrà immaginare, i fork nascono, la maggior parte delle volte, da progetti opensource, di
cui è perfettamente lecito creare quanti fork si desiderino. Molte volte i fork avvengono quando il
contributo di un gruppo di persone ad un progetto non viene accettato dal team originale, ad esempio
perchè questi hanno obiettivi molto diversi per stesso software o perchè lo vogliono adattare a
specifiche esigenze. Anche i
\link{https://en.wikipedia.org/wiki/Fork_(software_development)#/media/File:Linux_Distribution_Timeline.svg}{fork di fork}
non sono così inusuali nel mondo opensource.

Un fork può anche essere effettuato da uno sviluppatore che vuole contribuire ad un progetto pur non
essendo collaboratore. Non può quindi apportare direttamente delle modifiche e dunque nemmeno creare
un proprio branch. Quando all'interno del fork ha terminato di effettuare le proprie modifiche, può
ricongiungersi col progetto principale attraverso una pull request ([@sec:pullrequest]).

Due fork possono in teoria essere sottoposti ad un merge. A volte però la differenze aumentano tanto
che diventa possibile effettuarlo solamente sulle parti che sono state poco modificate dagli autori
del fork.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/fork.png}
\centering
\caption{l'albero dei fork di Boost, libreria per HTML/CSS/JS, uno dei repository attualmente più forkati (sec. \ref{fork}) su GitHub}
\end{figure}
<!-- end latex -->

## Pull request \label{pullrequest} {#sec:pullrequest}

Una pull request è di base un merge tra branch, accompagnato da un testo che spiega quali sono i
cambiamenti che da un determinato branch si vogliono unire a ad un altro, dello stesso repository o
di un fork. Riporta anche tutti i commit che coinvolge, in modo che oltre al testo sia facilmente
comprensibile quali modifiche verranno integrate. La differenza principale rispetto ad un merge è
che una pull request deve essere __approvata__ da un collaboratore del progetto del repository su
cui viene poi effettuato il merge.

Le pull request possono essere effettuate ad esempio da un singolo sviluppatore per chiedere ai
propri collaboratori se può integrare su master le modifiche che ha effettuato sul proprio branch.
Se, mentre viene valutata, continua a lavorare sullo stesso branch, la pull request già fatta non
viene aggiornata (è necessario crearne un'altra), in questo modo chi controlla le pull request può
prendersi molto più tempo per valutarle, essendo sicuro che nel frattempo non possono cambiare.

Le pull request potrebbero sostituire i merge tra branch, tuttavia se si tratta di un' operazione
che non richiede l' approvazione di altri è meglio utilizzare solamente i comandi di git perchè si
andrebbe a creare confusione nello storico delle pull request.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/pullRequest.png}
\centering
\caption{una pullrequest (sec. \ref{pullrequest}) per aggiornare il fork di questa dispensa}
\end{figure}
<!-- end latex -->

## Issue \label{issue} {#sec:issue}

Una issue non ha a che vedere direttamente con i comandi di Git, è invece un servizio aggiunto dalle
iattaforme di hosting. Contengono un testo che spiega un problema o una feature che si vorrebbe
introdurre e possono essere aperte da chiunque. A volte vengono aperte dagli stessi sviluppatori del
progetto, per cui diventano una specie di todolist, o anche semplici utenti che vogliono segnalare
un bug. Quindi, se avete delle proposte o trovate degli errori su questa dispensa
[non esitate](https://github.com/Stivvo/GitNoob2Pro/issues).

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/issue.png}
\centering
\caption{lista delle issue attualmente aperte su questo repository (sec. \ref{issue})}
\end{figure}
<!-- end latex -->

La grande utilità delle issue (questo è specifico per GitHub) è che possono essere collegate a
commit o pull request. Se ad esempio un commit risolve definitivamente i problemi evidenziati da una
specifica issue, può essere collegato alla sua chiusura. Inserendo alcune
[parole chiave](https://help.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue)
nel titolo del commit, seguite da ``#`` e poi dal numero della issue, la chiude in automatico.
Inoltre, nella storia dei commit di github quel commit riporterà un link alla issue che chiude. Una
issue chiusa infatti viene solo marcata come tale, ma resta visibile per preservare la memoria dello
sviluppo.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/commitCloseIssue.png}
\centering
\caption{commit che chiude una issue (sec. \ref{issue})}
\end{figure}
<!-- end latex -->

\pagebreak

# Approfondimenti

## I submodule

Un caso d'uso dei submodule è quello in cui si vuole utilizzare nel proprio progetto una libreria
opensource. Si potrebbe copiare sigolarmente i file necessari oppure installare la libreria sul
proprio computer ma spesso l'utilizzo dei submodule risulta più appropriato. L'utilizzo dei
submodule permette di integrare un intero repository git all' interno di un altro. In questo modo
c'è una separazione netta di quali file appartengono ad uno e quali all' altro, è possibile avere
facilmente gli aggiornamenti del submodule e quando una persona qualsiasi effettua il clone del
repository non si deve preoccupare di installare la libreria a parte. Infine, è un modo per dare il
giusto credito a chi ha creato il repository che si integra come submodule (github ad esempio genera
automaticamente il link che riporta a quel repository, rendendo noto a chiunque chi ha fatto che
cosa).

Per clonare un repository e tutti i suoi submodule:

```
$ git clone --recursive
```

Per aggiungere questa dispensa come submodule:

```
$ git submodule add https://github.com/Stivvo/GitNoob2Pro
```

Quando si aggiunge un submodule, questo resta fermo al proprio commit più recente in quel momento.
Anche dopo un clone, il submodule continua a fare il checkout sullo stesso commit. L'aggiornamento
(a proprio rischio e pericolo) deve essere fatto manualmente ogni volta. Occorre andare nella
rispettiva cartella e aggiornarlo alle modifiche remote come con un normale repository (quindi con
pull ecc). è bene eseguire un commit in cui si effettua solamente l'aggiornamento dei submodule per
non confonderlo con le effettive modifiche del proprio repository.

``.gitmodules``, da cui è possibile fare ulteriori modifiche ai submodule.

## Rebase

Rebase ha lo stesso compito di merge, ma lo svolge in modo molto diverso. Quando si effettua un
merge tra due branch, i commit vengono ordinati per data. Se sono state fatte modifiche in entrambi
i branch su cui si effettua il merge, si avrà come risultato che i commit di uno e dell'altro
saranno mischiati. Rebase risolve questo problema, perchè sposta semplicemente un intervallo di
commit da un punto all'altro.

Per esempio, si vuole portare i commit di develop su master:

```
-A-B-C-D master
   \
    G-H-I develop
```

Il risultato utilizzando merge:

```
-A-B-C-D- master
   \    \
    G-H-I
```

E con rebase:

```
-A-B-C-D
       \
        G-H-I master
```

In questo caso si sposta la _base_ dei commit da G a I, che non è più B ma D, proprio perchè è stato
cambiato il loro posto all'interno dello storico per copiarli su un nuovo branch.

Rebase offre anche la possibilità di riscrivere interamente la storia dei commit quando si uniscono
due branch, utilizzando l'opzione ``-i`` ( _interactive_ ). In questo modo si aprirà l' editor di
default con la lsita di tutti i commit interessati dal rebase (figura \ref{rebaseImg}), per ognuno
di questi si può scegliere ad esempio di cambiare il contenuto del suo messaggio o unirlo a quello
precedente. Dopodichè vengono analizzati uno per volta, a partire dal meno recente. Se sono stati
selezionati viene aperto l'editor di default con cui è possibile modificare il messaggio di commit.
Quest'ultima opzione è molto utile perchè permette di ripulire lo storico dei commit.

<!-- latex -->
\begin{figure}
\includegraphics[width=6in]{img/rebase.png}
\centering
\caption{Il file per selezionare i commit da modificare prima di un rebase (sec. \ref{rebase})}
\end{figure}
<!-- end latex -->

```
$ git checkout master
$ git rebase -i develop
```

Questo comando tenta di spostare la _base_ di develop, ovvero il punto in cui si è staccato da
master, sull'ultimo commit di master, il branch in cui si è attualmente posizionati. Nel processo,
i commit presi in considerazione dal rebase vengono analizati uno ad uno a partire dal meno recente
e possono essere modificati, uniti ecc prima di essere effettivamente copiati su master perchè è
stata aggiunta l'opzione ``-i``.

Se si tiene ad avere uno storico dei commit ordinato, capiterà più spesso di utilizzare questo
comando su un solo branch per modificare il suo storico dei commit.

```
$ git rebase -i HEAD~4
```

Quello che si ottiene in questo modo è prendere gli ultimi 4 commit di master e ``-i`` non farebbe
assolutamente nulla. Mettere il nome del branch corrente al posto di HEAD sarebbe indifferente. Si
può utilizzare ~ anche con branch diversi.

Alla fine di ogni rebase non si potrà effettuare direttamente il push: alcuni commit remoti che non
sono più presenti in locale perchè modificati o eliminati ``push -f`` forza la loro cancellazione.

In conclusione, merge rappresenta la vera storia dello sviluppo, anche se questa è spesso
confusionaria perchè fatta dai commit appartenenti a vari branch che si incrociano, scritti male o
inutili (compresi quelli di merge). Rebase permette invece di effettuare intere revisioni della
storia in modo da renderla più chiara e leggibile.

## Gitignore

Il file .gitignore, posizionato nella root del repository, permette di selezionare file o cartelle
di cui git non deve tenere traccia. Esiste una \link{https://github.com/github/gitignore}{raccolta}
di file .gitignore per la magggior parte di linguaggi e IDE. Alcuni esempi sono:

+ i file .swp, utilizzati da vim come cache per i file aperti
+ i file .user, creati dall'IDE qtcreator all'apertura di un progetto per memorizzare quali
  compilatori sono disponibili sulla macchina
+ ogni tipo di eseguibile, vengono ricavati con la compliazione

Il gitignore del repository di questa dispensa esclude file generati dal compilatore latex. Così
facendo, si ottiene uno storico dei commit più pulito perchè questi file verrebbero costantemente
segnati come modificati.

Un ulteriore esempio:

```
*.exe
*.dll
cartellaDaEsclidere/*
Makefile
```

\pagebreak

# fonti, link utili

## generale

+ \link{https://github.com/Stivvo/GitNoob2Pro}{questa stessa dispensa su Github}
+ \link{https://git-scm.com/about/branching-and-merging}{vantaggi di git}
+ \link{https://git-scm.com/book/en/v2}{pro git (libro completo)}
+ \link{https://git-scm.com/doc}{tutti i comandi}
+ \link{https://www.atlassian.com/git/tutorials}{guida di bitbucket (guardare "beginner" e "getting started")}
+ \link{https://www.git-tower.com/learn/git/faq}{FAQ di git tower (soprattutto "Understanding the detached HEAD state e "difference between fetch e pull")}

## commit, push, add

+ \link{https://stackoverflow.com/questions/292357/what-is-the-difference-between-git-pull-and-git-fetch}{differenza tra pull e fetch}
+ \link{https://stackoverflow.com/questions/348170/how-do-i-undo-git-add-before-commit?rq=1}{annullare add}
+ \link{https://stackoverflow.com/questions/572549/difference-between-git-add-a-and-git-add?rq=1}{parametri di add}
+ \link{https://stackoverflow.com/questions/1125968/how-do-i-force-git-pull-to-overwrite-local-files?rq=1}{sovrascrivere le modifiche locali con quelle remote}
+ \link{https://stackoverflow.com/questions/4114095/how-do-i-revert-a-git-repository-to-a-previous-commit?rq=1}{tornare a commit precedenti}
+ \link{https://stackoverflow.com/questions/8358035/whats-the-difference-between-git-revert-checkout-and-reset}{differenza tra revert e reset}
+ \link{https://stackoverflow.com/questions/22731126/writing-long-commit-messages-in-git}{lunghezza consigliata per i commit}

## head, remotes, branch

+ \link{https://stackoverflow.com/questions/1783405/how-do-i-check-out-a-remote-git-branch?rq=1}{checkout di un branch remoto}
+ \link{https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-locally-and-remotely?rq=1}{eliminare un branch}
+ \link{https://stackoverflow.com/questions/6591213/how-do-i-rename-a-local-git-branch?rq=1}{rinominare un branch }
+ \link{https://stackoverflow.com/questions/2304087/what-is-head-in-git}{cos'è head}
+ \link{https://stackoverflow.com/questions/9529497/what-is-origin-in-git}{che cos'è origin}
+ \link{https://stackoverflow.com/questions/34519665/how-can-i-move-head-back-to-a-previous-location-detached-head-undo-commits}{risolvere una deatached head}
+ \link{https://stackoverflow.com/questions/8196544/what-are-the-git-concepts-of-head-master-origin}{differenza tra head, master e origin}
+ \link{https://stackoverflow.com/questions/20954566/what-is-the-difference-from-head-head-and-head1}{tipi di head}
+ \link{https://stackoverflow.com/questions/23241052/what-does-git-push-origin-head-mean}{push origin head}
+ \link{https://stackoverflow.com/questions/10228760/fix-a-git-detached-head}{uscire da deatached head}
+ \link{https://stackoverflow.com/questions/16562121/git-diff-head-vs-staged}{diff HEAD vs diff --staged}
+ \link{https://stackoverflow.com/questions/20889346/what-does-git-remote-mean}{che cos'è un remote}
+ \link{https://stackoverflow.com/questions/3404294/merging-2-branches-together-in-git}{fare il merge di due branch}
+ \link{https://stackoverflow.com/questions/18137175/in-git-what-is-the-difference-between-origin-master-vs-origin-master}{differenza tra origin master e origin/master}
+ \link{https://stackoverflow.com/questions/58003030/what-is-git-restore-command-what-is-the-different-between-git-restore-and-git}{differenza tra restore e reset}
+ \link{https://www.atlassian.com/git/tutorials/undoing-changes/git-reset}{spiegazione dettagliata delle opzioni di reset}
+ \link{https://stackoverflow.com/questions/57265785/whats-the-difference-between-git-switch-and-git-checkout-branch}{differenza tra checkout e switch}

## merge, rebase

+ \link{https://stackoverflow.com/questions/179123/how-to-modify-existing-unpushed-commit-messages}{modificare commit esistenti}
+ \link{https://stackoverflow.com/questions/21756614/difference-between-git-merge-origin-master-and-git-pull}{differenza tra merge e pull}
+ \link{https://stackoverflow.com/questions/16666089/whats-the-difference-between-git-merge-and-git-rebase}{differenza tra merge e rebase}
+ \link{https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin}{aggiornare i submodule}

## log, diff

+ \link{https://www.toolsqa.com/git/git-log/}{guida a git log}
+ \link{https://stackoverflow.com/questions/7124914/how-to-search-a-git-repository-by-commit-message}{cercare il messaggio dei commit}
+ \link{https://stackoverflow.com/questions/5816134/how-to-find-the-git-commit-that-introduced-a-string-in-any-branch}{cercare il testo modificato dai commit}
+ \link{https://stackoverflow.com/questions/2928584/how-to-grep-search-committed-code-in-the-git-history}{grep del testo modificato dai commit}
+ \link{https://unix.stackexchange.com/questions/19317/can-less-retain-colored-output}{git log sempre colorato}
+ \link{https://stackoverflow.com/questions/4259996/how-can-i-view-a-git-log-of-just-one-users-commits}{ottenere tutti i commit di uno stesso autore}
+ \link{https://stackoverflow.com/questions/278192/view-the-change-history-of-a-file-using-git-versioning}{storia di un file. log -p}
+ \link{https://stackoverflow.com/questions/4456532/how-can-i-see-what-has-changed-in-a-file-before-committing-to-git}{diff relativo ad un file}
+ \link{https://stackoverflow.com/questions/2183900/how-do-i-prevent-git-diff-from-using-a-pager}{non utilizzare un pager}

