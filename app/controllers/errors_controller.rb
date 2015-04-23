class ErrorsController < ApplicationController
  def show
    @exception = env["action_dispatch.exception"]
    rnder request.path[1..-1]
  end
end
