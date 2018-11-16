require 'tasks'

class TasksController < ApplicationController
  attr_reader :rez

  def task_1
  end

  def result_1
    number_b = params[:number_b].to_i
    number_a = params[:number_a].to_i
    @rez = Tasks::Task.task_1(number_b: number_b, number_a: number_a)
  end
end
