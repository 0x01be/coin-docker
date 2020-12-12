FROM 0x01be/coin:build as build

FROM 0x01be/base

COPY --from=build /opt/coin/ /opt/coin/

