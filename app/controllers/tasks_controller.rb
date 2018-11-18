# frozen_string_literal: true

require 'tasks'
require 'home_controller'

class TasksController < ApplicationController
  attr_reader :rez, :id

  def task
    @id = task_path.delete '/tasks/'
    @id.to_i

    @params = number_method_params(id: @id).size
  end

  def result
    @tasks_array = HomeController.new.tasks
    @id = params[:id].to_i
    result = read_result(@id)
    @rez = if @tasks_array.include? @id
             method = "task_#{id}"
             Tasks::Task.public_send(method, result)
           else
             '404'
           end
  end

  def number_method_params(id:)
    Tasks::Task.method("task_#{id}").parameters
  end

  def data_form(value)
    params[value].to_f
  end

  def get_args(id)
    number_method_params(id: id).map(&:last)
  end

  def get_values(array)
    value_array = []
    array.each_index do |num|
      num += 1
      value = data_form("value_#{num}".to_sym)
      value_array.push(value)
    end
    value_array
  end

  def read_result(id)
    params_array = get_args(id)
    value_array = get_values(params_array)
    result = Hash.new({})
    params_array.size.times do |elem|
      result[params_array[elem]] = value_array[elem]
    end
    result
  end
end
