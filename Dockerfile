FROM python:3.4 as build-env
RUN pip install mkdocs
WORKDIR /app
COPY . ./
RUN mkdocs --version
RUN mkdocs build --clean -v

from nginx:alpine
WORKDIR /app
COPY --from=build-env /app/site /usr/share/nginx/html
COPY --from=build-env /app/.nginx/default.conf /etc/nginx/conf.d/default.conf