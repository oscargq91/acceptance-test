function fn() {
    karate.configure('connectTimeout', 20000);
    karate.configure('readTimeout', 20000);
    karate.configure('ssl', true);
    var baseUrl = karate.properties['baseUrl'] || 'http://localhost:8090/api/v1'

    return {
        api: {
            baseUrl: baseUrl
        }
    };
}