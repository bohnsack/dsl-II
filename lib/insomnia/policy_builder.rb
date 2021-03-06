require_relative 'activity'
require_relative 'constraint'
require_relative 'restrict'
require_relative 'policy'
require_relative 'policy_context'

class PolicyBuilder

  def initialize(&block)
    @activities = {}
    @restrictions = []
    @policies = []
    instance_exec(&block)
  end

  def activity(name, &b)
    activity = Activity.new(name, &b)
    @activities[name] = activity
    activity
  end

  def constraint(&b)
    Constraint.new(&b)
  end

  def restrict(*activities, &b)
    restriction = Restrict.new(activities, &b)
    @restrictions.push(restriction)
    restriction
  end

  def policy(&b)
    policy = Policy.new(&b)
    @policies.push(policy)
    policy    
  end

  def context
    PolicyContext.new(@activities, @restrictions, @policies)
  end

end
