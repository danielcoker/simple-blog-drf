FROM python:3.9
ENV PYTHONUNBUFFERED 1

# Allows docker to cache installed dependencies between builds
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Adds our application code to the image
COPY . /code
WORKDIR /code

EXPOSE 8000

# Run the production server
CMD python ./manage.py migrate && gunicorn --env DJANGO_CONFIGURATION=Production --bind 0.0.0.0:$PORT --access-logfile - simple-blog.wsgi:application
