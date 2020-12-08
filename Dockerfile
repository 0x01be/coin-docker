FROM 0x01be/coin as build

FROM alpine

COPY --from=build /opt/coin/ /opt/coin/

