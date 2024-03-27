FROM python:3.12

RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /app

COPY pyproject.toml poetry.lock ./
ENV PATH="${PATH}:/root/.local/share/pypoetry/venv/bin"
RUN poetry install  --no-interaction --no-ansi

ADD . /app
ENV DJANGO_SETTINGS_MODULE="task_manager.settings"

COPY pyproject.toml poetry.lock /app/

RUN python -m venv /venv && \
    /venv/bin/pip install poetry && \
    /venv/bin/poetry install

COPY . /app

RUN rm -rf /venv

CMD ["python", "app.py"]
