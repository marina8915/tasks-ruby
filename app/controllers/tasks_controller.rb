# frozen_string_literal: true

require 'tasks'
require 'home_controller'

class TasksController < ApplicationController
  attr_reader :rez

  def task; end

  def result
    id = params[:id].to_i
    @tasks_array = HomeController.new.tasks

    @rez = if @tasks_array.include? id
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
