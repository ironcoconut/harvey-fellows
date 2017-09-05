class FellowsController < ApplicationController
  include ActionView::Helpers::TextHelper

  Event = Struct.new(:text, :url)

  def index
    @fellows = Fellow.all
    @contributions = Contribution.group(:fellow_id).sum(:amount)
  end

  def show
    @fellow = Fellow.find(params[:id])
    @raised = Contribution.where(fellow_id: @fellow).sum(:amount)
    @contribution = Contribution.new(fellow: @fellow)
    map_events
  end

  private

  def github
    @github = Github.new
  end

  def map_events
    @events = github.activity.events.performed(@fellow.login).map do |event|
      next nil if "sketch-city" != (event.org && event.org.login)
      case event.type
      when "IssuesEvent"
        Event.new("#{event.payload.action.capitalize} issue \"#{truncate(event.payload.issue.title)}\"", event.payload.issue.html_url)
      when "IssueCommentEvent"
        Event.new("Commented, \"#{ truncate(event.payload.comment.body, length: 50) }\", on issue \"#{ truncate(event.payload.issue.title) }\"", event.payload.comment.html_url)
      when "PushEvent"
        event.payload.commits.map(&method(:process_commit))
      when "PullRequestEvent"
        url = map_url(event.payload.pull_request.url)
        Event.new("#{event.payload.action.capitalize} a request to add code, \"#{event.payload.pull_request.title}\"", url)
      when "CreateEvent"
        Event.new("Created a new #{event.payload.ref_type}, \"#{event.payload.ref.titlecase}\"", map_url(event.repo.url))
      else
        Event.new(event.type, map_url(event.repo.url))
      end
    end.flatten.compact
  end

  def process_commit(commit)
    return nil if commit.author.name != @fellow.name
    url = map_url(commit.url)

    Event.new(truncate(commit.message), url)
  end

  def map_url(url)
    url.gsub('api.github','github').gsub('/commits/','/commit/').gsub('/repos/','/').gsub('/pulls/', '/pull/')
  end
end
