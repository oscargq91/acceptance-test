function fn() {
    karate.configure(20000);
    karate.configure(20000);
    karate.configure(true);
    var baseUrl = 'http://localhost:8090/api/v1'

    return {
        api: {
            baseUrl: baseUrl
        }
    };
}