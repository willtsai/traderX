extension radius

@secure()
param databasePassword string
param environment string
@secure()
param registryPassword string
@secure()
param registryUsername string

resource traderxApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'traderx'
  properties: {
    environment: environment
  }
}

resource databaseCredentials 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'database-credentials'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'database/run.sh#L8'
    data: {
      password: {
        value: databasePassword
      }
    }
  }
}

resource registryCredentials 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: '.github/workflows/build-and-publish.yml#L67'
    data: {
      password: {
        value: registryPassword
      }
      username: {
        value: registryUsername
      }
    }
  }
}

resource accountServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'account-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'account-service/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//account-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource databaseImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'database-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'database/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//database?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource ingressImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'ingress-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'ingress/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//ingress?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource peopleServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'people-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'people-service/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//people-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource positionServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'position-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'position-service/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//position-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource referenceDataImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'reference-data-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'reference-data/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//reference-data?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource tradeFeedImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-feed-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-feed/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-feed?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource tradeProcessorImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-processor-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-processor/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-processor?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource tradeServiceImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'trade-service-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-service/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//trade-service?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource webFrontEndAngularImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'web-front-end-angular-image'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'web-front-end/angular/Dockerfile.compose#L1'
    tag: '8e9ef3db767a'
    build: {
      source: 'git::https://github.com/willtsai/traderX.git//web-front-end/angular?ref=8e9ef3db767a506b8eb583c13229bf0e6aaa1ac0'
      dockerfile: 'Dockerfile.compose'
      platforms: [
        'linux/amd64'
        'linux/arm64'
      ]
    }
  }
  dependsOn: [
    registryCredentials
  ]
}

resource accountServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'account-service'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'account-service/src/main/java/finos/traderx/accountservice/AccountServiceApplication.java#L9'
    containers: {
      'account-service': {
        image: accountServiceImage.properties.imageReference
        env: {
          ACCOUNT_SERVICE_PORT: {
            value: '18088'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          DATABASE_DBPASS: {
            valueFrom: {
              secretKeyRef: {
                secretName: databaseCredentials.name
                key: 'password'
              }
            }
          }
          DATABASE_DBUSER: {
            value: 'sa'
          }
          DATABASE_NAME: {
            value: 'traderx'
          }
          DATABASE_TCP_HOST: {
            value: databaseContainer.properties.hosts[databaseContainer.name]
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          PEOPLE_SERVICE_URL: {
            value: 'http://${peopleServiceContainer.properties.hosts[peopleServiceContainer.name]}:18089'
          }
        }
        ports: {
          web: {
            containerPort: 18088
          }
        }
      }
    }
  }
}

resource databaseContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'database'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'database/run.sh#L28'
    containers: {
      database: {
        image: databaseImage.properties.imageReference
        env: {
          DATABASE_DBNAME: {
            value: 'traderx'
          }
          DATABASE_DBPASS: {
            valueFrom: {
              secretKeyRef: {
                secretName: databaseCredentials.name
                key: 'password'
              }
            }
          }
          DATABASE_DBUSER: {
            value: 'sa'
          }
          DATABASE_PG_PORT: {
            value: '18083'
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          DATABASE_WEB_HOSTNAMES: {
            value: 'database-database'
          }
          DATABASE_WEB_PORT: {
            value: '18084'
          }
        }
        ports: {
          pg: {
            containerPort: 18083
          }
          tcp: {
            containerPort: 18082
          }
          web: {
            containerPort: 18084
          }
        }
      }
    }
  }
}

resource ingressContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'ingress'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'ingress/nginx.traderx.conf.template#L1'
    containers: {
      ingress: {
        image: ingressImage.properties.imageReference
        env: {
          ACCOUNT_SERVICE_URL: {
            value: 'http://${accountServiceContainer.properties.hosts[accountServiceContainer.name]}:18088/'
          }
          DATABASE_URL: {
            value: 'http://${databaseContainer.properties.hosts[databaseContainer.name]}:18084/'
          }
          NGINX_HOST: {
            value: '_'
          }
          PEOPLE_SERVICE_URL: {
            value: 'http://${peopleServiceContainer.properties.hosts[peopleServiceContainer.name]}:18089/'
          }
          POSITION_SERVICE_URL: {
            value: 'http://${positionServiceContainer.properties.hosts[positionServiceContainer.name]}:18090/'
          }
          REFERENCE_DATA_URL: {
            value: 'http://${referenceDataContainer.properties.hosts[referenceDataContainer.name]}:18085/'
          }
          TRADE_FEED_URL: {
            value: 'http://${tradeFeedContainer.properties.hosts[tradeFeedContainer.name]}:18086/'
          }
          TRADE_PROCESSOR_URL: {
            value: 'http://${tradeProcessorContainer.properties.hosts[tradeProcessorContainer.name]}:18091/'
          }
          TRADE_SERVICE_URL: {
            value: 'http://${tradeServiceContainer.properties.hosts[tradeServiceContainer.name]}:18092/'
          }
          WEB_FRONTEND_URL: {
            value: 'http://${webFrontEndAngularContainer.properties.hosts[webFrontEndAngularContainer.name]}:18093/'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource peopleServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'people-service'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'people-service/PeopleService.WebApi/Program.cs#L43'
    containers: {
      'people-service': {
        image: peopleServiceImage.properties.imageReference
        env: {
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          PEOPLE_SERVICE_PORT: {
            value: '18089'
          }
        }
        ports: {
          web: {
            containerPort: 18089
          }
        }
      }
    }
  }
}

resource positionServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'position-service'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'position-service/src/main/java/finos/traderx/positionservice/PositionServiceApplication.java#L9'
    containers: {
      'position-service': {
        image: positionServiceImage.properties.imageReference
        env: {
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          DATABASE_DBPASS: {
            valueFrom: {
              secretKeyRef: {
                secretName: databaseCredentials.name
                key: 'password'
              }
            }
          }
          DATABASE_DBUSER: {
            value: 'sa'
          }
          DATABASE_NAME: {
            value: 'traderx'
          }
          DATABASE_TCP_HOST: {
            value: databaseContainer.properties.hosts[databaseContainer.name]
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          POSITION_SERVICE_PORT: {
            value: '18090'
          }
        }
        ports: {
          web: {
            containerPort: 18090
          }
        }
      }
    }
  }
}

resource referenceDataContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'reference-data'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'reference-data/src/main.ts#L19'
    containers: {
      'reference-data': {
        image: referenceDataImage.properties.imageReference
        env: {
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          REFERENCE_DATA_SERVICE_PORT: {
            value: '18085'
          }
        }
        ports: {
          web: {
            containerPort: 18085
          }
        }
      }
    }
  }
}

resource tradeFeedContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-feed'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-feed/index.js#L93'
    containers: {
      'trade-feed': {
        image: tradeFeedImage.properties.imageReference
        env: {
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          TRADE_FEED_PORT: {
            value: '18086'
          }
        }
        ports: {
          web: {
            containerPort: 18086
          }
        }
      }
    }
  }
}

resource tradeProcessorContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-processor'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-processor/src/main/java/finos/traderx/tradeprocessor/TradeProcessorApplication.java#L9'
    containers: {
      'trade-processor': {
        image: tradeProcessorImage.properties.imageReference
        env: {
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          DATABASE_DBPASS: {
            valueFrom: {
              secretKeyRef: {
                secretName: databaseCredentials.name
                key: 'password'
              }
            }
          }
          DATABASE_DBUSER: {
            value: 'sa'
          }
          DATABASE_NAME: {
            value: 'traderx'
          }
          DATABASE_TCP_HOST: {
            value: databaseContainer.properties.hosts[databaseContainer.name]
          }
          DATABASE_TCP_PORT: {
            value: '18082'
          }
          TRADE_FEED_ADDRESS: {
            value: 'http://${tradeFeedContainer.properties.hosts[tradeFeedContainer.name]}:18086'
          }
          TRADE_PROCESSOR_SERVICE_PORT: {
            value: '18091'
          }
        }
        ports: {
          web: {
            containerPort: 18091
          }
        }
      }
    }
  }
}

resource tradeServiceContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'trade-service'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'trade-service/src/main/java/finos/traderx/tradeservice/TradeServiceApplication.java#L9'
    containers: {
      'trade-service': {
        image: tradeServiceImage.properties.imageReference
        env: {
          ACCOUNT_SERVICE_URL: {
            value: 'http://${accountServiceContainer.properties.hosts[accountServiceContainer.name]}:18088'
          }
          CORS_ALLOWED_ORIGINS: {
            value: '*'
          }
          PEOPLE_SERVICE_URL: {
            value: 'http://${peopleServiceContainer.properties.hosts[peopleServiceContainer.name]}:18089'
          }
          REFERENCE_DATA_SERVICE_URL: {
            value: 'http://${referenceDataContainer.properties.hosts[referenceDataContainer.name]}:18085'
          }
          TRADING_SERVICE_PORT: {
            value: '18092'
          }
          TRADE_FEED_ADDRESS: {
            value: 'http://${tradeFeedContainer.properties.hosts[tradeFeedContainer.name]}:18086'
          }
        }
        ports: {
          web: {
            containerPort: 18092
          }
        }
      }
    }
  }
}

resource webFrontEndAngularContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'web-front-end-angular'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'web-front-end/angular/main/main.ts#L11'
    containers: {
      'web-front-end-angular': {
        image: webFrontEndAngularImage.properties.imageReference
        ports: {
          web: {
            containerPort: 18093
          }
        }
      }
    }
  }
}

resource ingressRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'ingress'
  properties: {
    environment: environment
    application: traderxApp.id
    codeReference: 'RUN_FROM_CLONE.md#L14'
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
  }
}
