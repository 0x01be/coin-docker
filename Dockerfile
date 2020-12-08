FROM 0x01be/coin:build as build

FROM alpine

COPY --from=build /opt/coin/ /opt/coin/

