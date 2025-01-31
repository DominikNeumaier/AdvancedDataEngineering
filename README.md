# Flight Data Analysis Notebook

## Docker

### Installation MacOS mit Colima
Colima ist ein Open Source Docker CLI Client für MacOS und Linux und somit eine Alternative zu Docker Desktop.

#### Installation
```bash
brew install colima
```
Zudem sollte `buildx` installiert werden.

```bash
colima buildx install
mkdir -p ~/.docker/cli-plugins
ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
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

Danach sollte `buildx` installiert werden.

```bash
docker buildx install
```

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

### Build Image
Um das Image zu bauen, muss sich im Root-Verzeichnis des Projekts befinden. Das Image wird `flight-data-analysis` genannt.

```bash
docker build -t flight-data-analysis .
```

### Run Container
Um den Container zu starten, muss folgender Befehl ausgeführt werden (MacOS und Linux):
```bash
docker run -p 8888:8888 -p 8080:8080 -v $(pwd)/data:/app/data -v $(pwd)/AdvancedData.ipynb:/app/AdvancedData.ipynb flight-data-analysis
```
Windows:
```bash
docker run -p 8888:8888 -p 8080:8080 -v %cd%/data:/app/data -v %cd%/AdvancedData.ipynb:/app/AdvancedData.ipynb flight-data-analysis
```

Hier wird ein Container gestartet, der die Jupyter Notebooks auf Port 8888 und die Dash App auf Port 8080 bereitstellt. Das Verzeichnis `data` wird in den Container gemountet. Das heißt, dass alle Dateien, die sich auf dem in dem Verzeichnis `data` befinden, auch im Container verfügbar sind.
Ansonsten würde das erstellen des Images lange dauern, da die Daten in den Container kopiert werden müssten. Das gleiche gilt für das Jupyter Notebook `AdvancedData.ipynb`. Dieses wird gemountet, damit Änderungen im Container direkt im Notebook auf dem Host sichtbar sind und umgekehrt.
Um den Container zu stoppen, kann `Ctrl + C` gedrückt werden. Der Container wird dann gestoppt und kann mit dem Befehl `docker start <container_id>` wieder gestartet werden. Die `container_id` kann mit dem Befehl `docker ps -a` herausgefunden werden.
