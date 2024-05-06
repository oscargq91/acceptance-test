function fn() {
    karate.configure('connectTimeout', 20000);
    karate.configure('readTimeout', 20000);
    karate.configure('ssl', true);
    var baseUrl = karate.properties['baseUrl'] || 'http://localhost:8090/api/v1'
    var logBaseUrl = karate.properties['logBaseUrl'] || 'http://logs-rest:8070/api/v1'
    var healthCheckBaseUrl = karate.properties['healthCheckBaseUrl'] || 'http://health-rest:8050'

    return {
        api: {
            baseUrl: baseUrl,
            logBaseUrl: logBaseUrl,
            healthCheckBaseUrl: healthCheckBaseUrl
        }
    };
}