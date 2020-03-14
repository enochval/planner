require 'spec_helper'

RSpec.describe VirtualWorkshopInvitationMailer, type: :mailer do
  let(:email) { ActionMailer::Base.deliveries.last }
  let(:workshop) { Fabricate(:workshop) }
  let(:member) { Fabricate(:member) }
  let(:invitation) { Fabricate(:workshop_invitation, workshop: workshop, member: member) }

  it '#attending' do
    email_subject = "Attendance Confirmation: Virtual workshop for #{workshop.chapter.name} " \
                    "- #{humanize_date(workshop.date_and_time)}"

    VirtualWorkshopInvitationMailer.attending(workshop, member, invitation).deliver_now

    expect(email.subject).to eq(email_subject)
    expect(email.body.encoded).to match(workshop.chapter.email)
    expect(email.body.encoded).to match('How to join the virtual workshop')
  end
end
