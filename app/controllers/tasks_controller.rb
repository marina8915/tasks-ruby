# frozen_string_literal: true

require 'tasks'

class TasksController < ApplicationController
  attr_reader :rez, :tasks_num

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
    @params = method_params
    @conditions = Tasks::Task.conditions(num: params[:id])
  end

  def result
    @rez = if method_params.empty?
             Tasks::Task.public_send("task_#{params[:id]}")
           else
             @data_form = read_form
             Tasks::Task.public_send("task_#{params[:id]}", @data_form)
           end
  end

  private

  def method_params
    Tasks::Task.method("task_#{params[:id]}").parameters.map(&:last)
  end

  def get_values(array)
    value_array = []
    array.each do |label|
      value_array.push(params[label].to_f)
    end
    value_array
  end

  def read_form
    value_array = get_values(method_params)
    result = {}

    method_params.each_with_index do |_, index|
      result[method_params[index]] = value_array[index]
    end
    result
  end
end
