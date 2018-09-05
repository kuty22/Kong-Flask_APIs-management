FROM python:3.5

COPY . /api
COPY requirements.txt /tmp/requirements.txt

RUN apt-get update; \
    pip3 install -r /tmp/requirements.txt;

ENTRYPOINT ["python"]

CMD ["-u", "/api/app.py"]
