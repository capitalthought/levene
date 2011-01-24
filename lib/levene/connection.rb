module Levene
  class Connection

    def login(username, password)
      login_result = self.binding.login username, password
      true
    rescue
      false
    end

    def binding
      @binding ||= ::Levene.enabled? ? ::RForce::Binding.new('https://login.salesforce.com/services/Soap/u/20.0') : DummyBinding.new
    end

    def start
      yield binding
      logout
    end

    def logout
      self.binding.logout
      @binding = nil
    end

    def has_session?
      !self.binding.instance_variable_get("@session_id").nil?
    end

  end

  class DummyBinding
    def describe(model)
      []
    end

    def method_missing(sym, *args)
      #pass
    end
  end
end
