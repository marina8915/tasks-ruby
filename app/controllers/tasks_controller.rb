# frozen_string_literal: true

require 'tasks'
require 'breadcrumbs_on_rails'

class TasksController < ApplicationController
  attr_reader :rez, :tasks_num

  add_breadcrumb "home", :root_path

  def index
    all_tasks
  end

  def all_tasks
    method_name = 'task_'
    methods = Tasks::Task.methods(false)
    @tasks_num = methods.select { |elem| elem.to_s.include? method_name }
    @tasks_num.map! { |elem| elem.to_s.delete method_name }
    @tasks_num.map!(&:to_i).sort!
  end

  def task
    id
    @params = method_params
    @conditions = Tasks::Task.conditions(num: id)
  end

  def result
    add_breadcrumb "task #{id}", :task_path
    @tasks_array = all_tasks
    @rez = if @tasks_array.include? id
             if method_params.size.zero?
               Tasks::Task.public_send("task_#{id}")
             else
               @data_form = read_form
               Tasks::Task.public_send("task_#{id}", @data_form)
             end
           else
             '404'
           end
  end

  def id
    @id = task_path.delete '/tasks/'
    @id.to_i
  end

  def method_params
    Tasks::Task.method("task_#{id}").parameters.map(&:last)
  end

  def get_values(array)
    value_array = []
    array.each do |label|
      value_array.push(params[label].to_f)
    end
    value_array
  end

  def read_form
    params_array = method_params
    value_array = get_values(params_array)
    result = Hash.new({})

    params_array.size.times do |elem|
      result[params_array[elem]] = value_array[elem]
    end
    result
  end
end
