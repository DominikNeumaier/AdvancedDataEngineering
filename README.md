# Flight Data Analysis Notebook

## Docker

### Colima
Colima ist ein Open Source Docker CLI Client für MacOS und Linux und somit eine Alternative zu Docker Desktop.

#### Installation MacOS
```bash
brew install colima
```
Zudem sollte `buildx` installiert werden.

```bash
colima buildx install
mkdir -p ~/.docker/cli-plugins
ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
```

### Starten des Docker Deamons
Es ist wichtig, dass der Container genug Ressourcen bekommt. Bei Colima hat der Default zu wenig Ressourcen. Es sollte mindestens 8GB RAM und 4 CPUs zugewiesen werden. Mit Colima kann der Docker Deamon wie folgt gestartet werden:

```bash
colima start --cpus 4 --memory 8GB
```

### Build Image
Um das Image zu bauen, muss sich im Root-Verzeichnis des Projekts befinden. Das Image wird `flight-data-analysis` genannt.
```bash
docker build -t flight-data-analysis .
```

### Run Container
```bash
docker run -p 8888:8888 -p 8080:8080 -v $(pwd)/data:/app/data flight-data-analysis 
```
Hier wird ein Container gestartet, der die Jupyter Notebooks auf Port 8888 und die Dash App auf Port 8080 bereitstellt. Das Verzeichnis `data` wird in den Container gemountet. Das heißt, dass alle Dateien, die sich auf dem in dem Verzeichnis `data` befinden, auch im Container verfügbar sind.
Ansonsten würde das erstellen des Images lange dauern, da die Daten in den Container kopiert werden müssten.


