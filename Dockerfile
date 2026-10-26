FROM python:3.14-slim AS base

WORKDIR /src
RUN groupadd -g 10001 app && useradd -r --no-log-init -s /usr/sbin/nologin -u 10001 -g app app
COPY ./requirements/app.txt /src/requirements/app.txt
RUN pip install --no-cache-dir -r /src/requirements/app.txt

FROM base AS dev
COPY ./requirements/dev.txt /src/requirements/dev.txt
RUN pip install --no-cache-dir -r /src/requirements/dev.txt
COPY --chown=10001:10001 ./src/app /src/app
USER app
CMD ["fastapi", "dev", "/src/app/main.py", "--port", "8000", "--host", "0.0.0.0"]

FROM base AS prod
COPY ./src/app /src/app
USER app
CMD ["fastapi", "run", "/src/app/main.py", "--port", "8000"]

