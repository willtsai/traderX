extension radius

param environment string

var sourceRoot = 'git::https://github.com/willtsai/traderX.git'
var sourceRef = '8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'

resource traderXApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'traderx'
  properties: {
    environment: environment
  }
}

resource databaseImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'database-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//database?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'database/Dockerfile.compose'
  }
}

resource referenceDataImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'reference-data-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//reference-data?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'reference-data/Dockerfile.compose'
  }
}

resource tradeFeedImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-feed-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//trade-feed?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'trade-feed/Dockerfile.compose'
  }
}

resource peopleServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'people-service-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//people-service?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'people-service/Dockerfile.compose'
  }
}

resource accountServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'account-service-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//account-service?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'account-service/Dockerfile.compose'
  }
}

resource positionServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'position-service-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//position-service?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'position-service/Dockerfile.compose'
  }
}

resource tradeProcessorImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-processor-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//trade-processor?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'trade-processor/Dockerfile.compose'
  }
}

resource tradeServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-service-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//trade-service?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'trade-service/Dockerfile.compose'
  }
}

resource webFrontendImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'web-front-end-angular-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//web-front-end/angular?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'web-front-end/angular/Dockerfile.compose'
  }
}

resource ingressImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'ingress-image'
  properties: {
    environment: environment
    application: traderXApp.id
    build: {
      source: '${sourceRoot}//ingress?ref=${sourceRef}'
      dockerfile: 'Dockerfile.compose'
    }
    codeReference: 'ingress/Dockerfile.compose'
  }
}

resource databaseContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'database'
  properties: {
    environment: environment
    application: traderXApp.id
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
            value: 'localhost,database'
          }
        }
      }
    }
    codeReference: 'database/Dockerfile.compose'
  }
}

resource referenceDataContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'reference-data'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      referenceData: {
        image: referenceDataImage.properties.imageReference
        ports: {
          web: {
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
    connections: {
      database: {
        source: databaseContainer.id
      }
    }
    codeReference: 'reference-data/Dockerfile.compose'
  }
}

resource tradeFeedContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-feed'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      tradeFeed: {
        image: tradeFeedImage.properties.imageReference
        ports: {
          web: {
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
    codeReference: 'trade-feed/Dockerfile.compose'
  }
}

resource peopleServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'people-service'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      peopleService: {
        image: peopleServiceImage.properties.imageReference
        ports: {
          web: {
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
    codeReference: 'people-service/Dockerfile.compose'
  }
}

resource accountServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'account-service'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      accountService: {
        image: accountServiceImage.properties.imageReference
        ports: {
          web: {
            containerPort: 18088
          }
        }
        env: {
          ACCOUNT_SERVICE_PORT: {
            value: '18088'
          }
          DATABASE_TCP_HOST: {
            value: 'database'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          PEOPLE_SERVICE_HOST: {
            value: 'people-service'
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
      }
      people: {
        source: peopleServiceContainer.id
      }
    }
    codeReference: 'account-service/Dockerfile.compose'
  }
}

resource positionServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'position-service'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      positionService: {
        image: positionServiceImage.properties.imageReference
        ports: {
          web: {
            containerPort: 18090
          }
        }
        env: {
          POSITION_SERVICE_PORT: {
            value: '18090'
          }
          DATABASE_TCP_HOST: {
            value: 'database'
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
      }
    }
    codeReference: 'position-service/Dockerfile.compose'
  }
}

resource tradeProcessorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-processor'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      tradeProcessor: {
        image: tradeProcessorImage.properties.imageReference
        ports: {
          web: {
            containerPort: 18091
          }
        }
        env: {
          TRADE_PROCESSOR_SERVICE_PORT: {
            value: '18091'
          }
          DATABASE_TCP_HOST: {
            value: 'database'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          TRADE_FEED_HOST: {
            value: 'trade-feed'
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
      }
      tradefeed: {
        source: tradeFeedContainer.id
      }
    }
    codeReference: 'trade-processor/Dockerfile.compose'
  }
}

resource tradeServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-service'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      tradeService: {
        image: tradeServiceImage.properties.imageReference
        ports: {
          web: {
            containerPort: 18092
          }
        }
        env: {
          TRADING_SERVICE_PORT: {
            value: '18092'
          }
          ACCOUNT_SERVICE_HOST: {
            value: 'account-service'
          }
          REFERENCE_DATA_HOST: {
            value: 'reference-data'
          }
          PEOPLE_SERVICE_HOST: {
            value: 'people-service'
          }
          TRADE_FEED_HOST: {
            value: 'trade-feed'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
        }
      }
    }
    connections: {
      account: {
        source: accountServiceContainer.id
      }
      referencedata: {
        source: referenceDataContainer.id
      }
      people: {
        source: peopleServiceContainer.id
      }
      tradefeed: {
        source: tradeFeedContainer.id
      }
      tradeprocessor: {
        source: tradeProcessorContainer.id
      }
    }
    codeReference: 'trade-service/Dockerfile.compose'
  }
}

resource webFrontendContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'web-front-end-angular'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      frontend: {
        image: webFrontendImage.properties.imageReference
        ports: {
          web: {
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
      account: {
        source: accountServiceContainer.id
      }
      referencedata: {
        source: referenceDataContainer.id
      }
      trade: {
        source: tradeServiceContainer.id
      }
      position: {
        source: positionServiceContainer.id
      }
      people: {
        source: peopleServiceContainer.id
      }
      tradefeed: {
        source: tradeFeedContainer.id
      }
    }
    codeReference: 'web-front-end/angular/Dockerfile.compose'
  }
}

resource ingressContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'ingress'
  properties: {
    environment: environment
    application: traderXApp.id
    containers: {
      ingress: {
        image: ingressImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          NGINX_HOST: {
            value: 'localhost'
          }
          DATABASE_URL: {
            value: 'http://database:18084/'
          }
          REFERENCE_DATA_URL: {
            value: 'http://reference-data:18085/'
          }
          TRADE_FEED_URL: {
            value: 'http://trade-feed:18086/'
          }
          PEOPLE_SERVICE_URL: {
            value: 'http://people-service:18089/'
          }
          ACCOUNT_SERVICE_URL: {
            value: 'http://account-service:18088/'
          }
          POSITION_SERVICE_URL: {
            value: 'http://position-service:18090/'
          }
          TRADE_PROCESSOR_URL: {
            value: 'http://trade-processor:18091/'
          }
          TRADE_SERVICE_URL: {
            value: 'http://trade-service:18092/'
          }
          WEB_FRONTEND_URL: {
            value: 'http://web-front-end-angular:18093/'
          }
        }
      }
    }
    connections: {
      database: {
        source: databaseContainer.id
      }
      referencedata: {
        source: referenceDataContainer.id
      }
      tradefeed: {
        source: tradeFeedContainer.id
      }
      people: {
        source: peopleServiceContainer.id
      }
      account: {
        source: accountServiceContainer.id
      }
      position: {
        source: positionServiceContainer.id
      }
      tradeprocessor: {
        source: tradeProcessorContainer.id
      }
      trade: {
        source: tradeServiceContainer.id
      }
      frontend: {
        source: webFrontendContainer.id
      }
    }
    codeReference: 'ingress/Dockerfile.compose'
  }
}

resource ingressRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'ingress-route'
  properties: {
    environment: environment
    application: traderXApp.id
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
    codeReference: 'ingress/nginx.traderx.conf.template'
  }
}
