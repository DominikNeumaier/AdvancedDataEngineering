FROM jupyter/pyspark-notebook:latest

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere requirements.txt ins Image
COPY requirements.txt .

# Installiere Python-Abhängigkeiten
RUN pip install -r requirements.txt

# Kopiere das Notebook ins Image
COPY AdvancedData.ipynb .

# Temporarily switch to root user to create the spark-env.sh file
USER root

# Erstelle eine leere spark-env.sh Datei mit korrekten Berechtigungen
RUN mkdir -p /usr/local/spark/conf && touch /usr/local/spark/conf/spark-env.sh && chmod 777 /usr/local/spark/conf/spark-env.sh
RUN mkdir -p /usr/local/spark/logs && chmod -R 777 /usr/local/spark/logs
RUN mkdir -p /usr/local/spark/work && chmod -R 777 /usr/local/spark/work

# Switch back to the default user
USER $NB_UID

# Exponiere den Jupyter-Port
EXPOSE 8888

# Starte Jupyter Notebook automatisch
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.allow_origin='*'", "--NotebookApp.ip='0.0.0.0'", "--NotebookApp.port=8888"]