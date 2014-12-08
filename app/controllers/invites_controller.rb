class InvitesController < ApplicationController
  def resend
    @invite = Invite.find(params[:id])

    InviteMailer.new_invite(@invite).deliver

    head :ok
  end
end
