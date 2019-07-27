# frozen_string_literal: true

module TvmazeWrapper
  module Order
    # Get all created orders.  
    # This method will perfom a Get request to v1/public/orders
    #
    # @return [String Hash] response of get request execution.
    def orders
      get('v1/public/orders')
    end

    # Create SuperDispatch order. Optionally you can send it to Central Dispatch too.  
    # This method will perfom a Post request to v1/public/orders.  
    # If Central Dispatch flag is true will perform a Post request to v1/public/orders/:order_id/post_to_cd
    #
    # @param payload [Symbol Hash] request body to send.
    # @param central_dispatch [Boolean] flag param to decide if should send order to central dispatch.
    # @return [String Hash] response of post request execution on order creation.
    def create_order(payload, central_dispatch: false)
      order = post('v1/public/orders', payload)

      post_order_to_cd(order['data']['object']['guid']) if central_dispatch

      order
    end

    # Get order in base of an Order GUID.  
    # This method will perfom a Post request to v1/public/orders/:order_id.
    #
    # @param order_id [String] order GUID.
    # @return [String Hash] response of get request execution.
    def order(order_id)
      get("v1/public/orders/#{order_id}")
    end

    # Update an existing order.  
    # This method will perfom a PUT request to v1/public/orders/:order_id.
    #
    # @param order_id [String] order GUID.
    # @param params [String Hash] params to update.
    # @return [String Hash] response of put request execution.
    def update_order(order_id, params)
      body = order(order_id)['object'].merge!(params) # TODO: Check if we need recalculate body of order
      put("v1/public/orders/#{order_id}", body)
    end

    # Delete an existing order.  
    # This method will perfom a DELETE request to v1/public/orders/:order_id.
    #
    # @param order_id [String] order GUID.
    # @return [String Hash] response of delete request execution.
    def delete_order(order_id)
      delete("v1/public/orders/#{order_id}")
    end

    # Post an existing order to Central Dispatch.  
    # This method will perfom a PUT request to v1/public/orders/:order_id/post_to_cd.
    #
    # @param order_id [String] order GUID.
    # @return [String Hash] response of put request execution.
    def post_order_to_cd(order_id)
      post("v1/public/orders/#{order_id}/post_to_cd")
    end

    # Remove an order posted on Central Dispatch.  
    # This method will perfom a PUT request to v1/public/orders/:remove_from_cd.
    #
    # @param order_id [String] order GUID.
    # @return [String Hash] response of put request execution.
    def remove_order_from_cd(order_id)
      delete("v1/public/orders/#{order_id}/remove_from_cd")
    end
  end
end
