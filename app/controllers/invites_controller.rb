class InvitesController < ApplicationController
  def resend
    @invite = Invite.find(params[:id])

    InviteMailer.new_invite(@invite).deliver_now

    head :ok
  end
end
