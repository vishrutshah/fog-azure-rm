module Fog
  module Network
    class AzureRM
      # NetworkInterfaces collection class for Network Service
      class NetworkInterfaces < Fog::Collection
        model Fog::Network::AzureRM::NetworkInterface
        attribute :resource_group

        def all
          requires :resource_group
          network_interfaces = []
          service.list_network_interfaces(resource_group).each do |nic|
            network_interfaces << Fog::Network::AzureRM::NetworkInterface.parse(nic)
          end
          load(network_interfaces)
        end

        def get(resource_group_name, name)
          network_interface_card = service.get_network_interface(resource_group_name, name)
          network_interface_card_fog = Fog::Network::AzureRM::NetworkInterface.new(service: service)
          network_interface_card_fog.merge_attributes(Fog::Network::AzureRM::NetworkInterface.parse(network_interface_card))
        end
      end
    end
  end
end
