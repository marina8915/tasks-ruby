# frozen_string_literal: true

require 'tasks'
require 'home_controller'

class TasksController < ApplicationController
  attr_reader :rez

  def task
    id
    @params = method_params
  end

  def result
    @tasks_array = HomeController.new.tasks
    result = read_result
    @rez = if @tasks_array.include? id
             Tasks::Task.public_send("task_#{id}", result)
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

  def data_form(value)
    params[value].to_f
  end

  def get_values(array)
    value_array = []
    array.each do |label|
      value = data_form(label)
      value_array.push(value)
    end
    value_array
  end

  def read_result
    params_array = method_params
    value_array = get_values(params_array)
    result = Hash.new({})

    params_array.size.times do |elem|
      result[params_array[elem]] = value_array[elem]
    end
    result
  end
end
