# Flight Data Analysis Notebook

## Docker
Um die folgenden Kommandos auszuführen, muss Docker installiert sein und der Docker Deamon laufen. Außerdem muss das aktuelle Verzeichnis in dem sich die Dockerfile befindet, das aktuelle Arbeitsverzeichnis in der Konsole sein sein.
### Build
```bash
docker build -t flight-data-analysis .
```

### Run
```bash
docker run -p 8888:8888 -p 8080:8080 -v $(pwd)/data:/app/data flight-data-analysis 
```
Hier wird ein Container gestartet, der die Jupyter Notebooks auf Port 8888 und die Dash App auf Port 8080 bereitstellt. Das Verzeichnis `data` wird in den Container gemountet. Das heißt, dass alle Dateien, die sich auf dem in dem Verzeichnis `data` befinden, auch im Container verfügbar sind.
Ansonsten würde das erstellen des Images lange dauern, da die Daten in den Container kopiert werden müssten.
