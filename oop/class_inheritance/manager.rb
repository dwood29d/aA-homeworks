require_relative 'employee'

class Manager < Employee
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    self.subsalary * multiplier
  end

  def add_employee(employee)
    @employees << employee

    employee
  end

  def subsalary
    salary = 0

    @employees.each do |employee|
      salary += employee.salary
      if employee.is_a?(Manager)
        salary += employee.subsalary
      end
    end

    salary
  end
end
