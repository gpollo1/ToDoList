# ToDoList
Applicazione Flutter, che gestisce liste di attività, segnare quelle completate e visualizzare statistiche. L’utente può creare più liste personalizzate e i dati vengono salvati localmente sul dispositivo.

## Funzionalità

- Creazione e gestione di task
- Spunta delle attività completate
- Eliminazione task
- Creazione di **più liste personalizzate** (es. scuola, spesa, lavoro)
- Statistiche globali e per singola lista
- Percentuale di efficienza
- Salvataggio automatico dei dati in locale
- Interfaccia grafica con immagini dinamiche in base ai progressi

## Struttura dell’App

L’app è composta da tre schermate principali:

### Todo Page
- Visualizzazione della lista corrente
- Aggiunta nuovi task
- Completamento e rimozione task
- Percentuale di avanzamento visiva

### Stats Page
- Numero totale task
- Task completati
- Percentuale di efficienza globale
- Statistiche per lista selezionata

### Lists Page
- Creazione nuove liste
- Eliminazione liste
- Selezione lista attiva

## Salvataggio Dati
I dati vengono salvati localmente tramite `SharedPreferences` utilizzando serializzazione JSON.  
Ogni modifica (aggiunta, eliminazione, completamento task) viene salvata automaticamente.
## Modelli Dati

- **TodoItem**
  - title
  - done

- **TodoList**
  - name
  - list di TodoItem

## Come scaricare l'app
Nella cartella github sono presenti solo i file modificati per l'applicazione:
Creare quindi un nuovo progetto flutter e sostituire la cartella lib con quella presente in questo progetto.
La stessa cosa con i file yaml e lock. Nella cartella assets è presente una cartella img con le varie immagini utilizzate per questa applicazione.
