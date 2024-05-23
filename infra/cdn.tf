resource "azurerm_frontdoor" "main" {
	name                 = "front-door"
	resource_group_name  = data.azurerm_resource_group.main.name

	routing_rule {
		name               = "routing-rule"
		accepted_protocols = ["Http", "Https"]
		patterns_to_match  = ["/*"]
		frontend_endpoints = ["frontend-endpoint"]
		forwarding_configuration {
			forwarding_protocol = "MatchRequest"
			backend_pool_name   = "backend-pool"
		}
	}

	backend_pool_load_balancing {
		name = "mainLoadBalancingSettings"
	}

	backend_pool_health_probe {
		name = "mainHealthProbeSetting"
	}

	backend_pool {
		name = "backend-pool"
		backend {
			host_header = "orders.music.bcc.no"
			address     = "orders.music.bcc.no"
			http_port   = 80
			https_port  = 443
		}

		load_balancing_name = "mainLoadBalancingSettings"
		health_probe_name   = "mainHealthProbeSetting"
	}

	frontend_endpoint {
		name        = "frontend-endpoint"
		host_name   = "front-door.azurefd.net"
	}
}

resource "azurerm_frontdoor_custom_https_configuration" "main" {
	frontend_endpoint_id = azurerm_frontdoor.main.frontend_endpoints[0].id
	custom_https_provisioning_enabled = true

	custom_https_configuration {
		certificate_source = "FrontDoor"
		minimum_tls_version = "1.2"
	}
}