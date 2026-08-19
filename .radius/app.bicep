extension radius

param environment string
@secure()
param registryUsername string

@secure()
param registryPassword string

resource traderxApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'trader-x'
  properties: {
    environment: environment
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: traderxApp.id
    data: {
      username: {
        value: registryUsername
      }
      password: {
        value: registryPassword
      }
    }
  }
}

resource databaseImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'database-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//database?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'database/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource referenceDataImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'reference-data-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//reference-data?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'reference-data/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource tradeFeedImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-feed-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-feed?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'trade-feed/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource peopleServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'people-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//people-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'people-service/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource accountServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'account-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//account-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'account-service/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource positionServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'position-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//position-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'position-service/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource tradeProcessorImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-processor-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-processor?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'trade-processor/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource tradeServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'trade-service/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource webFrontendImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'web-front-end-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//web-front-end/angular?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'web-front-end/angular/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource ingressImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'ingress-image'
  properties: {
    environment: environment
    application: traderxApp.id
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//ingress?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
      ]
    }
    codeReference: 'ingress/Dockerfile.compose'
  }
  dependsOn: [
    registryCreds
  ]
}

resource databaseContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'database'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      database: {
        image: databaseImage.properties.imageReference
        ports: {
          tcp: {
            containerPort: 18082
          }
          postgres: {
            containerPort: 18083
          }
          web: {
            containerPort: 18084
          }
        }
        env: {
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          DATABASE_PG_PORT: {
            value: '18083'
          }
          DATABASE_WEB_PORT: {
            value: '18084'
          }
          DATABASE_WEB_HOSTNAMES: {
            value: '*'
          }
        }
      }
    }
    codeReference: 'database/run.sh#L28'
  }
}

resource referenceDataContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'reference-data'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      referenceData: {
        image: referenceDataImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18085
          }
        }
        env: {
          REFERENCE_DATA_SERVICE_PORT: {
            value: '18085'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    codeReference: 'reference-data/src/main.ts#L19'
  }
}

resource tradeFeedContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-feed'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      tradeFeed: {
        image: tradeFeedImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18086
          }
        }
        env: {
          TRADE_FEED_PORT: {
            value: '18086'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    codeReference: 'trade-feed/index.js#L93'
  }
}

resource peopleServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'people-service'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      peopleService: {
        image: peopleServiceImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18089
          }
        }
        env: {
          PEOPLE_SERVICE_PORT: {
            value: '18089'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    codeReference: 'people-service/PeopleService.WebApi/Program.cs#L43'
  }
}

resource accountServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'account-service'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      accountService: {
        image: accountServiceImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18088
          }
        }
        env: {
          ACCOUNT_SERVICE_PORT: {
            value: '18088'
          }
          DATABASE_TCP_HOST: {
            value: 'database-database'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          PEOPLE_SERVICE_HOST: {
            value: 'people-service-peopleService'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    connections: {
      database: {
        source: databaseContainer.id
        disableDefaultEnvVars: true
      }
      peopleService: {
        source: peopleServiceContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'account-service/Dockerfile.compose'
  }
}

resource positionServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'position-service'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      positionService: {
        image: positionServiceImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18090
          }
        }
        env: {
          POSITION_SERVICE_PORT: {
            value: '18090'
          }
          DATABASE_TCP_HOST: {
            value: 'database-database'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    connections: {
      database: {
        source: databaseContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'position-service/Dockerfile.compose'
  }
}

resource tradeProcessorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-processor'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      tradeProcessor: {
        image: tradeProcessorImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18091
          }
        }
        env: {
          TRADE_PROCESSOR_SERVICE_PORT: {
            value: '18091'
          }
          DATABASE_TCP_HOST: {
            value: 'database-database'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          TRADE_FEED_HOST: {
            value: 'trade-feed-tradeFeed'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    connections: {
      database: {
        source: databaseContainer.id
        disableDefaultEnvVars: true
      }
      tradeFeed: {
        source: tradeFeedContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'trade-processor/Dockerfile.compose'
  }
}

resource tradeServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-service'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      tradeService: {
        image: tradeServiceImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18092
          }
        }
        env: {
          TRADING_SERVICE_PORT: {
            value: '18092'
          }
          ACCOUNT_SERVICE_HOST: {
            value: 'account-service-accountService'
          }
          REFERENCE_DATA_HOST: {
            value: 'reference-data-referenceData'
          }
          PEOPLE_SERVICE_HOST: {
            value: 'people-service-peopleService'
          }
          TRADE_FEED_HOST: {
            value: 'trade-feed-tradeFeed'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    connections: {
      accountService: {
        source: accountServiceContainer.id
        disableDefaultEnvVars: true
      }
      referenceData: {
        source: referenceDataContainer.id
        disableDefaultEnvVars: true
      }
      peopleService: {
        source: peopleServiceContainer.id
        disableDefaultEnvVars: true
      }
      tradeFeed: {
        source: tradeFeedContainer.id
        disableDefaultEnvVars: true
      }
      tradeProcessor: {
        source: tradeProcessorContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'trade-service/Dockerfile.compose'
  }
}

resource webFrontendContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'web-front-end'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      webFrontend: {
        image: webFrontendImage.properties.imageReference
        ports: {
          http: {
            containerPort: 18093
          }
        }
        env: {
          WEB_SERVICE_PORT: {
            value: '18093'
          }
        }
      }
    }
    connections: {
      accountService: {
        source: accountServiceContainer.id
        disableDefaultEnvVars: true
      }
      referenceData: {
        source: referenceDataContainer.id
        disableDefaultEnvVars: true
      }
      tradeService: {
        source: tradeServiceContainer.id
        disableDefaultEnvVars: true
      }
      positionService: {
        source: positionServiceContainer.id
        disableDefaultEnvVars: true
      }
      peopleService: {
        source: peopleServiceContainer.id
        disableDefaultEnvVars: true
      }
      tradeFeed: {
        source: tradeFeedContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'web-front-end/angular/Dockerfile.compose'
  }
}

resource ingressContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'ingress'
  properties: {
    environment: environment
    application: traderxApp.id
    containers: {
      ingress: {
        image: ingressImage.properties.imageReference
        ports: {
          http: {
            containerPort: 8080
          }
        }
        env: {
          NGINX_HOST: {
            value: 'localhost'
          }
          DATABASE_URL: {
            value: 'http://database-database:18084/'
          }
          REFERENCE_DATA_URL: {
            value: 'http://reference-data-referenceData:18085/'
          }
          TRADE_FEED_URL: {
            value: 'http://trade-feed-tradeFeed:18086/'
          }
          PEOPLE_SERVICE_URL: {
            value: 'http://people-service-peopleService:18089/'
          }
          ACCOUNT_SERVICE_URL: {
            value: 'http://account-service-accountService:18088/'
          }
          POSITION_SERVICE_URL: {
            value: 'http://position-service-positionService:18090/'
          }
          TRADE_PROCESSOR_URL: {
            value: 'http://trade-processor-tradeProcessor:18091/'
          }
          TRADE_SERVICE_URL: {
            value: 'http://trade-service-tradeService:18092/'
          }
          WEB_FRONTEND_URL: {
            value: 'http://web-front-end-webFrontend:18093/'
          }
        }
      }
    }
    connections: {
      database: {
        source: databaseContainer.id
        disableDefaultEnvVars: true
      }
      referenceData: {
        source: referenceDataContainer.id
        disableDefaultEnvVars: true
      }
      tradeFeed: {
        source: tradeFeedContainer.id
        disableDefaultEnvVars: true
      }
      peopleService: {
        source: peopleServiceContainer.id
        disableDefaultEnvVars: true
      }
      accountService: {
        source: accountServiceContainer.id
        disableDefaultEnvVars: true
      }
      positionService: {
        source: positionServiceContainer.id
        disableDefaultEnvVars: true
      }
      tradeProcessor: {
        source: tradeProcessorContainer.id
        disableDefaultEnvVars: true
      }
      tradeService: {
        source: tradeServiceContainer.id
        disableDefaultEnvVars: true
      }
      webFrontend: {
        source: webFrontendContainer.id
        disableDefaultEnvVars: true
      }
    }
    codeReference: 'ingress/nginx.traderx.conf.template#L1'
  }
}

resource ingressRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'ingress'
  properties: {
    environment: environment
    application: traderxApp.id
    kind: 'HTTP'
    rules: [
      {
        matches: [
          {
            httpPath: '/'
          }
        ]
        destinationContainer: {
          resourceId: ingressContainer.id
          containerName: 'ingress'
          containerPort: 8080
        }
      }
    ]
    codeReference: 'ingress/nginx.traderx.conf.template#L1'
  }
}
