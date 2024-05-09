FROM ubuntu:23.04

ADD TestMini /TestMini
ADD global.json /global.json
ADD TestMini.sln /TestMini.sln

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        \
        # .NET dependencies
        libc6 \
        libgcc-s1 \
        libgssapi-krb5-2 \
        libicu72 \
        liblttng-ust1 \
        libssl3 \
        libstdc++6 \
        libunwind8 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -Channel 7.0 -Version 7.0.302 -InstallDir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

ENTRYPOINT ["tail", "-f", "/dev/null"]
