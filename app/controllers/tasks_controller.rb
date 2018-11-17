require 'tasks'

class TasksController < ApplicationController
  attr_reader :rez
  TASKS = [1, 2, 3, 6]

  def display

  end

  def result
    id = params[:id].to_i
    @rez = if TASKS.include? id
           method = "task_#{id}"
           public_send(method)
           else
             '404'
           end
  end

  def task_1
    number_b = params[:number_b].to_f
    number_a = params[:number_a].to_f
    Tasks::Task.task_1(number_b: number_b, number_a: number_a)
  end

  def task_2
    number_b = params[:number_b].to_f
    number_a = params[:number_a].to_f
    Tasks::Task.task_2(number_b: number_b, number_a: number_a)
  end
end
