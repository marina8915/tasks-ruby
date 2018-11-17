# frozen_string_literal: true

require 'tasks'

class HomeController < ApplicationController
  attr_reader :tasks_num

  def index
    tasks
  end

  def tasks
    method_name = 'task_'
    methods = Tasks::Task.methods(false)
    @tasks_num = methods.select { |elem| elem.to_s.include? method_name }
    @tasks_num.map! { |elem| elem.to_s.delete method_name }
    @tasks_num.map!(&:to_i).sort!
  end
end
