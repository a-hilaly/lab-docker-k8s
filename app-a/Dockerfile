FROM python:3.7-alpine

ENV VERSION 1

ADD server.py .
ADD requirements.txt .

RUN pip3 install -r requirements.txt

ENTRYPOINT [ "python3", "server.py" ]
