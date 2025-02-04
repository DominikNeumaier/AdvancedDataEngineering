# Flight Data Analysis Notebook

## Daten

Die Daten können über den folgenden Link heruntergeladen werden: [Daten](https://1drv.ms/u/c/f804c80fb0165847/Efn4DFFm9YhCp5FpbMT36OcBGlNgse5j-2JB07EFBhyLeg). Die Dateien können in einem Verzeichnis namens `data` im Root-Verzeichnis des Projekts abgelegt werden.

Im Verzeichnis `data` befinden sich folgende Dateien:

- `airports.csv`: Enthält Informationen zu Flughäfen.

- `airports.parquet`: Enthält die gleichen Informationen wie `airports.csv`, jedoch im Parquet-Format.

- `flightdata_worldwide.csv`: Enthält einen Ausschnitt der Weltweiten Flugdaten. Kann im Notebook als `flight_data_path` gesetzt werden, wenn das Notebook schnell ausgeführt werden soll.

- `flightdata_france`: Enthält einen Ausschnitt der Flugdaten in Frankreich. Kann im Notebook als `flight_data_path` gesetzt werden, wenn die Analysen detallierter durchgeführt werden sollen. Diese Datei ist jedoch sehr groß und kann das Notebook verlangsamen. Bitte beachten, dass die Daten trotzdem weit entfernt davon sind, vollständig zu sein. Das OpenSky Network stellt zum Beispiel keine Flugdaten über Ozeanen zur Verfügung.

- `aircraft-database-complete-2024-10.csv`: Enthält Informationen zu Flugzeugen.

- `parquet_poc_csv.csv`: Enthält Informationen zu Flügen im CSV-Format. Im Notebook wird hieraus im PoC ein Parquet-File erstellt.





## Docker

### Installation MacOS mit Colima
Colima ist ein Open Source Docker CLI Client für MacOS und Linux und somit eine Alternative zu Docker Desktop.

#### Installation
```bash
brew install colima
```

#### Starten des Docker Deamons
Es ist wichtig, dass der Container genug Ressourcen bekommt. Bei Colima hat der Default zu wenig Ressourcen. Es sollte mindestens 8GB RAM und 4 CPUs zugewiesen werden. Mit Colima kann der Docker Deamon wie folgt gestartet werden:

```bash
colima start --cpu 4 --memory 8
```

### Installation Linux

#### Installation
```bash
curl -sSL https://get.docker.com | sh
``` 
Dieses Skript erkennt die Linux Distribution und installiert Docker entsprechend. Das birgt jedoch auch Risiken, da das Skript nicht überprüft wird.

#### Starten des Docker Deamons
Bei anderen OS ist es wichtig, dass der Container genug Ressourcen bekommt. Es sollte mindestens 8GB RAM und 4 CPUs zugewiesen werden. Das Projekt wurde auf einem Fedora 41 Workstation getestet. Hier hat der Container automatisch alle Ressourcen bekommen, die der Host zur Verfügung stellt.
Es ist möglich, dass dies bei anderen Distributionen nicht der Fall ist. 
Der Docker Deamon kann wie folgt gestartet werden:

```bash
sudo systemctl start docker
```

### Installation Windows
Für Windows wird Docker Desktop empfohlen. Docker Desktop ist eine Desktop-Anwendung, die Docker-Container auf Windows und MacOS bereitstellt. Docker Desktop enthält Docker Engine, Docker CLI Client, Docker Compose, Notary, Kubernetes und Credential Helper.

#### Installation
Docker Desktop kann von der [Docker Website](https://www.docker.com/products/docker-desktop) heruntergeladen werden. Im Installtionsfenster von Docker Desktop sollte unbeding ein Haken bei `Install required Windows components for WSL 2` gesetzt werden. Dies ist notwendig, Windows Subsystem for Linux (WSL) zu installieren. Damit `WSL` genug Ressourcen bekommt, muss die Datei `C:\Users\<username>\.wslconfig` erstellt werden:

```bash
cd %UserProfile%
notepad .wslconfig
```
Es öffnet sich ein Editor. Hier sollte folgendes eingetragen werden:

```bash
[wsl2]
memory=8GB
processors=4
```
Danach sollte die Datei gespeichert und und der Computer neu gestartet werden.

#### Starten der Docker Engine
Die Docker Engine sollte automatisch gestartet werden, wenn Docker Desktop installiert und geöffnet ist. 


### Anwendung starten

### Image

Das Image kann mit folgendem Befehl aus dem GitHub Container Registry heruntergeladen werden:

```bash
docker pull ghcr.io/rollstuhlrocker/flight-data-analysis:abgabe
```


### Run Container
Um den Container zu starten kann im Root-Verzeichnis des Projekts folgender Befehl ausgeführt werden:

```bash
docker compose up -d
```

Um den Container zu stoppen kann folgender Befehl ausgeführt werden:

```bash
docker compose down
```

Hier wird ein Container gestartet, der die [Jupyter Notebooks](http://localhost:8889) auf Port 8888 und die [Dash App](http://localhost:8080) auf Port 8080 bereitstellt. Das Verzeichnis `data` wird in den Container gemountet. Das heißt, dass alle Dateien, die sich auf dem in dem Verzeichnis `data` befinden, auch im Container verfügbar sind.
Ansonsten würde das erstellen des Images lange dauern, da die Daten in den Container kopiert werden müssten. Das gleiche gilt für das Jupyter Notebook `AdvancedData.ipynb`. Dieses wird gemountet, damit Änderungen im Container direkt im Notebook auf dem Host sichtbar sind und umgekehrt.
