FROM openjdk:24-slim-bookworm

LABEL maintainer="Nick Gorbunov <offmysoap@gmail.com>"

RUN apt-get update \
    # Install prerequisites
    && apt-get install -y --no-install-recommends \
       wget \
       ca-certificates \
    \
    # Install Microsoft package feed
    && wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    \
    # Install .NET
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        dotnet-sdk-9.0 \
    \
    # Cleanup
    && rm -rf /var/lib/apt/lists/*

RUN dotnet tool install --global dotnet-sonarscanner

COPY run.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["run.sh"]
