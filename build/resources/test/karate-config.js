function fn() {
    karate.configure('connectTimeout', 20000);
    karate.configure('readTimeout', 20000);
    karate.configure('ssl', true);
    var baseUrl = karate.properties['baseUrl'] || 'https://canales-digitales-ext-qa.apps.ambientesbc.com/alm/api/v1/customer-rules'
    var customerId = karate.properties['customerId'] || '9999002009 '

    return {
        api: {
            baseUrl: baseUrl,
            customerId: customerId
        }
    };
}