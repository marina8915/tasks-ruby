# frozen_string_literal: true

require 'tasks'
require 'home_controller'

class TasksController < ApplicationController
  attr_reader :rez, :id

  def task
    @id = task_path.delete '/tasks/'
    @id.to_i

    @params = number_method_params(id: @id)
  end

  def result
    @tasks_array = HomeController.new.tasks
    @id = params[:id].to_i
    @rez = if @tasks_array.include? @id
             method = "task_#{id}"
             public_send(method)
           else
             '404'
           end
  end

  def number_method_params(id:)
    Tasks::Task.method("task_#{id}").parameters.size
  end

  def data_form(value)
    params[value]
  end

  def task_1
    number_b = data_form('value_1').to_f
    number_a = data_form('value_2').to_f
    Tasks::Task.task_1(number_b: number_b, number_a: number_a)
  end

  def task_2
    number_b = data_form('value_1').to_f
    number_a = data_form('value_2').to_f
    Tasks::Task.task_2(number_b: number_b, number_a: number_a)
  end

  def task_3
    length = data_form('value_1').to_f
    Tasks::Task.task_3(edge_length: length)
  end

  def task_6
    cathetus_a = data_form('value_1').to_f
    cathetus_b = data_form('value_2').to_f
    Tasks::Task.task_6(cathetus_a: cathetus_a, cathetus_b: cathetus_b)
  end

  def task_8
    n = data_form('value_1').to_f
    radius = data_form('value_2').to_f
    Tasks::Task.task_8(n_corners: n, radius: radius)
  end

  def task_606
    side_a = data_form('value_1').to_f
    side_b = data_form('value_2').to_f
    side_c = data_form('value_1').to_f
    side_d = data_form('value_2').to_f
    Tasks::Task.task_606(side_a: side_a, side_b: side_b, side_c: side_c, side_d: side_d)
  end
end
