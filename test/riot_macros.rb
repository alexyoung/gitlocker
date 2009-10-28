module Custom
  module AssertionMacros
    def empty?
      length == 0 || fail("expected an empty collection, but got a #{actual.class.name} with #{actual.length rescue 0} items")
    end

    def any?
      length > 0 || fail("expected an array of items")
    end

    def length
      actual.respond_to?(:length) && actual.length || fail("#{actual.class.name} does not respond to length")
    end
  end

  module Macros
    def asserts_response_status(expected)
      asserts("response status is #{expected}") do
        last_response.status
      end.equals(expected)
    end

    def asserts_response_equals(expected)
      asserts("response equals #{expected}") do
        last_response.body
      end.equals(expected)
    end
  end
end

Riot::Assertion.instance_eval { include Custom::AssertionMacros }
Riot::Context.instance_eval   { include Custom::Macros }

